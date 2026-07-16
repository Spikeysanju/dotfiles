# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Maestro
export PATH="$PATH:$HOME/.maestro/bin"

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

# Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# grok
export PATH="$HOME/.grok/bin:$PATH"
fpath=(~/.grok/completions/zsh $fpath)
autoload -Uz compinit && compinit -C
