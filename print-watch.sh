#!/bin/bash
# Ajuste para a pasta onde o seu programa salva os prints
dir="$HOME/Imagens"
mkdir -p "$dir"

inotifywait -m -e close_write -e moved_to --format '%w%f' "$dir" | while read -r file; do
    case "${file,,}" in
        *.png|*.jpg|*.jpeg|*.webp)
            notify-send -i "$file" "Print salvo" "$(basename "$file")"
            ;;
    esac
done
