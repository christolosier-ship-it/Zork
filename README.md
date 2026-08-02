<p align="center">
  <img src="public/icons/icon-192.png" width="112" height="112" alt="Porte du Grand Empire souterrain">
</p>

<h1 align="center">Zork — La trilogie interactive</h1>

<p align="center">
  Une PWA moderne pour explorer les trois jeux historiques d’Infocom avec leur véritable moteur Z‑Machine.
</p>

## L’expérience

- **Trois jeux complets** : Zork I, Zork II et Zork III dans une seule bibliothèque.
- **Moteur authentique** : exécution des programmes Z‑Machine v3 historiques, sans réécriture des énigmes ni du parser.
- **Interface moderne** : terminal adaptatif, statut, rose des déplacements, raccourcis tactiles et historique des commandes.
- **Sauvegardes séparées** : une progression locale par volume, restaurable depuis la bibliothèque.
- **PWA hors ligne** : installation sur ordinateur, tablette ou smartphone et mise en cache de toute la trilogie.
- **Confort de lecture** : trois ambiances, trois tailles de texte et mode à animations réduites.
- **Export du récit** : téléchargement de la transcription d’une session au format texte.

> L’interface est en français. Les programmes historiques et leurs textes restent en anglais afin de préserver l’expérience originale.

## Démarrage local

Prérequis : Node.js 20 ou plus récent.

```bash
npm install
npm run dev
```

Puis ouvrir l’adresse indiquée par Vite. Pour contrôler et construire la version de production :

```bash
npm test
npm run build
npm run preview
```

## Structure

```text
public/
├── games/            Programmes Z‑Machine v3
├── icons/            Icônes PWA originales
├── manifest.webmanifest
└── sw.js             Cache hors ligne
src/
├── catalog.js        Métadonnées de la trilogie
├── main.js           Navigation et orchestration
├── storage.js        Réglages et sauvegardes locales
├── style.css         Interface responsive et thèmes
└── zork-io.js        Adaptateur navigateur de la Z‑Machine
```

## Déploiement

Le workflow GitHub Pages construit automatiquement `dist/` et publie l’application à chaque push sur `main`. La source utilise des chemins relatifs afin de fonctionner aussi bien à la racine que sous `/Zork/`.

## Préservation et licences

Les sources de Zork I, II et III ont été publiées sous licence MIT par Microsoft en 2025. Cette publication ne transfère pas les marques Zork ou Infocom ni les visuels commerciaux historiques. L’application est une adaptation non officielle et ne reproduit aucun packaging commercial.

L’interpréteur [`zmachine`](https://www.npmjs.com/package/zmachine) de Daniel Lockard est distribué sous licence MIT. Les textes complets et les empreintes des programmes sont regroupés dans [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).

Le code propre à cette interface est disponible sous [licence MIT](LICENSE).
