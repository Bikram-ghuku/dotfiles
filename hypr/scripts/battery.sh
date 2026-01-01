#!/bin/bash

# Get the current battery percentage
battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)

# Get the battery status (Charging or Discharging)
battery_status=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null)

# Font Awesome (Nerd Font) battery icons mapped to 10% segments
# FA only has 5 battery levels, so values are intentionally repeated
battery_icons=(
  ""  # 0–9%   empty
  ""  # 10–19%
  ""  # 20–29% quarter
  ""  # 30–39%
  ""  # 40–49% half
  ""  # 50–59%
  ""  # 60–69% three-quarters
  ""  # 70–79%
  ""  # 80–89% full
  ""  # 90–100%
)

# Charging icon (Font Awesome)
charging_icon=""

# Calculate the index for the icon array
icon_index=$((battery_percentage / 10))
[ "$icon_index" -gt 9 ] && icon_index=9

# Get the corresponding icon
battery_icon=${battery_icons[icon_index]}

# Check if the battery is charging
if [ "$battery_status" = "Charging" ]; then
	battery_icon="$charging_icon"
fi

# Output the battery percentage and icon
echo "$battery_percentage% $battery_icon"
