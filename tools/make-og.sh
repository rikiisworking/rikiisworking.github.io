#!/bin/sh
# Regenerates og.png (the link-preview image). macOS only — needs Swift (Xcode Command Line Tools).
# Usage: sh tools/make-og.sh
set -eu

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
FONT_DIR="$ROOT/tools/.cache"
FONT="$FONT_DIR/NotoSans.ttf"

# Noto Sans (SIL Open Font License) from Google's official fonts repo; cached, not committed
if [ ! -f "$FONT" ]; then
  mkdir -p "$FONT_DIR"
  echo "Downloading Noto Sans…"
  curl -fsSL -o "$FONT" "https://github.com/google/fonts/raw/main/ofl/notosans/NotoSans%5Bwdth%2Cwght%5D.ttf"
fi

swift "$ROOT/tools/og.swift" "$FONT" "$ROOT/og.png"
