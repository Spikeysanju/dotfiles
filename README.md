# Dotfiles

macOS zsh, git, and ssh setup. Public-safe: secrets, real identity, and private hosts stay in gitignored local files.

## New machine setup

```bash
git clone https://github.com/Spikeysanju/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh                          # brew bundle + symlinks + templates
./restore.sh restore ~/dotfiles-private   # bring back private files (optional)
source ~/.zshrc
```

`install.sh` installs Homebrew + `Brewfile` packages (bun, Android CLI, apps), Grok CLI, writes `~/.ssh/config`, and links git config. If you don't have a private backup, fill these in manually (all gitignored):

1. `git/identity-personal` + `git/identity-work` — real name/emails (created from `.example` templates)
2. `.zsh_secrets` — API keys
3. `ssh/config.local` — private servers, GCE blocks

## Backing up private files

On your current machine:

```bash
./restore.sh backup            # collects into ~/dotfiles-private
```

Store that folder somewhere safe (iCloud Drive, USB, password manager) — never in a git repo. On a new machine, `./restore.sh restore ~/dotfiles-private` puts everything back with correct permissions.

## Layout

```
dotfiles/
├── .zshrc              # entry point, sources zsh/*
├── .zsh_secrets        # API keys (gitignored)
├── Brewfile            # Homebrew packages + apps
├── install.sh          # new machine bootstrap
├── restore.sh          # backup/restore private files
├── git/
│   ├── .gitconfig               # public template (no real emails)
│   ├── identity-*.example      # templates
│   ├── identity-personal       # real personal identity (gitignored)
│   └── identity-work           # real work identity + org rewrite (gitignored)
├── ssh/
│   ├── config               # public GitHub hosts only (tracked)
│   ├── config.local         # private servers (gitignored)
│   ├── config.local.example # template
│   └── <keys>               # all keys gitignored
└── zsh/                # aliases, exports, functions, plugins, prompt, completions
```

## Multi GitHub account

| | Personal | Work |
|---|----------|------|
| Folder | default (everywhere) | `~/agi/`, `~/AGI/` |
| SSH host | `github.com` | `github-work` |
| Identity file | `git/identity-personal` | `git/identity-work` |
| Clone helper | `gcl user/repo` | `gcw org/repo` |

Identity auto-switches by directory via `includeIf` in `git/.gitconfig`. The work identity file also holds the work-org URL rewrite so plain `github.com` clone URLs use the work SSH key inside work folders.

Generate keys if needed:

```bash
ssh-keygen -t ed25519 -C "you@personal.example" -f ~/.ssh/github-personal
ssh-keygen -t ed25519 -C "you@work.example" -f ~/.ssh/github-work
```

Add each public key to the matching GitHub account.

## SSH config model

`install.sh` writes `~/.ssh/config` as a small generated file:

```
Include ~/dotfiles/ssh/config        # public (tracked)
Include ~/dotfiles/ssh/config.local  # private (gitignored)
```

Add private servers / GCE blocks to `ssh/config.local` only.

## What never goes in git

- Real emails, names you want private, work org names
- Private SSH keys, API tokens, `.zsh_secrets`
- Server IPs, cloud project IDs, GCE blocks

## Verify

```bash
git config --global user.email    # personal
git -C ~/agi/some-repo config user.email   # work
ssh -T git@github.com
ssh -T git@github-work
bun --version && grok --version
```

## Notes

- `.zshrc` finds the `zsh/` folder relative to itself, so the repo can live anywhere
- `zsh/exports.zsh` owns bun, Java, and Android SDK env vars
- Cool stuff: `ff`/`fgrep`/`codegrep` search helpers, `killapp <name>`, git shortcuts (`gc`, `gcp`, `gl`, `gs`)
