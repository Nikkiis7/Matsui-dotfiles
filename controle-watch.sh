#!/bin/bash
# ~/.local/bin/controle-watch.sh
# Isso é opcional, se você usa um controle e quer que apareça a notificação quando ele é conectado ou desconectado, coloque isso no /.kocal/bin
udevadm monitor --udev --subsystem-match=input | while read -r line; do
    case "$line" in
        *add*/js[0-9]*)    notify-send -i input-gaming "🎮 Controle" "Conectado" ;;
        *remove*/js[0-9]*) notify-send -i input-gaming "🎮 Controle" "Desconectado" ;;
    esac
done
