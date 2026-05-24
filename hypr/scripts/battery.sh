#!/bin/bash

battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)
battery_status=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null)

# Better Nerd Font battery glyphs
battery_icons=(
  "󰂎"  # 0-9
  "󰁺"  # 10-19
  "󰁻"  # 20-29
  "󰁼"  # 30-39
  "󰁽"  # 40-49
  "󰁾"  # 50-59
  "󰁿"  # 60-69
  "󰂀"  # 70-79
  "󰂁"  # 80-89
  "󰂂"  # 90-100
)

charging_icon="󰂄"

icon_index=$((battery_percentage / 10))
[ "$icon_index" -gt 9 ] && icon_index=9

battery_icon=${battery_icons[icon_index]}

if [ "$battery_status" = "Charging" ]; then
    battery_icon="$charging_icon"
fi

echo "$battery_icon  $battery_percentage%"