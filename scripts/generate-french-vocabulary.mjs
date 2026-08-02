import { readFile, readdir, writeFile } from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const ROOT = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const SOURCE_ROOT = path.join(ROOT, 'translations', 'zil', 'en');
const CATALOG_PATH = path.join(ROOT, 'translations', 'catalog.fr.json');
const OUTPUT_PATH = path.join(ROOT, 'src', 'french-vocabulary.generated.js');

const STOP_WORDS = new Set([
  'a', 'au', 'aux', 'avec', 'ce', 'ces', 'cet', 'cette', 'd', 'dans', 'de', 'des', 'du',
  'en', 'et', 'ici', 'l', 'la', 'le', 'les', 'par', 'pour', 'qui', 'sur', 'un', 'une',
  'ancien', 'ancienne', 'beau', 'belle', 'grand', 'grande', 'gros', 'grosse', 'petit',
  'petite', 'vieux', 'vieil', 'vieille',
]);

const REJECTED_TARGETS = new Set([
  'it', 'them', 'her', 'him', 'me', 'myself', 'self', 'intnum', 'zzmgck',
]);

function normalize(value) {
  return value
    .normalize('NFD')
    .replace(/\p{M}/gu, '')
    .toLowerCase()
    .replace(/[’']/g, ' ')
    .replace(/-/g, ' ')
    .replace(/[^a-z0-9\s]/g, ' ')
    .replace(/\s+/g, ' ')
    .trim();
}

function decodeZilString(value) {
  return value.replace(/\\"/g, '"').replace(/\\\\/g, '\\');
}

async function listZilFiles(directory) {
  const entries = await readdir(directory, { withFileTypes: true });
  const nested = await Promise.all(
    entries.map(async (entry) => {
      const entryPath = path.join(directory, entry.name);
      if (entry.isDirectory()) return listZilFiles(entryPath);
      return entry.name.endsWith('.zil') ? [entryPath] : [];
    }),
  );
  return nested.flat();
}

function serializeMap(name, entries) {
  const rows = [...entries]
    .sort(([left], [right]) => left.localeCompare(right, 'fr'))
    .map(([french, english]) => `  ${JSON.stringify(french)}: ${JSON.stringify(english)},`);
  return `export const ${name} = {\n${rows.join('\n')}\n};\n`;
}

async function main() {
  const catalog = JSON.parse(await readFile(CATALOG_PATH, 'utf8')).translations;
  const phraseCandidates = new Map();
  const wordCandidates = new Map();

  for (const filePath of await listZilFiles(SOURCE_ROOT)) {
    const source = await readFile(filePath, 'utf8');
    for (const match of source.matchAll(/<OBJECT\s+[A-Z0-9?!&-]+([\s\S]*?)>/g)) {
      const block = match[1];
      const synonyms = block.match(/\(SYNONYM\s+([^)]+)\)/)?.[1]
        ?.match(/[A-Z][A-Z0-9?!&-]*/g)
        ?.map((token) => token.toLowerCase())
        ?.filter((token) => !REJECTED_TARGETS.has(token) && !token.startsWith('zz'));
      const rawDescription = block.match(/\(DESC\s+"((?:\\.|[^"\\])*)"\)/)?.[1];
      if (!synonyms?.length || !rawDescription) continue;

      const englishDescription = decodeZilString(rawDescription);
      const frenchDescription = catalog[englishDescription];
      if (!frenchDescription) continue;

      const target = synonyms[0];
      const phrase = normalize(frenchDescription);
      if (phrase && phrase.split(' ').length <= 7) {
        const targets = phraseCandidates.get(phrase) ?? new Set();
        targets.add(target);
        phraseCandidates.set(phrase, targets);
      }

      for (const word of phrase.split(' ')) {
        if (word.length < 3 || STOP_WORDS.has(word)) continue;
        const targets = wordCandidates.get(word) ?? new Set();
        targets.add(target);
        wordCandidates.set(word, targets);
      }
    }
  }

  const phrases = [...phraseCandidates]
    .filter(([phrase, targets]) => phrase.includes(' ') && targets.size === 1)
    .map(([phrase, targets]) => [phrase, [...targets][0]]);
  const words = [...wordCandidates]
    .filter(([_word, targets]) => targets.size === 1)
    .map(([word, targets]) => [word, [...targets][0]]);

  const output = [
    '// Fichier généré par scripts/generate-french-vocabulary.mjs.',
    '// Les entrées manuelles de french-commands.js restent prioritaires.',
    '',
    serializeMap('GENERATED_PHRASES', phrases),
    serializeMap('GENERATED_WORDS', words),
  ].join('\n');
  await writeFile(OUTPUT_PATH, output);
  console.log(`✓ Vocabulaire généré : ${phrases.length} expressions, ${words.length} mots.`);
}

await main();
