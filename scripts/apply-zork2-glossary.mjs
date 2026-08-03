import { readFile, writeFile } from 'node:fs/promises';

const reviewPath = 'translations/game-reviews/zork2.fr.json';
const glossaryPath = 'translations/glossaries/zork2.fr.json';
const review = JSON.parse(await readFile(reviewPath, 'utf8'));
const glossary = JSON.parse(await readFile(glossaryPath, 'utf8'));

let applied = 0;
for (const [source, target] of Object.entries(glossary.translations)) {
  if (!Object.hasOwn(review.translations, source)) continue;
  review.translations[source] = target;
  applied += 1;
}
review.meta.glossaryCount = Object.keys(glossary.translations).length;
review.meta.glossaryAppliedCount = applied;
await writeFile(reviewPath, `${JSON.stringify(review, null, 2)}\n`);
console.log(
  `Zork II : ${review.meta.glossaryAppliedCount}/${review.meta.glossaryCount} ` +
    'entrées exactes du glossaire appliquées.',
);
