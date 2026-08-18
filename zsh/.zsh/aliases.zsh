# ==========================================
# General
# ==========================================

alias q="exit"
alias c="clear"
alias b="btop"


# ==========================================
# Eza
# ==========================================

alias ls='eza --icons --group-directories-first'
alias ll='eza -al --icons --group-directories-first'
alias la='eza -a --icons'
alias lt='eza --tree --level=2 --icons'
alias tree='eza --tree --icons'


# ==========================================
# Bat
# ==========================================

alias cat='bat --theme="base16" --plain'


# ==========================================
# Git
# ==========================================

alias g="git"
alias lg="lazygit"


# ==========================================
# Docker
# ==========================================

alias ld="lazydocker"
alias dco="docker compose"


# ==========================================
# Tmux
# ==========================================

alias t="tmux new -A -s main"
alias tls="tmux ls"
alias tka="tmux kill-session -a"


# ==========================================
# Pacman / Paru
# ==========================================

alias pac="paru -S"
alias pacu="paru -Syu"
alias pacr="paru -Rns"
alias pacs="paru -Ss"
alias pacq="paru -Q"
alias pacorph="paru -Qdtq | sudo pacman -Rns -"


# ==========================================
# Zoxide
# ==========================================

alias cd='z'
