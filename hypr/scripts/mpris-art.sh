#!/bin/bash

ART="/tmp/hyde-mpris.png"

url=$(playerctl metadata mpris:artUrl 2>/dev/null)

# Nothing playing
[ -z "$url" ] && rm -f "$ART" && exit 0

# Spotify gives HTTPS URLs
if [[ "$url" =~ ^https?:// ]]; then
  curl -sL "$url" -o "$ART"
  exit 0
fi

# Local file case (other players)
url="${url#file://}"
if [ -f "$url" ]; then
  cp "$url" "$ART"
else
  rm -f "$ART"
fi
