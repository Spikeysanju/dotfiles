#!/bin/bash

# Backup/restore the private (gitignored) half of these dotfiles.
#
# Old machine:  ./restore.sh backup  [dir]   # collect private files into dir
# New machine:  ./restore.sh restore [dir]   # put them back, fix perms, symlinks
#
# Default dir: ~/dotfiles-private (put it on iCloud/USB/password manager —
# never in a git repo).
#
# Private files covered:
#   .zsh_secrets            API keys
#   git/identity-personal   real personal name/email
#   git/identity-work       real work name/email + org rewrite
#   ssh/config.local        private hosts (servers, GCE)
#   ssh/* keys              every non-config file in ssh/ (private + .pub)

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODE="${1:-}"
BACKUP_DIR="${2:-$HOME/dotfiles-private}"

FILES=(
  ".zsh_secrets"
  "git/identity-personal"
  "git/identity-work"
  "ssh/config.local"
)

usage() {
  echo "Usage: $0 backup|restore [backup-dir]"
  echo "  backup   copy private files from dotfiles into backup-dir (default ~/dotfiles-private)"
  echo "  restore  copy private files from backup-dir into dotfiles + ~/.ssh"
  exit 1
}

ssh_keys() {
  # every file in a ssh dir except tracked/public config files
  local dir="$1"
  [ -d "$dir" ] || return 0
  for f in "$dir"/*; do
    [ -f "$f" ] || continue
    case "$(basename "$f")" in
      config|config.local|config.local.example) continue ;;
    esac
    echo "$f"
  done
}

case "$MODE" in
  backup)
    mkdir -p "$BACKUP_DIR/git" "$BACKUP_DIR/ssh"
    chmod 700 "$BACKUP_DIR"
    for f in "${FILES[@]}"; do
      if [ -f "$DOTFILES_DIR/$f" ]; then
        cp "$DOTFILES_DIR/$f" "$BACKUP_DIR/$f"
        echo "✓ Backed up $f"
      else
        echo "- Skipped $f (not found)"
      fi
    done
    while IFS= read -r key; do
      cp "$key" "$BACKUP_DIR/ssh/$(basename "$key")"
      echo "✓ Backed up ssh/$(basename "$key")"
    done < <(ssh_keys "$DOTFILES_DIR/ssh")
    chmod -R go-rwx "$BACKUP_DIR"
    echo ""
    echo "Private files saved to $BACKUP_DIR"
    echo "Move this folder somewhere safe (iCloud, USB, password manager)."
    echo "On the new machine: ./install.sh && ./restore.sh restore $BACKUP_DIR"
    ;;

  restore)
    [ -d "$BACKUP_DIR" ] || { echo "✗ Backup dir not found: $BACKUP_DIR"; exit 1; }
    for f in "${FILES[@]}"; do
      if [ -f "$BACKUP_DIR/$f" ]; then
        mkdir -p "$DOTFILES_DIR/$(dirname "$f")"
        cp "$BACKUP_DIR/$f" "$DOTFILES_DIR/$f"
        chmod 600 "$DOTFILES_DIR/$f"
        echo "✓ Restored $f"
      else
        echo "- Skipped $f (not in backup)"
      fi
    done
    # ssh keys → dotfiles ssh/ AND ~/.ssh with correct perms
    mkdir -p "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"
    while IFS= read -r key; do
      name="$(basename "$key")"
      cp "$key" "$DOTFILES_DIR/ssh/$name"
      cp "$key" "$HOME/.ssh/$name"
      if [[ "$name" == *.pub ]]; then
        chmod 644 "$DOTFILES_DIR/ssh/$name" "$HOME/.ssh/$name"
      else
        chmod 600 "$DOTFILES_DIR/ssh/$name" "$HOME/.ssh/$name"
      fi
      echo "✓ Restored ssh/$name (+ ~/.ssh)"
    done < <(ssh_keys "$BACKUP_DIR/ssh")
    # re-link identity files in case install.sh hasn't run yet
    ln -sf "$DOTFILES_DIR/git/identity-personal" "$HOME/.gitconfig-identity-personal" 2>/dev/null || true
    ln -sf "$DOTFILES_DIR/git/identity-work" "$HOME/.gitconfig-identity-work" 2>/dev/null || true
    echo ""
    echo "Done. Verify with:"
    echo "  git config --global user.email   # personal"
    echo "  ssh -T git@github.com && ssh -T git@github-work"
    ;;

  *)
    usage
    ;;
esac
