#!/bin/bash

# Dotfiles installation script
# This script sets up symlinks from your home directory to the dotfiles repository

set -e

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing dotfiles from $DOTFILES_DIR"

# Create symlink for .zshrc
if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
  echo "Backing up existing .zshrc to .zshrc.backup"
  mv "$HOME/.zshrc" "$HOME/.zshrc.backup"
fi

ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
echo "✓ Linked .zshrc"

# Create .zsh_secrets if it doesn't exist
if [ ! -f "$DOTFILES_DIR/.zsh_secrets" ]; then
  echo "Creating .zsh_secrets file..."
  cat > "$DOTFILES_DIR/.zsh_secrets" << 'EOF'
# --- API KEYS (keep private)
# This file contains sensitive information and should not be committed to git
export GEMINI_API_KEY=""
EOF
  echo "✓ Created .zsh_secrets (remember to add your API keys!)"
else
  echo "✓ .zsh_secrets already exists"
fi

echo ""
echo "Installation complete!"
echo ""
echo "Next steps:"
echo "1. Add your API keys to $DOTFILES_DIR/.zsh_secrets"
echo "2. Run: source ~/.zshrc"
echo ""

