#!/bin/sh

set -eu

# ============================================================
# Arch Linux - Dotfiles Environment Installer
# ============================================================

DOTFILES_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# ------------------------------------------------------------
# Cores
# ------------------------------------------------------------

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

info() {
    printf "${BLUE}==>${RESET} %s\n" "$1"
}

success() {
    printf "${GREEN}✓${RESET} %s\n" "$1"
}

warning() {
    printf "${YELLOW}!${RESET} %s\n" "$1"
}

error() {
    printf "${RED}✗${RESET} %s\n" "$1"
}

# ------------------------------------------------------------
# Verificações
# ------------------------------------------------------------

if [ "$(id -u)" -eq 0 ]; then
    error "Não execute este script como root."
    exit 1
fi

if ! command -v pacman >/dev/null 2>&1; then
    error "Este script foi feito para Arch Linux."
    exit 1
fi

# ------------------------------------------------------------
# Atualização do sistema
# ------------------------------------------------------------

info "Atualizando o sistema..."

sudo pacman -Syu --needed

success "Sistema atualizado."

# ------------------------------------------------------------
# Dependências básicas
# ------------------------------------------------------------

info "Instalando dependências básicas..."

sudo pacman -S --needed \
    base-devel \
    git \
    curl \
    wget \
    unzip \
    unzip \
    xz \
    openssh

success "Dependências básicas instaladas."

# ------------------------------------------------------------
# Instalar paru
# ------------------------------------------------------------

if command -v paru >/dev/null 2>&1; then
    success "paru já está instalado."
else
    info "Instalando paru..."

    TMP_DIR="$(mktemp -d)"

    cleanup() {
        rm -rf "$TMP_DIR"
    }

    trap cleanup EXIT INT TERM

    git clone https://aur.archlinux.org/paru.git "$TMP_DIR/paru"

    cd "$TMP_DIR/paru"

    makepkg -si --noconfirm

    cd "$DOTFILES_DIR"

    success "paru instalado."
fi

# ------------------------------------------------------------
# Pacotes oficiais
# ------------------------------------------------------------

PACMAN_PACKAGES="
    foot
    mako
    neovim
    rofi-wayland
    starship
    sway
    swaybg
    waybar
    zsh
    git
    base-devel
"

info "Instalando pacotes oficiais..."

paru -S --needed --noconfirm $PACMAN_PACKAGES

success "Pacotes oficiais instalados."

# ------------------------------------------------------------
# Ferramentas adicionais úteis para o ambiente
# ------------------------------------------------------------

AUR_PACKAGES=""

# Adicione pacotes AUR aqui quando necessário.
#
# Exemplo:
#
# AUR_PACKAGES="
#     pacote-aur
#     outro-pacote
# "

if [ -n "$AUR_PACKAGES" ]; then
    info "Instalando pacotes do AUR..."

    paru -S --needed --noconfirm $AUR_PACKAGES

    success "Pacotes do AUR instalados."
fi

# ------------------------------------------------------------
# Shell padrão
# ------------------------------------------------------------

ZSH_PATH="$(command -v zsh)"

if [ "$SHELL" != "$ZSH_PATH" ]; then
    info "Configurando Zsh como shell padrão..."

    if chsh -s "$ZSH_PATH"; then
        success "Zsh configurado como shell padrão."
    else
        warning "Não foi possível alterar o shell padrão automaticamente."
        warning "Execute manualmente: chsh -s $ZSH_PATH"
    fi
else
    success "Zsh já é o shell padrão."
fi

# ------------------------------------------------------------
# Diretórios necessários
# ------------------------------------------------------------

info "Criando diretórios de configuração..."

mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/Pictures"

success "Diretórios criados."

# ------------------------------------------------------------
# Resumo
# ------------------------------------------------------------

printf '\n'
printf '%s\n' "============================================================"
printf '%s\n' " Instalação concluída"
printf '%s\n' "============================================================"
printf '\n'

printf 'Dotfiles: %s\n' "$DOTFILES_DIR"
printf '\n'

printf '%s\n' "Componentes instalados:"
printf '  ✓ foot\n'
printf '  ✓ mako\n'
printf '  ✓ neovim\n'
printf '  ✓ rofi-wayland\n'
printf '  ✓ starship\n'
printf '  ✓ sway\n'
printf '  ✓ swaybg\n'
printf '  ✓ waybar\n'
printf '  ✓ zsh\n'
printf '  ✓ git\n'
printf '  ✓ paru\n'

printf '\n'
info "Agora você pode aplicar seus dotfiles com GNU Stow."
printf '\n'

printf 'Exemplo:\n'
printf '  cd %s\n' "$DOTFILES_DIR"
printf '  stow */\n'
printf '\n'

warning "Se você acabou de mudar o shell para Zsh, faça logout/login para aplicar completamente."
