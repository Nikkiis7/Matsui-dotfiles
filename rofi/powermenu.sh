#!/usr/bin/env bash

THEME="$HOME/.config/rofi/powermenu.rasi"

lock="󰌾"
logout="󰍃"
suspend="󰤄"
reboot="󰜉"
shutdown="󰐥"

uptime_msg="Ligado há $(uptime -p | sed 's/up //')"

confirm() {
    local answer
    answer=$(printf "Sim\nNão" | rofi -dmenu -no-show-icons \
        -theme "$THEME" \
        -theme-str 'listview { columns: 2; } element-text { font: "Iosevka Nerd Font 20"; } element { padding: 20px 0px; }' \
        -mesg "$1" \
        -selected-row 1)
    [[ "$answer" == "Sim" ]]
}

chosen=$(printf "%s\n%s\n%s\n%s\n%s" \
    "$lock" "$logout" "$suspend" "$reboot" "$shutdown" | \
    rofi -dmenu -no-show-icons -theme "$THEME" -mesg "$uptime_msg" -p "")

case "$chosen" in
    "$lock")
        hyprlock
        ;;
    "$logout")
        confirm "Encerrar a sessão?" && hyprctl dispatch 'hl.dsp.exit()'
        ;;
    "$suspend")
        systemctl suspend
        ;;
    "$reboot")
        confirm "Reiniciar o computador?" && systemctl reboot
        ;;
    "$shutdown")
        confirm "Desligar o computador?" && systemctl poweroff
        ;;
esac
