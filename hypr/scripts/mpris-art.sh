#!/bin/bash

ART="/tmp/hyde-mpris.png"
TMP="/tmp/hyde-mpris.raw"

url=$(playerctl metadata mpris:artUrl 2>/dev/null)
[ -z "$url" ] && rm -f "$ART" && exit 0

if [[ "$url" =~ ^https?:// ]]; then
  curl -fsSL "$url" -o "$TMP" || exit 0
else
  url="${url#file://}"
  cp "$url" "$TMP" || exit 0
fi

# Force-convert to a NON-progressive PNG (hyprlock-safe)
magick "$TMP" -strip -interlace none PNG:"$ART"
chmod 644 "$ART"
rm -f "$TMP"
