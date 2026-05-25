#!/bin/bash
set -euo pipefail

# Check if .deps exists (GitHub Actions mode), otherwise look at sibling folders (Local mode)
if [ -d ".deps" ]; then
    BASE=".deps"
else
    BASE=".."
fi

# Validate source files exist and are non-empty
for src in "$BASE/prism-setup/README.md" "$BASE/prism-flutter-backend/README.md" "$BASE/prism-flutter-web-frontend/README.md" "$BASE/prism-ml/README.md"; do
    if [ ! -s "$src" ]; then
        echo "ERROR: Source file '$src' is missing or empty!" >&2
        exit 1
    fi
done

# Promote headings by one level (#→##, ##→###, etc.) but only outside fenced
# code blocks, so that comment lines like "# some comment" are left alone.
promote_headings() {
  awk '
    /^```/ { fence = !fence }
    !fence && /^#/ { sub(/^#/, "##") }
    { print }
  '
}

# Many of the existing READMEs have slightly different formats, clean them here.
# - tail skips the preamble (title, description, separator) of each README
# - promote_headings shifts heading levels to nest under the parent page sections
# - sed converts --- rules to <hr> so Quarto doesn't treat them as YAML fences
# tail -n +5 "$BASE/prism-setup/README.md"               | promote_headings | sed 's/^---$/<hr>/' > guide/_setup_readme.qmd
# tail -n +8 "$BASE/prism-flutter-backend/README.md"      | promote_headings | sed 's/^---$/<hr>/' > guide/_flutter-backend_readme.qmd
# tail -n +2 "$BASE/prism-flutter-web-frontend/README.md" | promote_headings | sed 's/^---$/<hr>/' > guide/_flutter-web-frontend_readme.qmd
# tail -n +2 "$BASE/prism-ml/README.md"                   | promote_headings | sed 's/^---$/<hr>/' > guide/_ml_readme.qmd

tail -n +5 "$BASE/prism-setup/README.md"               | promote_headings | sed 's/^---$/<hr>/' > guide/_setup_readme.qmd
tail -n +8 "$BASE/prism-flutter-backend/README.md"      | promote_headings | sed 's/^---$/<hr>/' > guide/_flutter-backend_readme.qmd
tail -n +2 "$BASE/prism-flutter-web-frontend/README.md" | promote_headings | sed 's/^---$/<hr>/' > guide/_flutter-web-frontend_readme.qmd
tail -n +2 "$BASE/prism-ml/README.md"                   | promote_headings | sed 's/^---$/<hr>/' > guide/_ml_readme.qmd


# Validate output files were generated with content
# for out in guide/_setup_readme.qmd guide/_flutter-backend_readme.qmd guide/_flutter-web-frontend_readme.qmd guide/_ml_readme.qmd; do
#     if [ ! -s "$out" ]; then
#         echo "ERROR: Output file '$out' is empty after generation!" >&2
#         exit 1
#     fi
#     echo "OK: $out ($(wc -l < "$out") lines)"
# done
