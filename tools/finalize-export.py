#!/usr/bin/env python3
"""Turn a Tag Manager export into the repository's template.tpl.

The Community Template Gallery requires the file produced by Tag Manager's own
exporter, with a `categories` entry added to INFO (the exporter omits it).

    python3 tools/finalize-export.py ~/Downloads/<exported file>

Checks the export, adds the categories entry, reports what differs from the
file currently in the repository, and writes the result to template.tpl.
"""
import json
import re
import shutil
import subprocess
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent
TARGET = REPO / 'template.tpl'
CATEGORIES = ["ADVERTISING", "MARKETING"]
EXPECTED_SECTIONS = ['INFO', 'TEMPLATE_PARAMETERS', 'SANDBOXED_JS_FOR_SERVER',
                     'SERVER_PERMISSIONS', 'TESTS', 'NOTES']

# Tag Manager's exporter omits this block, but every gallery-published template
# carries it. Byte-identical to the header in our already-listed templates.
TERMS_OF_SERVICE = (
    "___TERMS_OF_SERVICE___\n"
    "\n"
    "By creating or modifying this file you agree to Google Tag Manager's Community\n"
    "Template Gallery Developer Terms of Service available at\n"
    "https://developers.google.com/tag-manager/gallery-tos (or such other URL as\n"
    "Google may provide), as modified from time to time.\n"
    "\n"
    "\n"
)


def split_sections(text):
    parts = re.split(r'^___([A-Z_]+)___$', text, flags=re.M)
    return {parts[i]: parts[i + 1] for i in range(1, len(parts), 2)}


def main():
    if len(sys.argv) != 2:
        sys.exit(__doc__)
    source = Path(sys.argv[1]).expanduser()
    if not source.is_file():
        sys.exit(f"not found: {source}")

    # utf-8-sig drops the byte order mark the exporter writes; published
    # templates have no BOM.
    raw = source.read_bytes()
    text = raw.decode('utf-8-sig')
    if raw.startswith(b'\xef\xbb\xbf'):
        print("  stripped UTF-8 BOM")

    sections = split_sections(text)
    order = list(sections)

    print(f"Reading {source}")
    print(f"  sections: {order}")
    if order != EXPECTED_SECTIONS:
        missing = [s for s in EXPECTED_SECTIONS if s not in order]
        extra = [s for s in order if s not in EXPECTED_SECTIONS]
        print(f"  NOTE: differs from expected. missing={missing} extra={extra}")

    info = json.loads(sections['INFO'])
    print(f"  INFO keys: {list(info)}")

    # The exporter omits categories; the gallery requires at least one.
    if 'categories' not in info:
        print(f"  adding categories: {CATEGORIES}")
        info['categories'] = CATEGORIES
    else:
        print(f"  categories already present: {info['categories']}")

    if 'brand' in info:
        print("  WARNING: INFO contains a 'brand' block. Both TrackingHippo templates "
              "already in the gallery had no brand block at first submission; add it "
              "in a later version update instead.")

    rendered = json.dumps(info, indent=2, ensure_ascii=False)
    text = text.replace(sections['INFO'].strip('\n'), rendered, 1)

    if 'TERMS_OF_SERVICE' not in sections:
        print("  prepending ___TERMS_OF_SERVICE___ (the exporter omits it)")
        text = TERMS_OF_SERVICE + text

    # Compare with what is currently committed, purely for information.
    if TARGET.exists():
        current = split_sections(TARGET.read_text(encoding='utf-8'))
        for name in EXPECTED_SECTIONS:
            a, b = current.get(name, ''), split_sections(text).get(name, '')
            if a != b:
                print(f"  differs from repo copy: {name} "
                      f"({len(a)} -> {len(b)} chars)")
        shutil.copy(TARGET, TARGET.with_suffix('.tpl.handwritten'))
        print(f"  kept previous file as {TARGET.name}.handwritten")

    TARGET.write_text(text, encoding='utf-8')
    print(f"\nWrote {TARGET}")

    validator = REPO / 'tools' / 'validate.py'
    if validator.exists():
        subprocess.run([sys.executable, str(validator), str(TARGET)])


if __name__ == '__main__':
    main()
