#!/bin/bash
# ~/.local/bin/controle-watch.sh
udevadm monitor --udev --subsystem-match=input | while read -r line; do
    case "$line" in
        *add*/js[0-9]*)    notify-send -i input-gaming "🎮 Controle" "Conectado" ;;
        *remove*/js[0-9]*) notify-send -i input-gaming "🎮 Controle" "Desconectado" ;;
    esac
done
