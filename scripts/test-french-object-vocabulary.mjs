import assert from 'node:assert/strict';
import { readFile, readdir } from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { translateFrenchCommand } from '../src/french-commands.js';

const ROOT = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const SOURCE_ROOT = path.join(ROOT, 'translations', 'zil', 'en');
const CATALOG_PATH = path.join(ROOT, 'translations', 'catalog.fr.json');
const REJECTED_TARGETS = new Set([
  'it',
  'them',
  'her',
  'him',
  'me',
  'myself',
  'self',
  'intnum',
  'zzmgck',
]);
const ACCEPTED_ALIASES = new Map([
  // TM-HOLLOW redirige explicitement vers l'objet TM-SEAT dans Zork III.
  ['zork3:TM-HOLLOW', new Set(['seat'])],
]);

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

const catalog = JSON.parse(await readFile(CATALOG_PATH, 'utf8')).translations;
let checked = 0;

for (const gameId of ['zork1', 'zork2', 'zork3']) {
  for (const filePath of await listZilFiles(path.join(SOURCE_ROOT, gameId))) {
    const source = await readFile(filePath, 'utf8');
    for (const match of source.matchAll(/<OBJECT\s+([A-Z0-9?!&-]+)([\s\S]*?)>/g)) {
      const [, objectId, block] = match;
      const synonyms = block.match(/\(SYNONYM\s+([^)]+)\)/)?.[1]
        ?.match(/[A-Z][A-Z0-9?!&-]*/g)
        ?.map((token) => token.toLowerCase())
        ?.filter((token) => !REJECTED_TARGETS.has(token) && !token.startsWith('zz'));
      const rawDescription = block.match(/\(DESC\s+"((?:\\.|[^"\\])*)"\)/)?.[1];
      if (!synonyms?.length || !rawDescription) continue;

      const englishDescription = decodeZilString(rawDescription);
      const frenchDescription = catalog[englishDescription];
      assert.ok(frenchDescription, `${gameId}:${objectId} — description française absente`);

      const command = translateFrenchCommand(`examiner ${frenchDescription}`, gameId);
      const tokens = new Set(command.split(/\s+/));
      const accepted = new Set([
        ...synonyms,
        ...(ACCEPTED_ALIASES.get(`${gameId}:${objectId}`) ?? []),
      ]);
      assert.ok(
        [...accepted].some((synonym) => tokens.has(synonym)),
        `${gameId}:${objectId} — « ${frenchDescription} » donne « ${command} », ` +
          `sans synonyme reconnu (${[...accepted].join(', ')})`,
      );
      checked += 1;
    }
  }
}

console.log(`✓ Vocabulaire des objets : ${checked} descriptions françaises vérifiées.`);
