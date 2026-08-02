export const GAMES = [
  {
    id: 'zork1',
    numeral: 'I',
    title: 'Zork I',
    subtitle: 'Le Grand Empire Souterrain',
    eyebrow: 'Aux portes de l’Empire',
    description:
      'Une maison blanche, une boîte aux lettres et, sous vos pas, les vestiges d’un empire oublié.',
    file: './games/zork1.z3',
    release: 'Édition française · 2026',
    sourceRepository: 'https://github.com/historicalsource/zork1',
    accent: '#d8b66a',
    accentRgb: '216, 182, 106',
    motif: 'door',
  },
  {
    id: 'zork2',
    numeral: 'II',
    title: 'Zork II',
    subtitle: 'Le Magicien de Frobozz',
    eyebrow: 'Plus profondément encore',
    description:
      'Le royaume souterrain s’étend, et le fantasque Magicien de Frobozz veille sur ses mystères.',
    file: './games/zork2.z3',
    release: 'Édition française · 2026',
    sourceRepository: 'https://github.com/historicalsource/zork2',
    accent: '#b98ca4',
    accentRgb: '185, 140, 164',
    motif: 'orb',
  },
  {
    id: 'zork3',
    numeral: 'III',
    title: 'Zork III',
    subtitle: 'Le Maître du Donjon',
    eyebrow: 'Le dernier seuil',
    description:
      'Le Maître du Donjon vous attend au terme d’un voyage plus sombre, étrange et contemplatif.',
    file: './games/zork3.z3',
    release: 'Édition française · 2026',
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
  { command: 'observer', label: 'Observer', shortLabel: 'Voir', icon: 'eye' },
  { command: 'inventaire', label: 'Inventaire', shortLabel: 'Objets', icon: 'bag' },
  { command: 'attendre', label: 'Attendre', shortLabel: 'Attendre', icon: 'hourglass' },
  { command: 'aide', label: 'Aide du jeu', shortLabel: 'Aide', icon: 'spark' },
];

export const DIRECTIONS = [
  { command: 'nord-ouest', label: 'Nord-ouest', glyph: '↖', cell: 'nw' },
  { command: 'nord', label: 'Nord', glyph: '↑', cell: 'n' },
  { command: 'nord-est', label: 'Nord-est', glyph: '↗', cell: 'ne' },
  { command: 'ouest', label: 'Ouest', glyph: '←', cell: 'w' },
  { command: 'monter', label: 'Monter', glyph: 'H', cell: 'u' },
  { command: 'est', label: 'Est', glyph: '→', cell: 'e' },
  { command: 'sud-ouest', label: 'Sud-ouest', glyph: '↙', cell: 'sw' },
  { command: 'sud', label: 'Sud', glyph: '↓', cell: 's' },
  { command: 'sud-est', label: 'Sud-est', glyph: '↘', cell: 'se' },
  { command: 'descendre', label: 'Descendre', glyph: 'B', cell: 'd' },
];
