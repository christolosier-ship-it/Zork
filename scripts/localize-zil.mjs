import { cp, mkdir, readFile, rm, writeFile } from 'node:fs/promises';
import path from 'node:path';
import process from 'node:process';
import { fileURLToPath } from 'node:url';

const ROOT = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const SOURCE_ROOT = path.join(ROOT, 'translations', 'zil', 'en');
const OUTPUT_ROOT = path.join(ROOT, 'translations', 'zil', 'fr');
const CATALOG_PATH = path.join(ROOT, 'translations', 'catalog.fr.json');
const OVERRIDES_PATH = path.join(ROOT, 'translations', 'manual-overrides.fr.json');
const FORCE_TRANSLATION = process.argv.includes('--force');
const ALLOW_REMOTE_TRANSLATION = FORCE_TRANSLATION || process.argv.includes('--translate-missing');
const TRANSLATION_CONCURRENCY = Number.parseInt(
  process.env.ZORK_TRANSLATION_CONCURRENCY ?? '2',
  10,
);

const GAME_FILES = {
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

const SKIPPED_OPERATORS = new Set(['INSERT-FILE', 'SNAME', 'STRING']);
const SKIPPED_VALUES = new Set(['OPTIONAL']);

// The tokens keep names and recurring lore terminology stable across all three games.
const GLOSSARY = [
  ['The Great Underground Empire', 'Le Grand Empire Souterrain'],
  ['Great Underground Empire', 'Grand Empire Souterrain'],
  ['The Wizard of Frobozz', 'Le Magicien de Frobozz'],
  ['Wizard of Frobozz', 'Magicien de Frobozz'],
  ['The Dungeon Master', 'Le Maître du Donjon'],
  ['Dungeon Master', 'Maître du Donjon'],
  ['Lord Dimwit Flathead', 'Seigneur Nigaud Tête-Plate'],
  ['Dimwit Flathead', 'Nigaud Tête-Plate'],
  ['Flathead', 'Tête-Plate'],
  ['Frobozz', 'Frobozz'],
  ['Quendor', 'Quendor'],
  ['Aragain', 'Aragain'],
  ['Zorkmids', 'zorkmids'],
  ['Zorkmid', 'zorkmid'],
  ['Zorkers', 'Zorkiens'],
  ['Zorker', 'Zorkien'],
  ['ZORK', 'ZORK'],
  ['Zork', 'Zork'],
];

function isEscaped(text, index) {
  let slashes = 0;
  for (let cursor = index - 1; cursor >= 0 && text[cursor] === '\\'; cursor -= 1) {
    slashes += 1;
  }
  return slashes % 2 === 1;
}

function operatorBefore(text, index) {
  const windowStart = Math.max(0, index - 240);
  const window = text.slice(windowStart, index);
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

function decodeZilString(raw) {
  return raw.replace(/\\"/g, '"').replace(/\\\\/g, '\\');
}

function encodeZilString(value) {
  return value.replace(/\\/g, '\\\\').replace(/"/g, '\\"');
}

function normalizeFrench(value) {
  return value
    .replace(/[’‘]/g, "'")
    .replace(/[“”]/g, '"')
    .replace(/…/g, '...')
    .replace(/[–—]/g, '--')
    .replace(/n°\s*/gi, 'numéro ')
    .replace(/\u00a0/g, ' ')
    .replace(/\s+([?!;:])/g, ' $1');
}

function findStringSpans(text) {
  const spans = [];
  for (let index = 0; index < text.length; index += 1) {
    if (text[index] !== '"' || isEscaped(text, index)) continue;

    let end = index + 1;
    while (end < text.length && (text[end] !== '"' || isEscaped(text, end))) end += 1;
    if (end >= text.length) throw new Error(`Chaîne ZIL non terminée à l'offset ${index}`);

    const raw = text.slice(index + 1, end);
    const value = decodeZilString(raw);
    const operator = operatorBefore(text, index);
    const translatable =
      !isCommentedString(text, index) &&
      !SKIPPED_OPERATORS.has(operator) &&
      !SKIPPED_VALUES.has(value) &&
      /[A-Za-z]/.test(value) &&
      value.trim().length > 0;

    spans.push({ start: index + 1, end, value, translatable });
    index = end;
  }
  return spans;
}

function protectText(text, id) {
  // In ZIL, a physical newline inside a string is only source whitespace. Sending
  // it to the translator as a sentence break creates broken French clauses. The
  // printable `|` control character is protected separately and remains intact.
  let protectedText = text
    .replace(/\r?\n/g, ' ')
    .replace(/\|/g, `ZXPIPE${id}Q`)
    .replace(/\\/g, `ZXSLASH${id}Q`);
  const terms = [];
  for (const [english, french] of GLOSSARY) {
    const expression = new RegExp(english.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'), 'g');
    protectedText = protectedText.replace(expression, () => {
      const token = `ZXTERM${id}X${terms.length}Q`;
      terms.push({ token, french });
      return token;
    });
  }
  return { protectedText, terms };
}

function restoreText(text, id, terms) {
  let restored = text;
  for (const { token, french } of terms) restored = restored.replaceAll(token, french);
  return normalizeFrench(
    restored.replaceAll(`ZXPIPE${id}Q`, '|').replaceAll(`ZXSLASH${id}Q`, '\\'),
  );
}

function createBatches(records, maxChars = 3600) {
  const batches = [];
  let current = [];
  let size = 0;
  for (const record of records) {
    const estimate = record.protectedText.length + 48;
    if (current.length && size + estimate > maxChars) {
      batches.push(current);
      current = [];
      size = 0;
    }
    current.push(record);
    size += estimate;
  }
  if (current.length) batches.push(current);
  return batches;
}

async function translateBatch(batch, attempt = 1) {
  const body = new URLSearchParams({
    client: 'gtx',
    sl: 'en',
    tl: 'fr',
    dt: 't',
    q: batch
      .map(({ id, protectedText }) => `<<<ZX${id}S>>>${protectedText}<<<ZX${id}E>>>`)
      .join(''),
  });

  try {
    const response = await fetch('https://translate.googleapis.com/translate_a/single', {
      method: 'POST',
      headers: { 'content-type': 'application/x-www-form-urlencoded;charset=UTF-8' },
      body,
    });
    if (!response.ok) throw new Error(`HTTP ${response.status}`);
    const payload = await response.json();
    const joined = payload[0].map((part) => part[0]).join('');
    const translated = new Map();
    const missing = [];

    for (const record of batch) {
      const start = `<<<ZX${record.id}S>>>`;
      const end = `<<<ZX${record.id}E>>>`;
      const startAt = joined.indexOf(start);
      const endAt = joined.indexOf(end, startAt + start.length);
      if (startAt < 0 || endAt < 0) {
        missing.push(record);
        continue;
      }
      translated.set(
        record.source,
        restoreText(joined.slice(startAt + start.length, endAt), record.id, record.terms),
      );
    }

    if (missing.length) {
      if (batch.length === 1) return translateSingle(batch[0]);
      const middle = Math.ceil(batch.length / 2);
      const [left, right] = await Promise.all([
        translateBatch(batch.slice(0, middle)),
        translateBatch(batch.slice(middle)),
      ]);
      return new Map([...left, ...right]);
    }
    return translated;
  } catch (error) {
    if (attempt >= 5) throw error;
    await new Promise((resolve) => setTimeout(resolve, 750 * 2 ** attempt));
    return translateBatch(batch, attempt + 1);
  }
}

async function translateSingle(record, attempt = 1) {
  const body = new URLSearchParams({
    client: 'gtx',
    sl: 'en',
    tl: 'fr',
    dt: 't',
    q: record.protectedText,
  });

  try {
    const response = await fetch('https://translate.googleapis.com/translate_a/single', {
      method: 'POST',
      headers: { 'content-type': 'application/x-www-form-urlencoded;charset=UTF-8' },
      body,
    });
    if (!response.ok) throw new Error(`HTTP ${response.status}`);
    const payload = await response.json();
    const translated = payload[0].map((part) => part[0]).join('');
    return new Map([[record.source, restoreText(translated, record.id, record.terms)]]);
  } catch (error) {
    if (attempt >= 5) throw error;
    await new Promise((resolve) => setTimeout(resolve, 750 * 2 ** attempt));
    return translateSingle(record, attempt + 1);
  }
}

async function mapConcurrent(items, concurrency, callback) {
  const results = new Array(items.length);
  let cursor = 0;
  async function worker() {
    while (cursor < items.length) {
      const index = cursor;
      cursor += 1;
      results[index] = await callback(items[index], index);
      process.stdout.write(`\rTraduction : ${index + 1}/${items.length} lots`);
    }
  }
  await Promise.all(Array.from({ length: Math.min(concurrency, items.length) }, worker));
  process.stdout.write('\n');
  return results;
}

async function loadOverrides() {
  try {
    return JSON.parse(await readFile(OVERRIDES_PATH, 'utf8'));
  } catch (error) {
    if (error.code === 'ENOENT') return {};
    throw error;
  }
}

async function loadExistingCatalog() {
  if (FORCE_TRANSLATION) return { meta: {}, translations: {} };
  try {
    const catalog = JSON.parse(await readFile(CATALOG_PATH, 'utf8'));
    return { meta: catalog.meta ?? {}, translations: catalog.translations ?? {} };
  } catch (error) {
    if (error.code === 'ENOENT') return { meta: {}, translations: {} };
    throw error;
  }
}

async function collectSources() {
  const sources = new Map();
  const files = [];
  for (const [game, names] of Object.entries(GAME_FILES)) {
    for (const name of names) {
      const filePath = path.join(SOURCE_ROOT, game, name);
      const content = await readFile(filePath, 'utf8');
      const spans = findStringSpans(content);
      for (const span of spans) {
        if (span.translatable && !sources.has(span.value)) sources.set(span.value, sources.size + 1);
      }
      files.push({ game, name, content, spans });
    }
  }
  return { sources, files };
}

async function buildCatalog(sources) {
  const overrides = await loadOverrides();
  const existingCatalog = await loadExistingCatalog();
  const existing = existingCatalog.translations;
  const records = [...sources]
    .filter(([source]) => !Object.hasOwn(existing, source))
    .map(([source, number]) => {
    const id = String(number).padStart(6, '0');
    const { protectedText, terms } = protectText(source, id);
    return { id, source, protectedText, terms };
  });

  if (records.length && !ALLOW_REMOTE_TRANSLATION) {
    const preview = records
      .slice(0, 10)
      .map(({ source }) => `- ${JSON.stringify(source.slice(0, 160))}`)
      .join('\n');
    throw new Error(
      `${records.length} chaîne(s) manquent au catalogue. ` +
        `Ajoutez-les manuellement ou relancez avec --translate-missing.\n${preview}`,
    );
  }

  const batches = createBatches(records);
  const translatedBatches = await mapConcurrent(
    batches,
    TRANSLATION_CONCURRENCY,
    (batch) => translateBatch(batch),
  );
  const translations = {
    ...existing,
    ...Object.fromEntries(translatedBatches.flatMap((batch) => [...batch])),
  };
  Object.assign(translations, overrides);

  const catalog = {
    meta: {
      ...existingCatalog.meta,
      language: 'fr',
      sourceLanguage: 'en',
      generatedAt: new Date().toISOString(),
      sourceCount: sources.size,
      translatedThisRun: records.length,
      note:
        existingCatalog.meta.note ??
        'Première passe automatique, avec glossaire et surcharges éditoriales manuelles.',
    },
    translations,
  };
  await writeFile(CATALOG_PATH, `${JSON.stringify(catalog, null, 2)}\n`);
  return translations;
}

async function writeLocalizedSources(files, translations) {
  await rm(OUTPUT_ROOT, { recursive: true, force: true });
  await mkdir(OUTPUT_ROOT, { recursive: true });

  for (const game of Object.keys(GAME_FILES)) {
    await cp(path.join(SOURCE_ROOT, game), path.join(OUTPUT_ROOT, game), { recursive: true });
  }

  for (const file of files) {
    let localized = file.content;
    for (const span of [...file.spans].reverse()) {
      if (!span.translatable) continue;
      if (!Object.hasOwn(translations, span.value)) {
        throw new Error(`Traduction absente : ${span.value.slice(0, 80)}`);
      }
      const translation = normalizeFrench(translations[span.value]);
      localized = `${localized.slice(0, span.start)}${encodeZilString(translation)}${localized.slice(span.end)}`;
    }
    await writeFile(path.join(OUTPUT_ROOT, file.game, file.name), localized);
  }
}

async function main() {
  const { sources, files } = await collectSources();
  console.log(`${sources.size} chaînes anglaises uniques détectées.`);
  const translations = await buildCatalog(sources);
  await writeLocalizedSources(files, translations);
  console.log(`Sources françaises générées dans ${path.relative(ROOT, OUTPUT_ROOT)}.`);
}

await main();
