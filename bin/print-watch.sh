#!/bin/bash
# Isso aqui é para o dunst notificar quando você tirar print
dir="$HOME/Imagens"
mkdir -p "$dir"

inotifywait -m -e close_write -e moved_to --format '%w%f' "$dir" | while read -r file; do
    case "${file,,}" in
        *.png|*.jpg|*.jpeg|*.webp)
            notify-send -i "$file" "Print salvo" "$(basename "$file")"
            ;;
    esac
done
