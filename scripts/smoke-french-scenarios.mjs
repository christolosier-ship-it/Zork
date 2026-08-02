import { readFile } from 'node:fs/promises';
import { TestIOAdapter, ZMachine } from '../node_modules/zmachine/dist/zmachine.esm.min.js';
import { translateFrenchCommand } from '../src/french-commands.js';

const SCENARIOS = {
  zork1: {
    commands: [
      'observer',
      'prendre la lanterne et l’épée',
      'ouvrir la boîte aux lettres',
      'prendre le dépliant',
      'lire le dépliant',
      'nord',
      'nord',
      'observer',
      'grimper à l’arbre',
      'observer',
      'prendre l’œuf',
      'descendre',
      'sud',
      'est',
      'ouvrir la fenêtre',
      'entrer',
      'ouest',
      'prendre la lanterne',
      'prendre l’épée',
      'déplacer le tapis',
      'ouvrir la trappe',
      'allumer la lanterne',
      'descendre',
      'observer',
      'inventaire',
      'score',
      'quitter',
      'oui',
    ],
    expected: [
      /Grand Empire Souterrain/i,
      /Les objets que vous avez mentionnés ne sont pas ici/i,
      /boîte aux lettres/i,
      /BIENVENUE DANS ZORK/i,
      /Sentier forestier/i,
      /oeuf serti de pierres précieuses/i,
      /fenêtre qui est ouverte/i,
      /Contenu \(bouteille en verre\)/i,
      /vitrine à trophées/i,
      /Cave/i,
      /Vous avez sur vous/i,
      /Votre rang : Aventurier amateur/i,
    ],
  },
  zork2: {
    commands: [
      'prendre la lanterne',
      'prendre l’épée',
      'allumer la lanterne',
      'sud',
      'observer',
      'inventaire',
      'quitter',
      'oui',
    ],
    expected: [
      /Magicien de Frobozz/i,
      /tumulus/i,
      /Source lumineuse allumée/i,
      /Un profond ravin serpente à travers la caverne/i,
    ],
  },
  zork3: {
    commands: [
      'prendre la lanterne',
      'allumer la lanterne',
      'sud',
      'observer',
      'inventaire',
      'quitter',
      'oui',
    ],
    expected: [
      /Maître du Donjon/i,
      /Escalier sans fin/i,
      /Source lumineuse allumée/i,
      /Vous êtes à la jonction/i,
      /Une épée elfique y est enchâssée/i,
    ],
  },
};

for (const [gameId, scenario] of Object.entries(SCENARIOS)) {
  const story = await readFile(`public/games/${gameId}.z3`);
  const io = new TestIOAdapter();
  io.initialize(3);
  for (const command of scenario.commands) {
    io.queueLineInput(translateFrenchCommand(command, gameId));
  }
  io.queueCharInput('y'.charCodeAt(0));

  const machine = ZMachine.load(story, io);
  await machine.run();
  const output = io.getLowerOutput();

  for (const expected of scenario.expected) {
    if (!expected.test(output)) {
      throw new Error(`${gameId} : sortie attendue absente (${expected}).`);
    }
  }
  if (/Je ne connais pas le mot|d'une manière que je ne comprends pas/i.test(output)) {
    throw new Error(`${gameId} : une commande française du scénario n'est pas comprise.`);
  }
  if (
    /WELCOME TO ZORK|Vous êtes portant|Le lampe|Nous sommes à la jonction|elfe\. épée|non kempt|\bward\.|contrecŒur|votre nu mains|Dans bouteille|qui est ouvert\./i.test(
      output,
    )
  ) {
    throw new Error(`${gameId} : un défaut linguistique corrigé est réapparu.`);
  }
  if (!io.hasQuit) throw new Error(`${gameId} : le scénario français ne se termine pas.`);

  console.log(`✓ ${gameId.toUpperCase()} : ${scenario.commands.length} commandes françaises jouées.`);
}
