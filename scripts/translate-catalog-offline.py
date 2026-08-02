#!/usr/bin/env python3
"""Improve the French catalog with the local Argos Translate en→fr model.

The JavaScript extractor remains the source of truth for ZIL parsing. This
companion command replaces generated translations without touching English
keys, then `node scripts/localize-zil.mjs` reapplies the catalog to the sources.

Install the Argos Translate package and its English → French model first. The
script deliberately keeps the model outside the repository.
"""

from __future__ import annotations

import argparse
import json
import os
import re
import tempfile
from datetime import datetime, timezone
from pathlib import Path


ROOT = Path(__file__).resolve().parent.parent
CATALOG_PATH = ROOT / "translations" / "catalog.fr.json"
OVERRIDES_PATH = ROOT / "translations" / "manual-overrides.fr.json"

GLOSSARY = (
    ("The Great Underground Empire", "Le Grand Empire Souterrain"),
    ("Great Underground Empire", "Grand Empire Souterrain"),
    ("The Wizard of Frobozz", "Le Magicien de Frobozz"),
    ("Wizard of Frobozz", "Magicien de Frobozz"),
    ("The Dungeon Master", "Le Maître du Donjon"),
    ("Dungeon Master", "Maître du Donjon"),
    ("Lord Dimwit Flathead", "Seigneur Nigaud Tête-Plate"),
    ("Dimwit Flathead", "Nigaud Tête-Plate"),
    ("Flathead", "Tête-Plate"),
    ("Frobozz", "Frobozz"),
    ("Quendor", "Quendor"),
    ("Aragain", "Aragain"),
    ("Zorkmids", "zorkmids"),
    ("Zorkmid", "zorkmid"),
    ("ZORK", "ZORK"),
    ("Zork", "Zork"),
)

def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--scope",
        choices=("multiline", "all"),
        default="multiline",
        help="Retraduire les chaînes multilignes (défaut) ou tout le catalogue.",
    )
    parser.add_argument("--threads", type=int, default=max(1, min(8, os.cpu_count() or 1)))
    return parser.parse_args()


def protect(source: str) -> tuple[str, list[tuple[str, str]]]:
    text = source.replace("\r\n", " ").replace("\n", " ")
    text = text.replace("|", "ZXPIPEQ").replace("\\", "ZXSLASHQ")
    terms: list[tuple[str, str]] = []
    for english, french in GLOSSARY:
        pattern = re.compile(re.escape(english))

        def substitute(_match: re.Match[str]) -> str:
            token = f"ZXTERM{len(terms):03d}Q"
            terms.append((token, french))
            return token

        text = pattern.sub(substitute, text)
    return text, terms


def normalize(text: str) -> str:
    return (
        text.replace("’", "'")
        .replace("‘", "'")
        .replace("“", '"')
        .replace("”", '"')
        .replace("…", "...")
        .replace("—", "--")
        .replace("–", "--")
        .replace("\u00a0", " ")
    )


def restore_and_validate(
    source: str, translated: str, terms: list[tuple[str, str]]
) -> tuple[str | None, str | None]:
    for token, french in terms:
        translated = translated.replace(token, french)
    translated = normalize(translated.replace("ZXPIPEQ", "|").replace("ZXSLASHQ", "\\"))

    if translated.count("|") != source.count("|"):
        return None, "séparateurs de ligne altérés"
    if translated.count("\\") != source.count("\\"):
        return None, "barres obliques altérées"
    if "ZXTERM" in translated or "ZXPIPE" in translated or "ZXSLASH" in translated:
        return None, "jeton de protection non restauré"
    if len(source) > 80 and len(translated) < len(source) * 0.35:
        return None, "sortie anormalement courte"
    if not translated.strip():
        return None, "sortie vide"
    return translated, None


def translate_batch(
    selected: list[tuple[str, str]], threads: int
) -> list[tuple[str, str | None, str | None]]:
    import argostranslate.translate
    import ctranslate2

    translation = argostranslate.translate.get_translation_from_codes("en", "fr")
    while translation is not None and hasattr(translation, "underlying"):
        translation = translation.underlying
    if translation is None or not hasattr(translation, "pkg"):
        raise RuntimeError("Le modèle Argos Translate anglais → français n'est pas installé.")

    pkg = translation.pkg
    translator = ctranslate2.Translator(
        str(pkg.package_path / "model"),
        device="cpu",
        inter_threads=1,
        intra_threads=threads,
        compute_type="auto",
    )
    protected_records = [(source, *protect(source)) for source, _previous in selected]
    tokenized = [pkg.tokenizer.encode(protected) for _source, protected, _terms in protected_records]
    oversized = [len(tokens) for tokens in tokenized if len(tokens) > 500]
    if oversized:
        raise RuntimeError(
            f"{len(oversized)} chaînes dépassent la limite sûre du modèle (maximum {max(oversized)} jetons)."
        )

    target_prefix = None
    if pkg.target_prefix:
        target_prefix = [[pkg.target_prefix]] * len(tokenized)
    generated = translator.translate_batch(
        tokenized,
        target_prefix=target_prefix,
        replace_unknowns=True,
        max_batch_size=2048,
        batch_type="tokens",
        beam_size=4,
        num_hypotheses=1,
        length_penalty=0.2,
        return_scores=False,
    )

    results = []
    for (source, _protected, terms), generated_item in zip(protected_records, generated):
        translated = pkg.tokenizer.decode(generated_item.hypotheses[0])
        if pkg.target_prefix and translated.startswith(pkg.target_prefix):
            translated = translated[len(pkg.target_prefix) :]
        translated, error = restore_and_validate(source, translated.lstrip(), terms)
        results.append((source, translated, error))
    return results


def atomic_write(payload: dict) -> None:
    with tempfile.NamedTemporaryFile(
        "w", encoding="utf-8", dir=CATALOG_PATH.parent, delete=False
    ) as handle:
        json.dump(payload, handle, ensure_ascii=False, indent=2)
        handle.write("\n")
        temporary_path = Path(handle.name)
    temporary_path.replace(CATALOG_PATH)


def main() -> None:
    args = parse_args()
    catalog = json.loads(CATALOG_PATH.read_text(encoding="utf-8"))
    translations: dict[str, str] = catalog["translations"]
    overrides = json.loads(OVERRIDES_PATH.read_text(encoding="utf-8"))
    selected = [
        (source, french)
        for source, french in translations.items()
        if args.scope == "all" or "\n" in source
    ]

    print(f"Traduction hors ligne vectorisée : {len(selected)} chaînes...")
    failures: list[tuple[str, str]] = []
    for source, translated, error in translate_batch(selected, args.threads):
        if translated is None:
            failures.append((source, error or "erreur inconnue"))
        else:
            translations[source] = translated
    translations.update(overrides)
    catalog["meta"].update(
        {
            "generatedAt": datetime.now(timezone.utc).isoformat(),
            "offlineRevisionScope": args.scope,
            "offlineRevisionCount": len(selected) - len(failures),
            "generator": "Argos Translate en_fr 1.9 + surcharges éditoriales",
        }
    )
    atomic_write(catalog)

    if failures:
        for source, error in failures[:20]:
            print(f"⚠ {error}: {source[:90]!r}")
        print(f"{len(failures)} chaînes conservées dans leur version précédente.")
    print(f"Catalogue mis à jour : {len(selected) - len(failures)} chaînes retraduites.")


if __name__ == "__main__":
    main()
