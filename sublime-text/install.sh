#!/usr/bin/env bash
#
# Bootstrap Sublime Text for Laravel development on a macOS machine.
# Idempotent: safe to re-run.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SUPPORT="$HOME/Library/Application Support/Sublime Text"
USER_DIR="$SUPPORT/Packages/User"
INSTALLED="$SUPPORT/Installed Packages"
PC_PACKAGE="Package Control.sublime-package"

echo "==> Sublime Laravel setup"

# --- 1. Sublime Text -------------------------------------------------------
if [ ! -d "/Applications/Sublime Text.app" ]; then
    if command -v brew >/dev/null 2>&1; then
        echo "==> Installing Sublime Text (brew cask)"
        brew install --cask sublime-text
    else
        echo "!! Homebrew not found. Install Sublime Text from https://sublimetext.com and re-run." >&2
        exit 1
    fi
else
    echo "==> Sublime Text already installed"
fi

# --- 2. Package Control 4.2.8+ (3.4.1 does not run on current builds) -------
mkdir -p "$INSTALLED"
if [ -f "$INSTALLED/$PC_PACKAGE" ]; then
    echo "==> Package Control present; leaving as-is"
else
    echo "==> Installing Package Control 4.2.8"
    cp "$REPO_DIR/vendor/$PC_PACKAGE" "$INSTALLED/$PC_PACKAGE"
fi

# --- 3. Symlink user config ------------------------------------------------
mkdir -p "$USER_DIR"
for src in "$REPO_DIR/User"/*; do
    [ -e "$src" ] || continue
    name="$(basename "$src")"
    dst="$USER_DIR/$name"
    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        echo "    backing up existing $name -> $name.bak"
        mv "$dst" "$dst.bak"
    fi
    ln -sfn "$src" "$dst"
    echo "    linked $name"
done

# --- 4. Global tools -------------------------------------------------------
if command -v npm >/dev/null 2>&1; then
    if ! command -v blade-formatter >/dev/null 2>&1; then
        echo "==> Installing blade-formatter (used by the BladeFormatter package)"
        npm install -g blade-formatter
    else
        echo "==> blade-formatter already installed"
    fi
else
    echo "!! npm not found - install Node.js, then run: npm install -g blade-formatter" >&2
fi

cat <<'EOT'

==> Done.

Launch Sublime Text. On first start Package Control auto-installs the
packages listed in User/Package Control.sublime-settings, then the LSP
servers download themselves the first time you open a PHP/Blade file.

Reminder: never point "color_scheme"/"theme" at a package that is not
installed - the startup error dialog blocks all plugins.
EOT
