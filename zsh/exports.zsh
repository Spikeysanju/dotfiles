# --- ENVIRONMENT VARIABLES

# User info
export DEFAULT_USER="sanju"

# Editor preferences
export EDITOR="hx"  # or "nvim", "vim", "code", etc.
export VISUAL="$EDITOR"

# Language/Development
# bun comes from Homebrew (Brewfile). Keep ~/.bun on PATH for global bun packages only.
export BUN_INSTALL="$HOME/.bun"
export PATH="$PATH:$BUN_INSTALL/bin"
export PATH="$HOME/.local/bin:$PATH"    # Helix installer

# Java (JDK 21 for Android/Gradle — zulu@21 via Brewfile)
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-21.jdk/Contents/Home"

# Android SDK + platform tools (adb/emulator from brew android-platform-tools or full SDK)
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$PATH"

# History
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE="$HOME/.zsh_history"
