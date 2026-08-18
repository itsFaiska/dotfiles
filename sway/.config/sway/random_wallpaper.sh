#!/bin/bash

# Substitua pelo caminho da sua pasta de wallpapers
WALLPAPER_DIR="$HOME/Pictures/wallpapers"

# Encontra todos os arquivos de imagem na pasta e escolhe um aleatório
RANDOM_PIC=$(find "$WALLPAPER_DIR" -type f \( -iname \*.jpg -o -iname \*.png -o -iname \*.jpeg \) | shuf -n 1)

# Usa o comando interno do Sway para aplicar a imagem em todos os monitores ("*")
swaymsg output "*" bg "$RANDOM_PIC" fill
