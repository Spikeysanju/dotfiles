# Cleaned and organized .zshrc

# --- POWERLEVEL10K INSTANT PROMPT (keep at very top)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- BASIC PROMPT (fallback)
PS1="%n$ "

# --- ENVIRONMENT VARIABLES
export DEFAULT_USER="sanju"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"    # Helix installer

# --- API KEYS (keep private)
export GEMINI_API_KEY=""

# --- THEME & PLUGINS
source $HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOMEBREW_PREFIX/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# --- LLM FUNCTIONS
gem3n() {
  if [ -f "$1" ]; then context=$(cat "$1"); shift; else context=""; fi
  llm -m gem3n "$context $*"
}

qcoder() {
  if [ -f "$1" ]; then context=$(cat "$1"); shift; else context=""; fi
  llm -m qcoder "$context $*"
}

# --- GIT ALIASES
alias g="git"
alias gc='git add -A && git commit -m'
alias gcp='f() { gc "$1" && git push origin $(git rev-parse --abbrev-ref HEAD); }; f'
alias gl='git log --oneline --graph'
alias gs='git status'
alias gb='git branch'
alias gp='git pull'

# --- DOCKER
alias dd='docker-compose down -v'
alias du='docker-compose up -d'
alias dps='docker ps -a'

# --- RUST
alias cbr='cargo build --release'
alias cr='cargo run'

# --- FILE NAVIGATION
alias ..='cd ..'
alias ...='cd ../..'
alias dc="cd ~/Documents"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"

# year shortcuts
alias t24='cd ~/Downloads/THISUX/2024/startups'
alias t25='cd ~/Downloads/THISUX/2025/startups'
alias c24='cd ~/Downloads/THISUX/2024/clients'
alias p24='cd ~/Downloads/THISUX/2024/personal'
alias d24='cd ~/Downloads/THISUX/2024/dun'

# VS CODE / CURSOR
alias c.='code .'
alias cu='cursor'  # so you can do: cu . , cu .. , cu path

alias c.='code .'

# --- LS
alias ls="command ls -G"
alias l="ls -lF -G"
alias la="ls -laF -G"
alias lsd="ls -lF -G | grep --color=never '^d'"

# --- NETWORK
alias myip='curl ipinfo.io/ip'
alias externalip='curl ifconfig.me'
alias pingtest='ping -c 5 google.com'
alias netinfo='netstat -i'

# --- BATTERY
alias battery="pmset -g batt"
alias battpercent="pmset -g batt | grep -o '[0-9]*%'"

# --- MISC UTILITY
alias emptytrash='sudo rm -rf ~/.Trash/*(N)'
alias shutdown="sudo shutdown -h now"
alias home="cd ~"
alias forcequit='killall -9'
alias cdf='open -a Finder .'
alias topusage='ps aux --sort=-%cpu | head'
alias ejectall='diskutil list | grep "Mounted" | awk "{print $6}" | xargs diskutil eject'
alias macupdate='sudo softwareupdate -i -a'
alias ozsh='open ~/.zshrc'
alias szsh="source ~/.zshrc"

# --- SCREENSHOTS
alias screenshot='screencapture -P ~/Desktop/screenshot_$(date "+%Y%m%d_%H%M%S").png'
alias selectshot='screencapture -is ~/Desktop/selectshot_$(date "+%Y%m%d_%H%M%S").png'
alias copyscreenshot='screencapture -c'
alias copyselectshot='screencapture -c -i'
alias delayedshot='screencapture -P -T5 ~/Desktop/delayedshot_$(date "+%Y%m%d_%H%M%S").png'

# --- DEV SHORTCUTS
alias brd="bun run dev"
alias brb="bun run build"
alias brs="bun run start"
alias brw="bun run wrangle"
alias nrd="npm run dev"
alias nrb="npm run build"
alias sknew="bun create svelte@latest"
alias cfnew="bun create cloudflare@latest"
alias rand32="openssl rand -hex 32"
alias rand64="openssl rand -base64 64"
alias wd="wrangler dev"
alias wp="wrangler publish"
alias wdr="bun run wrangler dev node_modules/wrangler-proxy/dist/worker.js --remote"
alias bdg="bun run drizzle:generate"
alias bdl="bun run drizzle:list"
alias bdm="bun run drizzle:migrate"

# ---

# --- OHA (HTTP load testing)
alias oha10="oha -z 10s"
alias oha1m="oha -z 1m"
alias ohaqps="oha --rate 100"

# Kill any app
killapp() {
  # usage: killapp handy
  local name="$1"
  if [[ -z "$name" ]]; then
    echo "give app name"
    return 1
  fi

  # find process
  local pid=$(pgrep -i "$name")

  if [[ -z "$pid" ]]; then
    echo "no app found"
    return 1
  fi

  echo "killing $name ($pid)"
  kill -9 $pid
}


# --- SSH
generate_ssh_key() {
    ssh-keygen -t rsa -b 4096 -C "$1"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
    echo "SSH key generated and added to agent:"
    cat ~/.ssh/id_rsa.pub
}

# bun completions
[ -s "/Users/sanju/.bun/_bun" ] && source "/Users/sanju/.bun/_bun"

