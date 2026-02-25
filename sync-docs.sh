#!/bin/bash

tail -n +5 ../prism-setup/README.md | sed 's/^#/##/' > guide/_setup_readme.qmd
tail -n +8 ../prism-flutter-backend/README.md | sed 's/^#/##/' > guide/_flutter-backend_readme.qmd
tail -n +2 ../prism-flutter-web-frontend/README.md | sed 's/^#/##/' > guide/_flutter-web-frontend_readme.qmd
