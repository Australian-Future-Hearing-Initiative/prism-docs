#!/bin/bash

# Check if .deps exists (GitHub Actions mode), otherwise look at sibling folders (Local mode)
if [ -d ".deps" ]; then
    BASE=".deps"
else
    BASE=".."
fi

tail -n +5 $BASE/prism-setup/README.md | sed 's/^#/##/' | sed 's/^---$/<hr>/' > guide/_setup_readme.qmd
tail -n +8 $BASE/prism-flutter-backend/README.md | sed 's/^#/##/' | sed 's/^---$/<hr>/' > guide/_flutter-backend_readme.qmd
tail -n +2 $BASE/prism-flutter-web-frontend/README.md | sed 's/^#/##/' | sed 's/^---$/<hr>/' > guide/_flutter-web-frontend_readme.qmd
