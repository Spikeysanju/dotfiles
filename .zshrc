# Cleaned and organized .zshrc
# This file sources modular configuration files from the zsh/ directory

# Get the directory where this .zshrc file is located
ZSH_CONFIG_DIR="${${(%):-%x}:A:h}"

# --- PROMPT (must be first for instant prompt)
source "$ZSH_CONFIG_DIR/zsh/prompt.zsh"

# --- EXPORTS (needed early)
source "$ZSH_CONFIG_DIR/zsh/exports.zsh"

# --- SECRETS (API keys and sensitive information)
if [[ -f "$ZSH_CONFIG_DIR/.zsh_secrets" ]]; then
  source "$ZSH_CONFIG_DIR/.zsh_secrets"
fi

# --- PLUGINS (depend on exports)
source "$ZSH_CONFIG_DIR/zsh/plugins.zsh"

# --- ALIASES
source "$ZSH_CONFIG_DIR/zsh/aliases.zsh"

# --- FUNCTIONS
source "$ZSH_CONFIG_DIR/zsh/functions.zsh"

# --- COMPLETIONS
source "$ZSH_CONFIG_DIR/zsh/completions.zsh"

# bun completions
[ -s "/Users/sanju/.bun/_bun" ] && source "/Users/sanju/.bun/_bun"
