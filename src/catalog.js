export const GAMES = [
  {
    id: 'zork1',
    numeral: 'I',
    title: 'Zork I',
    subtitle: 'The Great Underground Empire',
    eyebrow: 'Aux portes de l’Empire',
    description:
      'Une maison blanche, une boîte aux lettres et, sous vos pas, les vestiges d’un empire oublié.',
    file: './games/zork1.z3',
    release: 'Release 119 · 880429',
    sourceRepository: 'https://github.com/historicalsource/zork1',
    accent: '#d8b66a',
    accentRgb: '216, 182, 106',
    motif: 'door',
  },
  {
    id: 'zork2',
    numeral: 'II',
    title: 'Zork II',
    subtitle: 'The Wizard of Frobozz',
    eyebrow: 'Plus profondément encore',
    description:
      'Le royaume souterrain s’étend, et le fantasque Magicien de Frobozz veille sur ses mystères.',
    file: './games/zork2.z3',
    release: 'Release 63 · 860811',
    sourceRepository: 'https://github.com/historicalsource/zork2',
    accent: '#b98ca4',
    accentRgb: '185, 140, 164',
    motif: 'orb',
  },
  {
    id: 'zork3',
    numeral: 'III',
    title: 'Zork III',
    subtitle: 'The Dungeon Master',
    eyebrow: 'Le dernier seuil',
    description:
      'Le Maître du Donjon vous attend au terme d’un voyage plus sombre, étrange et contemplatif.',
    file: './games/zork3.z3',
    release: 'Release 25 · 860811',
    sourceRepository: 'https://github.com/historicalsource/zork3',
    accent: '#8fb19b',
    accentRgb: '143, 177, 155',
    motif: 'maze',
  },
];

export function getGame(gameId) {
  return GAMES.find((game) => game.id === gameId) ?? null;
}

export const QUICK_COMMANDS = [
  { command: 'look', label: 'Observer', shortLabel: 'Voir', icon: 'eye' },
  { command: 'inventory', label: 'Inventaire', shortLabel: 'Objets', icon: 'bag' },
  { command: 'wait', label: 'Attendre', shortLabel: 'Attendre', icon: 'hourglass' },
  { command: 'help', label: 'Aide du jeu', shortLabel: 'Aide', icon: 'spark' },
];

export const DIRECTIONS = [
  { command: 'northwest', label: 'Nord-ouest', glyph: '↖', cell: 'nw' },
  { command: 'north', label: 'Nord', glyph: '↑', cell: 'n' },
  { command: 'northeast', label: 'Nord-est', glyph: '↗', cell: 'ne' },
  { command: 'west', label: 'Ouest', glyph: '←', cell: 'w' },
  { command: 'up', label: 'Monter', glyph: 'U', cell: 'u' },
  { command: 'east', label: 'Est', glyph: '→', cell: 'e' },
  { command: 'southwest', label: 'Sud-ouest', glyph: '↙', cell: 'sw' },
  { command: 'south', label: 'Sud', glyph: '↓', cell: 's' },
  { command: 'southeast', label: 'Sud-est', glyph: '↘', cell: 'se' },
  { command: 'down', label: 'Descendre', glyph: 'D', cell: 'd' },
];
