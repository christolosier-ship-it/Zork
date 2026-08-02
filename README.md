<p align="center">
  <img src="public/icons/icon-192.png" width="112" height="112" alt="Porte du Grand Empire souterrain">
</p>

<h1 align="center">Zork — La trilogie interactive</h1>

<p align="center">
  Une PWA moderne et française pour explorer les trois jeux historiques d’Infocom avec leur véritable moteur Z‑Machine.
</p>

## L’expérience

- **Trois jeux complets** : Zork I, Zork II et Zork III dans une seule bibliothèque.
- **Trilogie en français** : récits, descriptions, messages système et interface localisés.
- **Commandes françaises** : une couche d’entrée traduit les formulations françaises pour le parseur historique, sans modifier les énigmes.
- **Moteur authentique** : exécution de programmes Z‑Machine v3 recompilés depuis les sources officielles.
- **Interface moderne** : terminal adaptatif, statut, rose des déplacements, raccourcis tactiles et historique des commandes.
- **Sauvegardes séparées** : une progression locale par volume, restaurable depuis la bibliothèque.
- **PWA hors ligne** : installation sur ordinateur, tablette ou smartphone et mise en cache de toute la trilogie.
- **Confort de lecture** : trois ambiances, trois tailles de texte et mode à animations réduites.
- **Export du récit** : téléchargement de la transcription d’une session au format texte.

> Les trois aventures sont jouables en français. La localisation est une première édition communautaire révisable : les sources et chaque chaîne traduite sont incluses dans le dépôt.

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
├── french-commands.js Traduction des commandes françaises pour le parseur
├── main.js           Navigation et orchestration
├── storage.js        Réglages et sauvegardes locales
├── style.css         Interface responsive et thèmes
└── zork-io.js        Adaptateur navigateur de la Z‑Machine
translations/
├── catalog.fr.json   Catalogue anglais → français
├── manual-overrides.fr.json Corrections éditoriales prioritaires
├── structural-overrides.fr.json Reformulations des messages ZIL dynamiques
└── zil/              Sources ZIL anglaises et françaises
```

## Localisation française

La recherche menée dans les archives de fiction interactive, IFDB et les dépôts publics n’a pas permis d’identifier une trilogie Zork complète déjà disponible en français. Cette édition part donc des [sources ouvertes officielles](https://github.com/historicalsource) publiées sous licence MIT.

Le catalogue couvre les **3 651 chaînes anglaises uniques** des trois jeux. Les longues descriptions ont reçu une passe hors ligne avec [Argos Translate](https://github.com/argosopentech/argos-translate) et son modèle anglais → français 1.9. La passe éditoriale s’appuie ensuite sur [LanguageTool](https://languagetool.org/fr/proofreading-api) pour la grammaire, l’orthographe et le style, ainsi que sur le dictionnaire anglais-français [WordReference / Collins](https://www.wordreference.com/enfr/) pour les choix lexicaux ambigus.

Les corrections vérifiées sont conservées dans `manual-overrides.fr.json`. Les rares phrases construites dynamiquement par ZIL, pour lesquelles un simple remplacement mot à mot produirait un mauvais accord, sont reformulées de façon reproductible dans `structural-overrides.fr.json`. Pour réappliquer le catalogue aux sources ZIL :

```bash
npm run localize
```

Le script optionnel `scripts/translate-catalog-offline.py` permet de refaire la passe hors ligne après installation d’Argos Translate et de son modèle anglais → français. Le modèle n’est pas inclus dans ce dépôt. `npm test` contrôle également l’application des surcharges, les résidus anglais déjà corrigés, 423 descriptions d’objets et des scénarios joués dans chacun des trois volumes.

## Déploiement

Le workflow GitHub Pages construit automatiquement `dist/` et publie l’application à chaque push sur `main`. La source utilise des chemins relatifs afin de fonctionner aussi bien à la racine que sous `/Zork/`.

## Préservation et licences

Les sources de Zork I, II et III ont été publiées sous licence MIT par Microsoft en 2025. Les programmes distribués ici sont des versions françaises dérivées et recompilées de ces sources. Cette publication ne transfère pas les marques Zork ou Infocom ni les visuels commerciaux historiques. L’application est une adaptation non officielle et ne reproduit aucun packaging commercial.

L’interpréteur [`zmachine`](https://www.npmjs.com/package/zmachine) de Daniel Lockard est distribué sous licence MIT. Les textes complets et les empreintes des programmes sont regroupés dans [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).

Le code propre à cette interface est disponible sous [licence MIT](LICENSE).
