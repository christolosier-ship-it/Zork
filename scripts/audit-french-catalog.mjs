import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';
import { QUICK_COMMANDS } from '../src/catalog.js';

const catalog = JSON.parse(await readFile('translations/catalog.fr.json', 'utf8'));
const overrides = JSON.parse(await readFile('translations/manual-overrides.fr.json', 'utf8'));
const translations = catalog.translations ?? {};

assert.equal(catalog.meta?.language, 'fr', 'La langue cible du catalogue doit être le français.');
assert.equal(
  catalog.meta?.sourceLanguage,
  'en',
  'La langue source du catalogue doit être l’anglais.',
);
assert.equal(catalog.meta?.sourceCount, 3651, 'Le catalogue source doit rester complet.');
assert.equal(
  catalog.meta?.manualOverrideCount,
  Object.keys(overrides).length,
  'Le nombre de surcharges éditoriales doit être à jour.',
);

for (const [source, target] of Object.entries(overrides)) {
  assert.ok(Object.hasOwn(translations, source), `Surcharge sans chaîne source : ${source}`);
  assert.equal(translations[source], target, `Surcharge non appliquée : ${source}`);
}

const forbiddenResidues = [
  /WELCOME TO ZORK/i,
  /PAPER SHUFFLING/i,
  /Crown Jewels/i,
  /Royal Puzzle Exit Fee Paid/i,
  /Item Confiscated/i,
  /Scenic Vista/i,
  /Garbage In, Garbage Out/i,
  /Candied Grasshoppers/i,
  /Chocolated Ants/i,
  /Worms Glacee/i,
  /non kempt/i,
  /bludges?/i,
  /Vous êtes portant/i,
  /Le lampe est maintenant/i,
  /Nous sommes à la jonction/i,
  /elfe\. épée/i,
  /\bward\./i,
];

for (const [source, target] of Object.entries(translations)) {
  const residue = forbiddenResidues.find((pattern) => pattern.test(target));
  assert.ok(!residue, `Résidu non français (${residue}) pour : ${source}`);
}

const helpControl = QUICK_COMMANDS.find((item) => item.label === 'Aide du jeu');
assert.equal(helpControl?.action, 'help', 'Le raccourci Aide doit ouvrir le guide.');
assert.ok(!helpControl?.command, 'Le raccourci Aide ne doit pas envoyer HELP à Zork.');

console.log(
  `✓ Catalogue français : ${catalog.meta.sourceCount} chaînes, ` +
    `${Object.keys(overrides).length} surcharges éditoriales contrôlées.`,
);
