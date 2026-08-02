import assert from 'node:assert/strict';
import { readFile, writeFile } from 'node:fs/promises';
import { literaryCorrections } from '../translations/game-reviews/zork1-literary-pass.fr.mjs';

const reviewPath = 'translations/game-reviews/zork1.fr.json';
const review = JSON.parse(await readFile(reviewPath, 'utf8'));
const entries = Object.entries(review.translations);
const normalize = (value) => value.replace(/\s+/g, ' ').trim();

for (const correction of literaryCorrections) {
  const matches = correction.source
    ? entries.filter(([source]) => source === correction.source)
    : entries.filter(([source]) =>
        normalize(source).startsWith(normalize(correction.startsWith)),
      );
  assert.equal(matches.length, 1, `Préfixe littéraire ambigu ou absent : ${correction.startsWith}`);
  review.translations[matches[0][0]] = correction.target;
}
review.meta.literaryCorrectionCount = literaryCorrections.length;
await writeFile(reviewPath, `${JSON.stringify(review, null, 2)}\n`);
console.log(`Zork I : ${literaryCorrections.length} corrections littéraires appliquées.`);
