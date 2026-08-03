import { readFile, writeFile } from 'node:fs/promises';

const zork1 = JSON.parse(await readFile('translations/game-reviews/zork1.fr.json', 'utf8'));
const reviewPath = 'translations/game-reviews/zork2.fr.json';
const zork2 = JSON.parse(await readFile(reviewPath, 'utf8'));

let shared = 0;
let updated = 0;
for (const [source, target] of Object.entries(zork1.translations)) {
  if (!Object.hasOwn(zork2.translations, source)) continue;
  shared += 1;
  if (zork2.translations[source] !== target) updated += 1;
  zork2.translations[source] = target;
}
zork2.meta.sharedReviewedCount = shared;
zork2.meta.sharedUpdatedCount = updated;
await writeFile(reviewPath, `${JSON.stringify(zork2, null, 2)}\n`);
console.log(`Zork II : ${shared} chaînes communes reprises de Zork I, dont ${updated} mises à jour.`);
