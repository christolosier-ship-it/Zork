import { readFile, writeFile } from 'node:fs/promises';

const gmain = await readFile('translations/zil/en/zork2/gmain.zil', 'utf8');
const start = gmain.indexOf('\t\t\t\t\t <TELL "The ">');
const endMarker = '\t\t\t\t\t <TELL "n\'t here." CR>)';
const end = gmain.indexOf(endMarker, start);
if (start < 0 || end < 0) throw new Error('Bloc dynamique de gmain.zil introuvable.');

const patchesPath = 'translations/structural-overrides.fr.json';
const patches = JSON.parse(await readFile(patchesPath, 'utf8'));
patches['zork2/gmain.zil'] = [
  {
    source: gmain.slice(start, end + endMarker.length),
    replacement:
      '\t\t\t\t\t <COND (<EQUAL? ,P-NOT-HERE 1>\n' +
      '\t\t\t\t\t\t<TELL "L\'objet que vous avez mentionné n\'est pas ici." CR>)\n' +
      '\t\t\t\t\t       (<EQUAL? ,P-NOT-HERE .NUM>\n' +
      '\t\t\t\t\t\t<TELL "Les objets que vous avez mentionnés ne sont pas ici." CR>)\n' +
      '\t\t\t\t\t       (T\n' +
      '\t\t\t\t\t\t<TELL "Les autres objets que vous avez mentionnés ne sont pas ici." CR>)>)',
  },
];
patches['zork2/gverbs.zil'] = [
  {
    source: '<TELL "Sitting on the " D .OBJ " is: " CR>',
    replacement: '<TELL "Sur " D .OBJ ", vous voyez :" CR>',
  },
  {
    source: '<TELL "The " D .OBJ " is holding: " CR>',
    replacement: '<TELL D .OBJ " porte :" CR>',
  },
  {
    source: '<TELL "The " D .OBJ " contains:" CR>',
    replacement: '<TELL "Contenu (" D .OBJ ") :" CR>',
  },
];
patches['zork2/2actions.zil'] = [
  {
    source:
      '<TELL "The door is ">\n' +
      '\t\t<COND (<FSET? ,CRYPT-DOOR ,OPENBIT>\n' +
      '\t\t       <TELL "open.">)\n' +
      '\t\t      (T <TELL "closed.">)>',
    replacement:
      '<COND (<FSET? ,CRYPT-DOOR ,OPENBIT>\n' +
      '\t\t       <TELL "La porte est ouverte.">)\n' +
      '\t\t      (T <TELL "La porte est fermée.">)>',
  },
  {
    source:
      '<COND (<FSET? ,CRYPT-DOOR ,OPENBIT>\n' +
      '\t\t\t      <TELL "open.">)\n' +
      '\t\t\t     (T <TELL "closed.">)>',
    replacement:
      '<COND (<FSET? ,CRYPT-DOOR ,OPENBIT>\n' +
      '\t\t\t      <TELL "ouverte.">)\n' +
      '\t\t\t     (T <TELL "fermée.">)>',
  },
  {
    source:
      '<TELL\n' +
      '"This is a room which is bare on all sides. There is an exit down in\n' +
      'the northwest corner of the room. To the east is a great ">\n' +
      '\t\t<COND (<FSET? ,RIDDLE-DOOR ,OPENBIT>\n' +
      '\t\t       <TELL "open">)\n' +
      '\t\t      (T\n' +
      '\t\t       <TELL "closed">)>\n' +
      '\t\t<TELL " door made of\n' +
      'stone. Above the stone, the following words are written: \\"No man shall\n' +
      'pass this door without solving this riddle:|\n' +
      '|\n' +
      '  What is tall as a house,|\n' +
      '    round as a cup,|\n' +
      '      and all the king\'s horses|\n' +
      '        can\'t draw it up?\\"|\n' +
      '">',
    replacement:
      '<TELL "Cette salle est entièrement nue. Dans l\'angle nord-ouest, une issue descend vers le bas. À l\'est se dresse une grande porte de pierre ">\n' +
      '\t\t<COND (<FSET? ,RIDDLE-DOOR ,OPENBIT>\n' +
      '\t\t       <TELL "ouverte">)\n' +
      '\t\t      (T <TELL "fermée">)>\n' +
      '\t\t<TELL ". Au-dessus sont gravés ces mots : \\"Nul ne franchira cette porte sans résoudre l\'énigme :|\n' +
      '|\n' +
      '    Qu\'est-ce qui est haut comme une maison,|\n' +
      '      rond comme une coupe,|\n' +
      '        et que tous les chevaux du roi|\n' +
      '          ne sauraient faire remonter ?\\"|\n' +
      '">',
  },
  {
    source:
      '<TELL\n' +
      '"You are in a small room, which was used by a bank officer who retrieved\n' +
      'safety deposit boxes for the customer. On the north side of the room is a\n' +
      'sign which reads  \\"Viewing Room\\". On the ">\n' +
      '\t   <COND (<EQUAL? ,HERE ,TELLER-WEST> <TELL "west">)\n' +
      '\t\t (T <TELL "east">)>\n' +
      '\t   <TELL " side of the room, above an open door, is a sign reading:|\n' +
      '|\n' +
      '          BANK PERSONNEL ONLY|\n' +
      '" CR>',
    replacement:
      '<TELL "Vous êtes dans une petite salle autrefois utilisée par le préposé chargé d\'apporter les coffres de dépôt aux clients. Sur le mur nord, un panneau indique \\"Salle de consultation\\". Du côté ">\n' +
      '\t   <COND (<EQUAL? ,HERE ,TELLER-WEST> <TELL "ouest">)\n' +
      '\t\t (T <TELL "est">)>\n' +
      '\t   <TELL " de la salle, au-dessus d\'une porte ouverte, un panneau indique :|\n' +
      '|\n' +
      '          RÉSERVÉ AU PERSONNEL|\n' +
      '          DE LA BANQUE|\n' +
      '" CR>',
  },
];

await writeFile(patchesPath, `${JSON.stringify(patches, null, 2)}\n`);
console.log('Zork II : assemblages dynamiques principaux reformulés.');
