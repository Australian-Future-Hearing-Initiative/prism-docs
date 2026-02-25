#!/bin/bash
set -euo pipefail

# Check if .deps exists (GitHub Actions mode), otherwise look at sibling folders (Local mode)
if [ -d ".deps" ]; then
    BASE=".deps"
else
    BASE=".."
fi

# Validate source files exist and are non-empty
for src in "$BASE/prism-setup/README.md" "$BASE/prism-flutter-backend/README.md" "$BASE/prism-flutter-web-frontend/README.md"; do
    if [ ! -s "$src" ]; then
        echo "ERROR: Source file '$src' is missing or empty!" >&2
        exit 1
    fi
done

tail -n +5 "$BASE/prism-setup/README.md" | sed 's/^#/##/' | sed 's/^---$/<hr>/' > guide/_setup_readme.qmd
tail -n +8 "$BASE/prism-flutter-backend/README.md" | sed 's/^#/##/' | sed 's/^---$/<hr>/' > guide/_flutter-backend_readme.qmd
tail -n +2 "$BASE/prism-flutter-web-frontend/README.md" | sed 's/^#/##/' | sed 's/^---$/<hr>/' > guide/_flutter-web-frontend_readme.qmd

# Validate output files were generated with content
for out in guide/_setup_readme.qmd guide/_flutter-backend_readme.qmd guide/_flutter-web-frontend_readme.qmd; do
    if [ ! -s "$out" ]; then
        echo "ERROR: Output file '$out' is empty after generation!" >&2
        exit 1
    fi
    echo "OK: $out ($(wc -l < "$out") lines)"
done
