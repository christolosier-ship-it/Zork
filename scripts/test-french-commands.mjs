import assert from 'node:assert/strict';
import { translateFrenchCommand } from '../src/french-commands.js';

const CASES = [
  ['observer', 'look'],
  ['prendre la lampe', 'take lamp'],
  ['ouvrir la boîte aux lettres', 'open mailbox'],
  ['mettre la lanterne dans le panier', 'put lantern in basket'],
  ['mettre la lanterne dans la nacelle', 'put lantern in basket', 'zork2'],
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
  ['prendre la planche', 'take board', 'zork1'],
  ['examiner le miroir', 'examine mirror', 'zork1'],
  ['tourner la clé à molette', 'turn wrench', 'zork1'],
  ['prendre la carte', 'take card', 'zork2'],
  ['examiner les gravures', 'examine etchings', 'zork2'],
  ['lire la brochure bancaire', 'read brochure', 'zork2'],
  ['dire flottaison', 'say float', 'zork2'],
  ['dire frayeur', 'say fear', 'zork2'],
  ['dire faire choir', 'say fall', 'zork2'],
  ['dire feu-froid', 'say fireproof', 'zork2'],
  ['ouvrir le coffre', 'open chest', 'zork3'],
  ['examiner le panneau', 'examine panel', 'zork3'],
  ['mettre le bateau à l’eau', 'launch boat'],
  ['prendre l’œuf', 'take egg', 'zork1'],
  ['grimper à l’arbre', 'climb tree', 'zork1'],
  ['prendre la lanterne et l’épée', 'take lantern and sword', 'zork1'],
];

for (const [french, english, gameId] of CASES) {
  assert.equal(translateFrenchCommand(french, gameId), english, french);
}

console.log(`✓ Commandes françaises : ${CASES.length} formulations vérifiées.`);
