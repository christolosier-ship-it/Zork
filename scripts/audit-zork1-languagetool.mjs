import { writeFile } from 'node:fs/promises';
import { readFile } from 'node:fs/promises';
import { literaryCorrections } from '../translations/game-reviews/zork1-literary-pass.fr.mjs';

const review = JSON.parse(await readFile('translations/game-reviews/zork1.fr.json', 'utf8'));
const reviewedOnly = process.argv.includes('--reviewed-only');
const normalizedPrefixes = literaryCorrections.map(({ startsWith }) =>
  startsWith?.replace(/\s+/g, ' ').trim(),
);
const exactSources = new Set(literaryCorrections.map(({ source }) => source).filter(Boolean));
const selectedEntries = Object.entries(review.translations).filter(([source]) => {
  if (!reviewedOnly) return true;
  const normalizedSource = source.replace(/\s+/g, ' ').trim();
  return (
    exactSources.has(source) ||
    normalizedPrefixes.some((prefix) => prefix && normalizedSource.startsWith(prefix))
  );
});
const records = selectedEntries.map(([source, target], index) => ({
  index,
  source,
  target: target.replaceAll('|', '\n'),
}));
const reportPath = process.env.ZORK_LT_REPORT ?? '/tmp/zork1-languagetool-audit.json';
const maxBatchCharacters = 6000;
const delayMilliseconds = 9000;

async function checkText(text, attempt = 1) {
  const body = new URLSearchParams({ language: 'fr-FR', text });
  const response = await fetch('https://api.languagetool.org/v2/check', {
    method: 'POST',
    headers: { 'content-type': 'application/x-www-form-urlencoded;charset=UTF-8' },
    body,
  });
  if (response.ok) return response.json();
  if (attempt >= 4 || response.status < 500) {
    throw new Error(`LanguageTool : HTTP ${response.status}`);
  }
  await new Promise((resolve) => setTimeout(resolve, 3000 * attempt));
  return checkText(text, attempt + 1);
}

const batches = [];
let batch = [];
let size = 0;
for (const record of records) {
  const addition = record.target.length + 2;
  if (batch.length && size + addition > maxBatchCharacters) {
    batches.push(batch);
    batch = [];
    size = 0;
  }
  batch.push(record);
  size += addition;
}
if (batch.length) batches.push(batch);

const issues = [];
for (let batchIndex = 0; batchIndex < batches.length; batchIndex += 1) {
  const current = batches[batchIndex];
  let text = '';
  const ranges = [];
  for (const record of current) {
    if (text) text += '\n\n';
    const start = text.length;
    text += record.target;
    ranges.push({ start, end: text.length, record });
  }

  const result = await checkText(text);
  for (const match of result.matches ?? []) {
    const range = ranges.find(({ start, end }) => match.offset >= start && match.offset < end);
    if (!range) continue;
    issues.push({
      index: range.record.index,
      source: range.record.source,
      target: range.record.target,
      localOffset: match.offset - range.start,
      length: match.length,
      message: match.message,
      ruleId: match.rule?.id,
      category: match.rule?.category?.id,
      replacements: (match.replacements ?? []).slice(0, 8).map(({ value }) => value),
      excerpt: match.context?.text,
    });
  }
  console.log(`LanguageTool : lot ${batchIndex + 1}/${batches.length} contrôlé.`);
  if (batchIndex + 1 < batches.length) {
    await new Promise((resolve) => setTimeout(resolve, delayMilliseconds));
  }
}

await writeFile(
  reportPath,
  `${JSON.stringify({ generatedAt: new Date().toISOString(), records: records.length, issues }, null, 2)}\n`,
);
console.log(`LanguageTool : ${records.length} chaînes, ${issues.length} signalements (${reportPath}).`);
