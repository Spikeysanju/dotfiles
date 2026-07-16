#!/bin/bash

# Dotfiles installation script
# Sets up Homebrew packages, symlinks, SSH, and git for a new machine

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing dotfiles from $DOTFILES_DIR"
echo ""

# --- Homebrew bootstrap ---
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Put brew on PATH for this session + future login shells (Apple Silicon / Intel)
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  BREW_SHELLENV_LINE='eval "$(/opt/homebrew/bin/brew shellenv)"'
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
  BREW_SHELLENV_LINE='eval "$(/usr/local/bin/brew shellenv)"'
fi

if [[ -n "${BREW_SHELLENV_LINE:-}" ]]; then
  if [[ ! -f "$HOME/.zprofile" ]] || ! grep -Fq 'brew shellenv' "$HOME/.zprofile" 2>/dev/null; then
    echo "$BREW_SHELLENV_LINE" >> "$HOME/.zprofile"
    echo "✓ Added brew to ~/.zprofile"
  fi
fi

# --- Packages (apps + CLI) via Brewfile ---
echo "Installing packages from Brewfile..."
# Trust third-party taps used by this Brewfile (Homebrew may refuse untrusted taps)
if command -v brew >/dev/null 2>&1; then
  brew tap android/tap 2>/dev/null || true
  brew tap nikitabobko/tap 2>/dev/null || true
  # Newer Homebrew may require explicit trust
  brew trust android/tap 2>/dev/null || true
  brew trust nikitabobko/tap 2>/dev/null || true
fi

brew bundle --file="$DOTFILES_DIR/Brewfile"
echo "✓ Brew packages installed"

# --- Android CLI post-setup ---
if command -v android >/dev/null 2>&1; then
  echo ""
  echo "Setting up Android CLI..."
  # Init agent skills / environment (safe to re-run)
  android init >/dev/null 2>&1 || true
  echo "✓ Android CLI ready (run 'android update' anytime)"
fi

# --- Grok CLI ---
echo ""
if command -v grok >/dev/null 2>&1; then
  echo "✓ Grok CLI already installed ($(grok --version 2>/dev/null || echo 'ok'))"
else
  echo "Installing Grok CLI..."
  curl -fsSL https://x.ai/cli/install.sh | bash
  echo "✓ Grok CLI installed"
fi

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

mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

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

# --- Git Config Setup ---
echo ""
echo "Setting up Git configuration..."

if [ -f "$HOME/.gitconfig" ] && [ ! -L "$HOME/.gitconfig" ]; then
  echo "Backing up existing .gitconfig to .gitconfig.backup"
  mv "$HOME/.gitconfig" "$HOME/.gitconfig.backup"
fi

ln -sf "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
echo "✓ Linked .gitconfig"

ln -sf "$DOTFILES_DIR/git/.gitconfig-personal" "$HOME/.gitconfig-personal"
echo "✓ Linked .gitconfig-personal"

echo ""
echo "Installation complete!"
echo ""
echo "Next steps:"
echo "1. Add your API keys to $DOTFILES_DIR/.zsh_secrets"
echo "2. Run: source ~/.zshrc"
echo "3. Generate GitHub SSH keys (if needed):"
echo "   ssh-keygen -t ed25519 -C 'spikeysanju98@gmail.com' -f ~/.ssh/github-personal"
echo "   ssh-keygen -t ed25519 -C 'sanju@theagi.company' -f ~/.ssh/github-work"
echo "4. Add public keys to each GitHub account"
echo "5. Test: ssh -T git@github.com && ssh -T git@github-work"
echo "6. Android: android info && android sdk list"
echo "7. Grok: grok --version"
echo ""
