# Dotfiles (agent instructions)

Personal macOS dotfiles: zsh, ssh, git, Brewfile. This file is for coding agents (Claude, Grok, Codex, etc.). `CLAUDE.md` is a symlink to this file.

## Structure

- `.zshrc` — entry point, sources modules from `zsh/`
- `zsh/` — aliases, exports, functions, plugins, prompt, completions
- `ssh/config` — **public** SSH hosts only (GitHub personal + work)
- `ssh/config.local` — **private** hosts (servers, GCE); gitignored; copy from `config.local.example`
- `git/` — multi-account git; real name/email live in gitignored identity files
- `install.sh` — new machine setup (brew bundle, Grok CLI, symlinks, keys)
- `Brewfile` — Homebrew packages/apps
- `.zsh_secrets` — API keys (gitignored)

## Privacy (public repo)

Do **not** commit:

- Real work or personal emails, full legal name if the user wants it private
- Private SSH keys, API tokens, `.zsh_secrets`
- Server IPs, cloud project IDs, GCE blocks (`ssh/config.local` only)
- Work org-specific rewrites with real org names (put those in identity files)

Tracked git configs use **placeholders**. Real identity is in:

- `git/identity-work` (gitignored)
- `git/identity-personal` (gitignored)

Examples: `git/identity-work.example`, `git/identity-personal.example`.

## New machine / setup — required agent behavior

When setting up this repo on a new machine (or first-time identity):

1. **Ask the user** for:
   - Display name (git `user.name`)
   - **Work email**
   - **Personal email**
   - Optional: work GitHub org for URL rewrite (e.g. for `git@github-work:ORG/`)
2. **Write** those values into `git/identity-work` and `git/identity-personal` (create from the `.example` files if missing). Never put real emails into tracked files that would be committed to the public repo.
3. **Ask** whether they have private keys / `ssh/config.local` / `.zsh_secrets` to restore, or need to generate new GitHub keys.
4. Run or guide `./install.sh` as appropriate.
5. Remind them to add each public key on GitHub as **Authentication** and **Signing** if they want Verified commits.
6. Do not commit `identity-*`, `ssh/config.local`, private keys, or `.zsh_secrets`.

If identity files still contain placeholders (`you@work.example`, `you@personal.example`), treat setup as incomplete and **ask the user to supply real emails** before finishing.

## Key conventions

- Private keys live in `ssh/` and must stay in `.gitignore`
- Public keys and `ssh/config` are tracked; private hosts go in `ssh/config.local`
- `install.sh` runs `brew bundle`, installs Grok CLI, symlinks config, copies SSH keys if present
- Prefer `bun` (not `node`); Android Studio is not in the Brewfile
- Android agent CLI: `android/tap/android-cli` — https://developer.android.com/tools/agents
- Grok CLI: `curl -fsSL https://x.ai/cli/install.sh | bash` (not Brewfile)
- Env vars (bun/Java/Android SDK) in `zsh/exports.zsh`, not ad-hoc in `.zshrc`
- Aliases in `zsh/aliases.zsh`, functions in `zsh/functions.zsh`

## Brewfile

- Fresh machines: `./install.sh`
- Taps: `android/tap`, `nikitabobko/tap`
- Excluded on purpose: `android-studio`, `rclone`, `node`

## Multi GitHub accounts

| | Personal | Work |
|---|----------|------|
| Folder | `~/me/` | default (e.g. `~/agi/`) |
| SSH host | `github.com` | `github-work` |
| Identity file | `git/identity-personal` | `git/identity-work` |
| Clone helper | `gcl user/repo` | `gcw org/repo` |

SSH signing for Verified commits is enabled in `git/.gitconfig` (keys under `~/.ssh/`).

## Git preferences

- Do not add `Co-Authored-By` lines to commits
- Keep commit messages short and lowercase
- Style: verb + description (e.g. `add ssh server`, `update alias`)
