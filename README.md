# Dotfiles

macOS zsh, git, and ssh setup. Public-safe template: secrets and real identity stay local.

## Quick setup

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
./install.sh
source ~/.zshrc
```

Then:

1. **Git identity** — edit `git/identity-work` and `git/identity-personal` (created from examples if missing). Put your real name/emails there (gitignored).
2. **API keys** — `.zsh_secrets` (gitignored)
3. **Private SSH hosts** — `ssh/config.local` (gitignored; see `config.local.example`)
4. **GitHub keys** — generate if needed, add as **Authentication** + **Signing** on each account

Using an agent? See `AGENTS.md` — agents must **ask you** for real emails and write them into the identity files.

## Layout

```
.zshrc            # loads zsh/*
zsh/              # aliases, exports, functions, plugins, prompt
git/              # multi-account git (placeholders + local identity-*)
ssh/config        # public GitHub hosts only
ssh/config.local  # private servers (gitignored)
Brewfile          # apps + CLI
install.sh        # new machine bootstrap
AGENTS.md         # instructions for coding agents
CLAUDE.md         # symlink → AGENTS.md
```

## Multi-account git (summary)

| | Personal | Work |
|---|----------|------|
| Projects | `~/me/` | e.g. `~/agi/` |
| SSH | `github.com` | `github-work` |
| Identity | `git/identity-personal` | `git/identity-work` |
| Clone | `gcl user/repo` | `gcw org/repo` |

## What never goes in git

- Real emails / private identity files
- Private SSH keys, `.zsh_secrets`
- Server IPs, GCE blocks (`ssh/config.local`)

## Checks

```bash
git config --global user.email    # work email (outside ~/me)
# inside ~/me/some-repo:
git config user.email             # personal email
ssh -T git@github.com
ssh -T git@github-work
bun --version
grok --version
```
