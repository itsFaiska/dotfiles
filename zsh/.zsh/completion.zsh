# ==========================================
# Completion
# ==========================================

autoload -Uz compinit
compinit -d "$HOME/.zcache"

# Menu interativo
zstyle ':completion:*' menu select

# Case insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Cores
zstyle ':completion:*' list-colors ''
