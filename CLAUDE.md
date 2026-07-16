# Dotfiles

Personal dotfiles repo for zsh, ssh, and dev tooling on macOS. **This is a public repo** — see Privacy rules below.

## Structure

- `.zshrc` — entry point, sources all modules from `zsh/`
- `zsh/` — modular config: aliases, exports, functions, plugins, prompt, completions
- `ssh/config` — **public** hosts only (GitHub personal + work)
- `ssh/config.local` — **private** hosts (servers, GCE); gitignored; copy from `config.local.example`
- `git/` — multi-account git; real name/email in gitignored `identity-*` files
- `install.sh` — automated setup script for new machines (runs brew bundle)
- `restore.sh` — backup/restore private files (`backup` on old machine, `restore` on new)
- `Brewfile` — Homebrew packages/apps installed on setup
- `.zsh_secrets` — API keys (gitignored)

## Privacy rules (public repo)

Never commit:

- Real emails, private SSH keys, API tokens, `.zsh_secrets`
- Server IPs, cloud project IDs, GCE blocks → `ssh/config.local` only
- Work org names / URL rewrites → `git/identity-work` only

Tracked git configs use placeholders. Real identity lives in gitignored
`git/identity-personal` and `git/identity-work` (see `.example` files).

If identity files still contain placeholders (`you@work.example` etc.),
setup is incomplete — ask the user for real name/emails and write them there.

## Key Conventions

- All keys go in `ssh/` and are gitignored (only `config` + `config.local.example` tracked)
- `install.sh` runs `brew bundle`, installs Grok CLI, writes `~/.ssh/config` (Include-based), symlinks git config
- Prefer `bun` (not `node`) for JS tooling; Android Studio is not in the Brewfile
- Android agent CLI is `android/tap/android-cli` — see https://developer.android.com/tools/agents
- Grok CLI installs via `curl -fsSL https://x.ai/cli/install.sh | bash` (not in Brewfile)
- Keep env vars (bun/Java/Android SDK) in `zsh/exports.zsh`, not ad-hoc in `.zshrc`
- Aliases live in `zsh/aliases.zsh`, functions in `zsh/functions.zsh`

## Brewfile notes

- Fresh machines should use `./install.sh` so apps/CLI tools match this Mac
- Taps needed: `android/tap`, `nikitabobko/tap`
- Intentionally excluded: `android-studio`, `rclone`, `node`

## Multi GitHub Account Setup

- SSH config uses host aliases: `github.com` (personal) and `github-work` (work)
- Default git identity is **personal** (via `~/.gitconfig-identity-personal` include)
- Work identity activates only under `~/agi/` and `~/AGI/` (via `includeIf` → `~/.gitconfig-identity-work`)
- Clone aliases: `gcl` (personal), `gcw` (work, clones into `~/agi/`)

## New machine flow

1. `git clone <repo> ~/dotfiles && cd ~/dotfiles && ./install.sh`
2. `./restore.sh restore <backup-dir>` (or fill in identity files, `.zsh_secrets`, `ssh/config.local` manually)
3. `source ~/.zshrc`

## Git Preferences

- Do not add `Co-Authored-By` lines to commits
- Keep commit messages short and lowercase
- Follow existing commit style: verb + description (e.g., "add ssh server", "update alias")
