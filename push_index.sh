#!/bin/zsh
# Push a new index.html to GitHub Pages (hypsihypsi/dailypost, branch main).
# Usage: ./push_index.sh ["optional commit message"]
# Workflow: you generate/save a new index.html, then run this. Only index.html
# (and .gitignore) are ever staged — secrets/output stay local.
set -e
cd "$(dirname "$0")"

if ! git diff --quiet -- index.html && [ -f index.html ]; then :; fi

git add index.html .gitignore

if git diff --cached --quiet; then
  echo "Nothing new to push (index.html unchanged)."
  exit 0
fi

MSG="${1:-Update index.html ($(date '+%Y-%m-%d %H:%M'))}"
git commit -m "$MSG" -m "Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
git push origin main
echo "✓ Pushed. Pages will redeploy shortly: https://hypsihypsi.github.io/dailypost/"
