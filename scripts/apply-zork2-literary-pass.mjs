import assert from 'node:assert/strict';
import { readFile, writeFile } from 'node:fs/promises';
import { literaryCorrections } from '../translations/game-reviews/zork2-literary-pass.fr.mjs';
import { fragmentCorrections } from '../translations/game-reviews/zork2-fragment-pass.fr.mjs';

const corrections = [...literaryCorrections, ...fragmentCorrections];

const reviewPath = 'translations/game-reviews/zork2.fr.json';
const review = JSON.parse(await readFile(reviewPath, 'utf8'));
const entries = Object.entries(review.translations);
const normalize = (value) => value.replace(/\s+/g, ' ').trim();

for (const correction of corrections) {
  const matches = correction.source
    ? entries.filter(([source]) => source === correction.source)
    : entries.filter(([source]) =>
        normalize(source).startsWith(normalize(correction.startsWith)),
      );
  assert.equal(matches.length, 1, `Préfixe littéraire ambigu ou absent : ${correction.startsWith}`);
  review.translations[matches[0][0]] = correction.target;
}
review.meta.literaryCorrectionCount = literaryCorrections.length;
review.meta.fragmentCorrectionCount = fragmentCorrections.length;
await writeFile(reviewPath, `${JSON.stringify(review, null, 2)}\n`);
console.log(
  `Zork II : ${literaryCorrections.length} corrections littéraires et ` +
    `${fragmentCorrections.length} corrections de fragments appliquées.`,
);
