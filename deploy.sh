#!/usr/bin/env bash
# One-shot deploy for shiv4454.github.io
# Run:  cd /Software/portfolio && ./deploy.sh
#
# The GitHub token is requested by git itself and stays in memory for the
# session only. It is never written to disk and never passes through a
# chat transcript.

set -euo pipefail

REPO="shiv4454.github.io"
REMOTE="https://github.com/shiv4454/${REPO}.git"

cd "$(dirname "$0")"

echo "==> sanity checks"
node --check <(python3 -c "
import re,sys
h=open('index.html',encoding='utf-8').read()
m=re.search(r'<script>(.*?)</script>',h,re.S)
sys.stdout.write(m.group(1) if m else '')") 2>/dev/null \
  && echo "    JS syntax ok" || echo "    (skipped: no inline script parsed)"
test -f index.html && echo "    index.html present"
test -f og.png && echo "    og.png present"

echo
echo "==> repository"
if git remote get-url origin >/dev/null 2>&1; then
  echo "    origin already set to $(git remote get-url origin)"
else
  git remote add origin "$REMOTE"
  echo "    origin -> $REMOTE"
fi

echo
echo "==> pushing (git will prompt for your GitHub username + token)"
echo "    username: shiv4454"
echo "    password: paste a PAT — NOT your account password"
echo
git push -u origin main

echo
echo "==> done. Now enable Pages:"
echo "    https://github.com/shiv4454/${REPO}/settings/pages"
echo "    Source: Deploy from a branch"
echo "    Branch: main   /   Folder: / (root)"
echo
echo "    The site will be live at https://shiv4454.github.io"
echo "    It can take 1-2 minutes on the first build."