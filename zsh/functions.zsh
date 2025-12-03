# --- LLM FUNCTIONS
gem3n() {
  if [ -f "$1" ]; then context=$(cat "$1"); shift; else context=""; fi
  llm -m gem3n "$context $*"
}

qcoder() {
  if [ -f "$1" ]; then context=$(cat "$1"); shift; else context=""; fi
  llm -m qcoder "$context $*"
}

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

