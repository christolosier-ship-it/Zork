import { createHash } from 'node:crypto';
import { mkdir, readFile, writeFile } from 'node:fs/promises';
import path from 'node:path';

const game = process.argv[2];
if (!/^zork[123]$/.test(game ?? '')) {
  throw new Error('Usage : node scripts/bootstrap-game-review.mjs zork1');
}

const gameFiles = {
  zork1: [
    'zork1.zil',
    'gmacros.zil',
    'gsyntax.zil',
    '1dungeon.zil',
    'gglobals.zil',
    'gclock.zil',
    'gmain.zil',
    'gparser.zil',
    'gverbs.zil',
    '1actions.zil',
  ],
  zork2: [
    'zork2.zil',
    'gmacros.zil',
    'gsyntax.zil',
    '2dungeon.zil',
    'gglobals.zil',
    'gclock.zil',
    'gmain.zil',
    'gparser.zil',
    'gverbs.zil',
    '2actions.zil',
  ],
  zork3: [
    'zork3.zil',
    'gsyntax.zil',
    'gmacros.zil',
    'gclock.zil',
    'gmain.zil',
    'gparser.zil',
    '3dungeon.zil',
    'gglobals.zil',
    'gverbs.zil',
    '3actions.zil',
  ],
};

const skippedOperators = new Set(['INSERT-FILE', 'SNAME', 'STRING']);
const skippedValues = new Set(['OPTIONAL']);

function isEscaped(text, index) {
  let slashes = 0;
  for (let cursor = index - 1; cursor >= 0 && text[cursor] === '\\'; cursor -= 1) {
    slashes += 1;
  }
  return slashes % 2 === 1;
}

function operatorBefore(text, index) {
  const window = text.slice(Math.max(0, index - 240), index);
  const lastOpen = window.lastIndexOf('<');
  const lastClose = window.lastIndexOf('>');
  if (lastOpen < 0 || lastClose > lastOpen) return null;
  return window.slice(lastOpen + 1).match(/^\s*([A-Z0-9?!&-]+)/i)?.[1]?.toUpperCase() ?? null;
}

function isCommentedString(text, index) {
  let cursor = index - 1;
  while (cursor >= 0 && /\s/.test(text[cursor])) cursor -= 1;
  return text[cursor] === ';';
}

function collectStrings(text) {
  const strings = [];
  for (let index = 0; index < text.length; index += 1) {
    if (text[index] !== '"' || isEscaped(text, index)) continue;
    let end = index + 1;
    while (end < text.length && (text[end] !== '"' || isEscaped(text, end))) end += 1;
    if (end >= text.length) throw new Error('Chaîne ZIL non terminée.');
    const value = text
      .slice(index + 1, end)
      .replace(/\\"/g, '"')
      .replace(/\\\\/g, '\\');
    const operator = operatorBefore(text, index);
    if (
      !isCommentedString(text, index) &&
      !skippedOperators.has(operator) &&
      !skippedValues.has(value) &&
      /[A-Za-z]/.test(value) &&
      value.trim().length > 0
    ) {
      strings.push(value);
    }
    index = end;
  }
  return strings;
}

const catalog = JSON.parse(await readFile('translations/catalog.fr.json', 'utf8'));
const sources = new Set();
const files = {};
for (const file of gameFiles[game]) {
  const text = await readFile(`translations/zil/en/${game}/${file}`, 'utf8');
  const fileSources = collectStrings(text);
  files[file] = [...new Set(fileSources)].length;
  for (const source of fileSources) sources.add(source);
}

const orderedSources = [...sources].sort((left, right) => left.localeCompare(right, 'en'));
const translations = Object.fromEntries(
  orderedSources.map((source) => {
    const target = catalog.translations[source];
    if (typeof target !== 'string') throw new Error(`Traduction absente : ${source}`);
    return [source, target];
  }),
);
const sourceSha256 = createHash('sha256').update(JSON.stringify(orderedSources)).digest('hex');
const destination = `translations/game-reviews/${game}.fr.json`;
await mkdir(path.dirname(destination), { recursive: true });
await writeFile(
  destination,
  `${JSON.stringify(
    {
      meta: {
        game,
        language: 'fr-FR',
        sourceLanguage: 'en',
        sourceCount: orderedSources.length,
        sourceSha256,
        files,
        reviewStatus: 'in_progress',
      },
      translations,
    },
    null,
    2,
  )}\n`,
);
console.log(`${game} : ${orderedSources.length} chaînes copiées dans ${destination}.`);
