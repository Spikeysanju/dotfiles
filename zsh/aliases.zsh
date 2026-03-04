# --- GIT ALIASES
alias g="git"
alias gc='git add -A && git commit -m'
alias gcp='f() { gc "$1" && git push origin $(git rev-parse --abbrev-ref HEAD); }; f'
alias gl='git log --oneline --graph'
alias gs='git status'
alias gb='git branch'
alias gp='git pull'
function gcl() { git clone "git@github.com:${1%.git}.git" $2; }                          # gcl Spikeysanju/repo
function gcw() { git clone "git@github-work:${1%.git}.git" ~/agi/$(basename "${1%.git}"); } # gcw agi-inc/repo

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

# work shortcuts
alias agi='cd ~/agi'
alias products='cd ~/thisux/1-work/products'

# --- VS CODE / CURSOR
alias c.='code .'
alias cu='cursor'  # so you can do: cu . , cu .. , cu path

# --- LS
alias ls="command ls -G"
alias l="ls -lF -G"
alias la="ls -laF -G"
alias lsd="ls -lF -G | grep --color=never '^d'"

# --- SSH
alias sso='ssh oracle'

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
alias bdg="bun run generate"
alias bdm="bun run drizzle:migrate"
alias bds="bun run drizzle:studio"
alias brw="bun run wrangle"
alias nrd="npm run dev"
alias nrb="npm run build"
alias sknew="bun create svelte@latest"
alias cfnew="bun create cloudflare@latest"
alias rand32="openssl rand -hex 32"
alias rand64="openssl rand -base64 64"
alias exa="cd expo && npm run android:fresh"
alias wd="wrangler dev"
alias wp="wrangler publish"
alias wdr="bun run wrangler dev node_modules/wrangler-proxy/dist/worker.js --remote"
alias bdg="bun run drizzle:generate"
alias bdl="bun run drizzle:list"
alias bdm="bun run drizzle:migrate"

# --- OHA (HTTP load testing)
alias oha10="oha -z 10s"
alias oha1m="oha -z 1m"
alias ohaqps="oha --rate 100"

