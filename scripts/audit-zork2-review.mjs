import assert from 'node:assert/strict';
import { createHash } from 'node:crypto';
import { readFile } from 'node:fs/promises';
import { literaryCorrections } from '../translations/game-reviews/zork2-literary-pass.fr.mjs';
import { fragmentCorrections } from '../translations/game-reviews/zork2-fragment-pass.fr.mjs';

const corrections = [...literaryCorrections, ...fragmentCorrections];
const intentionalTutoiementSource =
  'Suddenly the Wizard materializes in the room. He is astonished by what\n' +
  'he sees: his servant in deep conversation with a common adventurer! He\n' +
  'draws forth his wand, waves it frantically, and incants "Frobizz!\n' +
  'Frobozzle! Frobnoid!" The demon laughs heartily. "You no longer\n' +
  'control the Black Crystal, hedge-wizard! Your wand is powerless! Your\n' +
  'doom is sealed!" The demon turns to you, expectantly.';

const review = JSON.parse(await readFile('translations/game-reviews/zork2.fr.json', 'utf8'));
const glossary = JSON.parse(await readFile('translations/glossaries/zork2.fr.json', 'utf8'));
const sources = Object.keys(review.translations).sort((left, right) =>
  left.localeCompare(right, 'en'),
);
const normalize = (value) => value.replace(/\s+/g, ' ').trim();

assert.equal(review.meta.game, 'zork2');
assert.equal(review.meta.language, 'fr-FR');
assert.equal(review.meta.sourceLanguage, 'en');
assert.equal(review.meta.sourceCount, 1679, 'La revue Zork II doit couvrir 1 679 chaînes.');
assert.equal(sources.length, review.meta.sourceCount, 'Chaque chaîne doit avoir une traduction.');
assert.ok(
  sources.every((source) => typeof review.translations[source] === 'string'),
  'Chaque traduction Zork II doit être une chaîne de caractères.',
);
assert.equal(
  createHash('sha256').update(JSON.stringify(sources)).digest('hex'),
  review.meta.sourceSha256,
  'La liste des chaînes relues a changé : reconstruire puis contrôler la revue.',
);
assert.equal(review.meta.glossaryCount, Object.keys(glossary.translations).length);
assert.equal(review.meta.literaryCorrectionCount, literaryCorrections.length);
assert.equal(review.meta.fragmentCorrectionCount, fragmentCorrections.length);
assert.equal(
  new Set(corrections.map((correction) => correction.source ?? correction.startsWith)).size,
  corrections.length,
  'Une même chaîne ne doit pas recevoir deux corrections éditoriales.',
);
for (const [source, target] of Object.entries(glossary.translations)) {
  if (!Object.hasOwn(review.translations, source)) continue;
  assert.equal(review.translations[source], target, `Glossaire non appliqué : ${source}`);
}
for (const correction of corrections) {
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

const translatedCorpus = Object.values(review.translations).join('\n');
for (const [label, pattern] of [
  ['marqueur technique', /<<<ZX|>>>|\[object Object\]|\bundefined\b/i],
  ['terme non canonique', /(?<![\p{L}])(?:panier|boîte|piscine|affaire)(?![\p{L}])/iu],
  ['fragment de traduction automatique', /\bVous Je\b|\bun direction\b|\bsmithereens\b|\bany\b/i],
]) {
  assert.ok(!pattern.test(translatedCorpus), `Résidu détecté (${label}) : ${pattern}`);
}

const tutoiement = sources.filter((source) =>
  /(?<![\p{L}])(?:tu|te|toi|ton|ta|tes)(?![\p{L}])/iu.test(review.translations[source]),
);
assert.deepEqual(
  tutoiement,
  [intentionalTutoiementSource],
  "Le joueur doit être vouvoyé ; seul le démon tutoie volontairement le Magicien.",
);

console.log(
  `✓ Revue Zork II : ${sources.length} chaînes couvertes, ` +
    `${Object.keys(glossary.translations).length} termes canoniques, ` +
    `${literaryCorrections.length} corrections littéraires, ` +
    `${fragmentCorrections.length} fragments corrigés et SHA-256 stable.`,
);
