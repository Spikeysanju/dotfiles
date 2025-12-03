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

# --- SEARCH & FIND UTILITIES

# Find files by name pattern
# Usage: ff <pattern> [directory]
# Example: ff "*.ts" or ff "config" ~/projects
ff() {
  local pattern="$1"
  local search_dir="${2:-.}"
  
  if [[ -z "$pattern" ]]; then
    echo "Usage: ff <pattern> [directory]"
    return 1
  fi
  
  # Use fd if available (faster and better)
  if command -v fd >/dev/null 2>&1; then
    fd -i "$pattern" "$search_dir"
  else
    # Fallback to find
    find "$search_dir" -iname "*${pattern}*" -type f 2>/dev/null
  fi
}

# Enhanced grep with file context
# Usage: fgrep <pattern> [directory]
# Example: fgrep "function" or fgrep "export" ~/projects
fgrep() {
  local pattern="$1"
  local search_dir="${2:-.}"
  
  if [[ -z "$pattern" ]]; then
    echo "Usage: fgrep <pattern> [directory]"
    return 1
  fi
  
  # Use ripgrep if available (faster and better)
  if command -v rg >/dev/null 2>&1; then
    rg --color=always --line-number --ignore-case \
      --glob '!node_modules' \
      --glob '!.git' \
      --glob '!.next' \
      --glob '!.svelte-kit' \
      --glob '!dist' \
      --glob '!build' \
      "$pattern" "$search_dir"
  else
    # Fallback to grep
    grep -rn --color=always \
      --exclude-dir=node_modules \
      --exclude-dir=.git \
      --exclude-dir=.next \
      --exclude-dir=.svelte-kit \
      --exclude-dir=dist \
      --exclude-dir=build \
      -i "$pattern" "$search_dir" 2>/dev/null
  fi
}

# Search code across projects
# Usage: codegrep <pattern> [directories...]
# Example: codegrep "useState" ~/projects/proj1 ~/projects/proj2
codegrep() {
  local pattern="$1"
  shift
  local search_dirs=("${@:-.}")
  
  if [[ -z "$pattern" ]]; then
    echo "Usage: codegrep <pattern> [directories...]"
    echo "Example: codegrep 'export const' ~/projects/proj1 ~/projects/proj2"
    return 1
  fi
  
  # Use ripgrep if available
  if command -v rg >/dev/null 2>&1; then
    for dir in "${search_dirs[@]}"; do
      if [[ -d "$dir" ]]; then
        echo "🔍 Searching in: $dir"
        rg --color=always --line-number --context 2 \
          --glob '!node_modules' \
          --glob '!.git' \
          --glob '!.next' \
          --glob '!.svelte-kit' \
          --glob '!dist' \
          --glob '!build' \
          --glob '!*.log' \
          "$pattern" "$dir"
        echo ""
      else
        echo "⚠️  Directory not found: $dir"
      fi
    done
  else
    # Fallback to grep
    for dir in "${search_dirs[@]}"; do
      if [[ -d "$dir" ]]; then
        echo "🔍 Searching in: $dir"
        grep -rn --color=always --context=2 \
          --exclude-dir=node_modules \
          --exclude-dir=.git \
          --exclude-dir=.next \
          --exclude-dir=.svelte-kit \
          --exclude-dir=dist \
          --exclude-dir=build \
          --exclude="*.log" \
          "$pattern" "$dir" 2>/dev/null
        echo ""
      else
        echo "⚠️  Directory not found: $dir"
      fi
    done
  fi
}

