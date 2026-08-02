import assert from 'node:assert/strict';
import { translateFrenchCommand } from '../src/french-commands.js';

const CASES = new Map([
  ['observer', 'look'],
  ['prendre la lampe', 'take lamp'],
  ['ouvrir la boîte aux lettres', 'open mailbox'],
  ['mettre la lanterne dans le panier', 'put lantern in basket'],
  ['regarder sous le tapis', 'look under rug'],
  ['attaquer la chauve-souris avec l’épée', 'attack bat with sword'],
  ['nord-ouest', 'northwest'],
  ['ouest', 'west'],
  ['sauvegarder', 'save'],
  ['reprendre', 'restore'],
  ['oui', 'y'],
  ['prendre tout sauf la lanterne', 'take all except lantern'],
  ['prendre la baguette magique du sorcier', 'take wand'],
  ['ouvrir le coffre à bijoux', 'open trunk'],
  ['examiner le cadran solaire', 'examine dial'],
  ['prendre la couronne voyante', 'take crown'],
]);

for (const [french, english] of CASES) {
  assert.equal(translateFrenchCommand(french), english, french);
}

console.log(`✓ Commandes françaises : ${CASES.size} formulations vérifiées.`);
