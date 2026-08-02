import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';

function pseudoVocabulary(text) {
  const words = [];
  for (const match of text.matchAll(/\(PSEUDO\s+([^>]+)>/g)) {
    for (const word of match[1].matchAll(/"([^"\\]*(?:\\.[^"\\]*)*)"/g)) {
      words.push(word[1]);
    }
  }
  return words;
}

const files = ['1dungeon.zil', '1actions.zil', 'gverbs.zil'];
let count = 0;
for (const file of files) {
  const english = await readFile(`translations/zil/en/zork1/${file}`, 'utf8');
  const french = await readFile(`translations/zil/fr/zork1/${file}`, 'utf8');
  const expected = pseudoVocabulary(english);
  const actual = pseudoVocabulary(french);
  assert.deepEqual(actual, expected, `${file} : le vocabulaire PSEUDO du parseur a été modifié.`);
  count += expected.length;
}

for (const file of [
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
]) {
  const french = await readFile(`translations/zil/fr/zork1/${file}`, 'utf8');
  assert.ok(!/[œŒ]/.test(french), `${file} : ligature incompatible avec la Z-machine v3.`);
}

console.log(
  `✓ Zork I : ${count} mots PSEUDO préservés et ligatures compatibles Z-machine v3.`,
);
