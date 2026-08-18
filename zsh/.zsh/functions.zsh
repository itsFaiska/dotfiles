# ==========================================
# Functions
# ==========================================

# ------------------------------------------
# Create directory and enter
# ------------------------------------------

mkcd() {
    mkdir -p "$1" && cd "$1"
}


# ------------------------------------------
# Extract archives
# ------------------------------------------

extract() {
    if [[ -f "$1" ]]; then
        case "$1" in
            *.tar.bz2) tar xjf "$1" ;;
            *.tar.gz)  tar xzf "$1" ;;
            *.bz2)     bunzip2 "$1" ;;
            *.rar)     unrar x "$1" ;;
            *.gz)      gunzip "$1" ;;
            *.tar)     tar xf "$1" ;;
            *.tbz2)    tar xjf "$1" ;;
            *.tgz)     tar xzf "$1" ;;
            *.zip)     unzip "$1" ;;
            *.Z)       uncompress "$1" ;;
            *.7z)      7z x "$1" ;;
            *)
                echo "'$1' não pode ser extraído via extract()"
                return 1
                ;;
        esac
    else
        echo "'$1' não é um arquivo válido"
        return 1
    fi
}


# ------------------------------------------
# Directory size
# ------------------------------------------

dirsize() {
    du -sh "${1:-.}"
}


# ------------------------------------------
# Kill process using port
# ------------------------------------------

portkill() {
    local port="$1"

    if [[ -z "$port" ]]; then
        echo "Uso: portkill <porta>"
        return 1
    fi

    local pid
    pid=$(lsof -t -i:"$port")

    if [[ -z "$pid" ]]; then
        echo "Nenhum processo rodando na porta $port"
        return 0
    fi

    echo "Matando processo $pid na porta $port..."

    kill -9 "$pid"
}


# ------------------------------------------
# Which / where
# ------------------------------------------

where() {
    if (( $# == 0 )); then
        print "  Usage: where <command>"
        return 1
    fi

    local cmd="$1"
    local path

    # Alias
    if (( $+aliases[$cmd] )); then
        print "  ◆  $cmd"
        print "     alias → $aliases[$cmd]"
        return 0
    fi

    # Function
    if (( $+functions[$cmd] )); then
        print "  ƒ  $cmd"
        print "     function"
        return 0
    fi

    # Executable in PATH
    path=$(whence -p "$cmd" 2>/dev/null)

    if [[ -n "$path" ]]; then
        print "  ✓  $cmd"
        print "     $path"
        return 0
    fi

    # Zsh builtin
    if builtin type "$cmd" &>/dev/null; then
        print "  ◇  $cmd"
        print "     builtin"
        return 0
    fi

    print "  ✗  $cmd"
    print "     not found"

    return 1
}
