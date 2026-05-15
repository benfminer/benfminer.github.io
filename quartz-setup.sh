#!/usr/bin/env bash
# quartz-setup.sh
# Run from your Mac terminal inside ~/Documents/Obsidian\ Vault/transition-wiki/my-vault-site
# Each section is labeled — if something fails, stop and share the error output.

set -e  # exit immediately on any error

SITE_DIR="$HOME/Documents/Obsidian Vault/transition-wiki/my-vault-site"
VAULT_DIR="$HOME/Documents/Obsidian Vault/transition-wiki"
GITHUB_USER="benfminer"
REPO_NAME="benfminer.github.io"

echo ""
echo "==> Step 1: Switch to Node 22 via nvm"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm use 22
node --version

echo ""
echo "==> Step 2: Install dependencies"
cd "$SITE_DIR"
npm ci

echo ""
echo "==> Step 3: Link your Obsidian vault as the content folder"
rm -rf "$SITE_DIR/content"
ln -s "$VAULT_DIR" "$SITE_DIR/content"
echo "Symlink created: $SITE_DIR/content -> $VAULT_DIR"

echo ""
echo "==> Step 4: Preview the site locally (opens at http://localhost:8080)"
echo "     Press Ctrl+C when you're done previewing to continue the script."
npx quartz build --serve

echo ""
echo "==> Step 5: Initialize git and set up GitHub remote"
cd "$SITE_DIR"
git init
git checkout -b v4 2>/dev/null || git checkout v4
git remote add origin "https://github.com/$GITHUB_USER/$REPO_NAME.git" 2>/dev/null \
  || git remote set-url origin "https://github.com/$GITHUB_USER/$REPO_NAME.git"

echo ""
echo "==> Step 6: Commit and push"
git add -A
git commit -m "Initial Quartz v4 setup with Transition Resources vault"
git push -u origin v4

echo ""
echo "==> All done!"
echo "    Go to: https://github.com/$GITHUB_USER/$REPO_NAME/settings/pages"
echo "    Set Source to: GitHub Actions"
echo "    Your site will be live at: https://$REPO_NAME"
