# Dotfiles

Personal dotfiles repo for zsh, ssh, and dev tooling on macOS.

## Structure

- `.zshrc` — entry point, sources all modules from `zsh/`
- `zsh/` — modular config: aliases, exports, functions, plugins, prompt, completions
- `ssh/` — SSH config and keys (private keys gitignored)
- `git/` — Git config with multi-account identity switching
- `install.sh` — automated setup script for new machines
- `.zsh_secrets` — API keys (gitignored)

## Key Conventions

- All private keys go in `ssh/` and must be added to `.gitignore`
- Public keys and `ssh/config` are tracked
- `install.sh` symlinks config files and copies keys with correct permissions
- Aliases live in `zsh/aliases.zsh`, functions in `zsh/functions.zsh`

## Multi GitHub Account Setup

- SSH config uses host aliases: `github.com` (personal) and `github-work` (work)
- `~/.gitconfig` has `includeIf` for `~/me/` directory to auto-switch to personal identity
- Default git identity is work (`sanju@theagi.company`), personal (`sanju@thisux.com`) activates in `~/me/`
- Clone aliases: `gcl` (personal), `gcw` (work)

## Git Preferences

- Do not add `Co-Authored-By` lines to commits
- Keep commit messages short and lowercase
- Follow existing commit style: verb + description (e.g., "add ssh server", "update alias")
