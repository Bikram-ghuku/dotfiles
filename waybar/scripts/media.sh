#!/bin/bash

# Max characters for display
MAXLEN=30
TMP_IMG="/tmp/hyde-mpris.png"

# Get metadata
metadata=$(playerctl metadata --format '{{ artist }} — {{ title }}' 2>/dev/null)
arturl=$(playerctl metadata --format '{{ mpris:artUrl }}' 2>/dev/null)


if [ -z "$metadata" ]; then
    text="No media"
else
    # Truncate if too long
    if [ ${#metadata} -gt $MAXLEN ]; then
        text="${metadata:0:$MAXLEN}…"
    else
        text="$metadata"
    fi
fi

# Get album for tooltip (optional)
album=$(playerctl metadata --format '{{ album }}' 2>/dev/null)
[ -z "$album" ] && album=""

if [ -n "$arturl" ]; then
    curl -s "$arturl" -o "$TMP_IMG"
fi

# Output JSON
echo "{\"text\":\"$text\",\"icon\":\"󰎈\",\"tooltip\":\"$album\"}"


