import assert from 'node:assert/strict';
import { createHash } from 'node:crypto';
import { readFile } from 'node:fs/promises';
import { literaryCorrections } from '../translations/game-reviews/zork1-literary-pass.fr.mjs';

const review = JSON.parse(await readFile('translations/game-reviews/zork1.fr.json', 'utf8'));
const glossary = JSON.parse(await readFile('translations/glossaries/zork1.fr.json', 'utf8'));
const sources = Object.keys(review.translations).sort((left, right) =>
  left.localeCompare(right, 'en'),
);
const normalize = (value) => value.replace(/\s+/g, ' ').trim();

assert.equal(review.meta.game, 'zork1');
assert.equal(review.meta.language, 'fr-FR');
assert.equal(review.meta.sourceLanguage, 'en');
assert.equal(review.meta.reviewStatus, 'complete', 'La revue Zork I doit être terminée.');
assert.equal(review.meta.sourceCount, 1701, 'La revue Zork I doit couvrir 1 701 chaînes.');
assert.equal(review.meta.glossaryCount, Object.keys(glossary.translations).length);
assert.equal(review.meta.literaryCorrectionCount, literaryCorrections.length);
assert.equal(review.meta.languageToolSourceCount, 1701);
assert.equal(review.meta.runtimeScenarioCommandCount, 28);
assert.equal(sources.length, review.meta.sourceCount, 'Chaque chaîne doit avoir une traduction.');
assert.ok(
  sources.every((source) => typeof review.translations[source] === 'string'),
  'Chaque traduction Zork I doit être une chaîne de caractères.',
);
assert.equal(
  createHash('sha256').update(JSON.stringify(sources)).digest('hex'),
  review.meta.sourceSha256,
  'La liste des chaînes relues a changé : reconstruire puis contrôler la revue.',
);
for (const [source, target] of Object.entries(glossary.translations)) {
  if (!Object.hasOwn(review.translations, source)) continue;
  assert.equal(review.translations[source], target, `Glossaire non appliqué : ${source}`);
}
for (const correction of literaryCorrections) {
  const matches = correction.source
    ? sources.filter((source) => source === correction.source)
    : sources.filter((source) =>
        normalize(source).startsWith(normalize(correction.startsWith)),
      );
  assert.equal(matches.length, 1, `Correction littéraire ambiguë : ${correction.startsWith}`);
  assert.equal(
    review.translations[matches[0]],
    correction.target,
    `Correction littéraire non appliquée : ${correction.startsWith}`,
  );
}

console.log(
  `✓ Revue Zork I : ${sources.length} chaînes couvertes, ` +
    `${Object.keys(glossary.translations).length} termes canoniques, ` +
    `${literaryCorrections.length} corrections littéraires et SHA-256 stable.`,
);
