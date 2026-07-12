#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_DIR"

REMOTE_URL="https://github.com/lawlabs/lawmatic-skills.git"

echo "→ Репозиторий: $REPO_DIR"

if [ ! -d .git ]; then
  git init
fi

git add .
git status

if git diff --cached --quiet; then
  echo "Нечего коммитить."
else
  git commit -m "$(cat <<'EOF'
Initial commit: LawMatic agent skills repository scaffold

Add README, LICENSE, .gitignore, and skills directory structure for public distribution via skills.sh.
EOF
)"
fi

git branch -M main

if ! git remote get-url origin &>/dev/null; then
  git remote add origin "$REMOTE_URL"
fi

echo "→ Push в $REMOTE_URL"
git push -u origin main

echo "✓ Готово: https://github.com/lawlabs/lawmatic-skills"
