# Dotfiles

Organized zsh configuration files.

## Structure

```
dotfiles/
├── .zshrc              # Main entry point (sources all modules)
├── .zsh_secrets        # API keys (gitignored - create locally)
├── .gitignore          # Excludes .zsh_secrets
├── install.sh          # Installation script
└── zsh/
    ├── prompt.zsh      # Powerlevel10k instant prompt
    ├── exports.zsh     # Environment variables
    ├── plugins.zsh     # Theme and plugins
    ├── aliases.zsh     # All aliases
    ├── functions.zsh   # Custom functions
    └── completions.zsh # Completion sources
```

## Installation

### On a new machine:

1. Clone this repository:
   ```bash
   git clone <your-repo-url> ~/dotfiles
   cd ~/dotfiles
   ```

2. Run the installation script:
   ```bash
   ./install.sh
   ```

3. Add your API keys to `.zsh_secrets`:
   ```bash
   # Edit the file and add your keys
   nano .zsh_secrets
   ```

4. Reload your shell:
   ```bash
   source ~/.zshrc
   ```

### Manual installation:

If you prefer to set it up manually:

1. Clone the repository to your desired location (e.g., `~/dotfiles`)
2. Create a symlink:
   ```bash
   ln -s ~/dotfiles/.zshrc ~/.zshrc
   ```
3. Create `.zsh_secrets` file in the dotfiles directory and add your API keys
4. Reload: `source ~/.zshrc`

## Notes

- The `.zshrc` file automatically finds the `zsh/` directory relative to its location
- The `.zsh_secrets` file is gitignored - you'll need to create it on each machine
- All configuration is modular and organized by concern

