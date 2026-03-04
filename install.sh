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

# --- SSH Setup ---
echo ""
echo "Setting up SSH configuration..."

# Create ~/.ssh if it doesn't exist
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

# Symlink SSH config (merge-friendly: include from dotfiles)
if [ -f "$HOME/.ssh/config" ] && [ ! -L "$HOME/.ssh/config" ]; then
  echo "Backing up existing SSH config to ~/.ssh/config.backup"
  mv "$HOME/.ssh/config" "$HOME/.ssh/config.backup"
fi
ln -sf "$DOTFILES_DIR/ssh/config" "$HOME/.ssh/config"
chmod 600 "$HOME/.ssh/config"
echo "✓ Linked SSH config"

# Copy SSH keys (copy, not symlink, for stricter permission control)
for key in oracle github-personal github-work; do
  if [ -f "$DOTFILES_DIR/ssh/$key" ]; then
    cp "$DOTFILES_DIR/ssh/$key" "$HOME/.ssh/$key"
    chmod 600 "$HOME/.ssh/$key"
    echo "✓ Installed $key private key"
  fi
  if [ -f "$DOTFILES_DIR/ssh/$key.pub" ]; then
    cp "$DOTFILES_DIR/ssh/$key.pub" "$HOME/.ssh/$key.pub"
    chmod 644 "$HOME/.ssh/$key.pub"
    echo "✓ Installed $key public key"
  fi
done

echo ""
echo "Installation complete!"
echo ""
echo "Next steps:"
echo "1. Add your API keys to $DOTFILES_DIR/.zsh_secrets"
echo "2. Run: source ~/.zshrc"
echo "3. Generate GitHub SSH keys:"
echo "   ssh-keygen -t ed25519 -C 'spikeysanju98@gmail.com' -f ~/.ssh/github-personal"
echo "   ssh-keygen -t ed25519 -C 'sanju@theagi.company' -f ~/.ssh/github-work"
echo "4. Add public keys to each GitHub account"
echo "5. Test: ssh -T git@github.com && ssh -T git@github-work"
echo ""

