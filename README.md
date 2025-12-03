# My Dotfiles

Hey! These are my dotfiles - basically my shell configuration that I use to make my terminal life easier. I've organized everything into separate files so it's easier to manage and find stuff.

## What's in here?

```
dotfiles/
├── .zshrc              # Main file that loads everything else
├── .zsh_secrets        # My API keys (not in git, obviously)
├── .gitignore          # Keeps secrets out of git
├── install.sh          # Quick setup script
└── zsh/
    ├── prompt.zsh      # Powerlevel10k prompt setup
    ├── exports.zsh     # Environment variables and PATH stuff
    ├── plugins.zsh     # zsh plugins (syntax highlighting, autosuggestions, etc.)
    ├── aliases.zsh     # All my shortcuts (git, docker, dev stuff, etc.)
    ├── functions.zsh   # Custom functions I use (search tools, killapp, etc.)
    └── completions.zsh # Completion scripts
```

## Setting it up on a new machine

### Quick way (recommended):

1. Clone this repo:
   ```bash
   git clone <your-repo-url> ~/dotfiles
   cd ~/dotfiles
   ```

2. Run the install script - it'll handle everything:
   ```bash
   ./install.sh
   ```

3. Add your API keys (if you have any):
   ```bash
   nano .zsh_secrets
   # Add your keys here
   ```

4. Reload your shell:
   ```bash
   source ~/.zshrc
   ```

That's it! You're good to go.

### Manual way (if you're into that):

If you want to do it yourself:

1. Clone the repo wherever you want (I use `~/dotfiles`)
2. Create a symlink so your shell finds it:
   ```bash
   ln -s ~/dotfiles/.zshrc ~/.zshrc
   ```
3. Create `.zsh_secrets` in the dotfiles folder and add your keys
4. Reload: `source ~/.zshrc`

## Cool features

- **Search utilities**: `ff` to find files, `fgrep` to search code, `codegrep` to search across projects
- **Git shortcuts**: `gc`, `gcp`, `gl`, `gs`, etc. - makes git way faster
- **Dev shortcuts**: `brd` for bun run dev, `sknew` for new Svelte projects, etc.
- **Kill apps**: `killapp <name>` to kill any running app
- **And a bunch more** - check out the files to see everything!

## Notes

- The `.zshrc` automatically finds the `zsh/` folder, so you can put this repo anywhere
- `.zsh_secrets` is gitignored - you'll need to create it on each machine
- Everything is split up by what it does, so it's easy to find and edit stuff

Enjoy! 🚀
