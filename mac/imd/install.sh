#!/usr/bin/env bash
set -euo pipefail

# Build imd and (re)start it as a LaunchAgent. Used by the Obsidian "Vim IMD" plugin.

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
LABEL=local.imd
PLIST="$HOME/Library/LaunchAgents/$LABEL.plist"
DOMAIN="gui/$(id -u)"

[[ "$(uname)" == "Darwin" ]] || { echo "imd is macOS only" >&2; exit 1; }
command -v swiftc >/dev/null || { echo "swiftc not found: run xcode-select --install" >&2; exit 1; }

mkdir -p ~/.local/bin ~/Library/LaunchAgents
swiftc -O "$DIR/imd.swift" -o ~/.local/bin/imd
sed "s|__HOME__|$HOME|g" "$DIR/$LABEL.plist" > "$PLIST"

if launchctl print "$DOMAIN/$LABEL" >/dev/null 2>&1; then
    launchctl bootout "$DOMAIN/$LABEL"
    while launchctl print "$DOMAIN/$LABEL" >/dev/null 2>&1; do sleep 0.2; done
fi
launchctl bootstrap "$DOMAIN" "$PLIST"

sleep 1
[[ -p "/tmp/imd-$(id -u).fifo" ]] || { echo "imd failed to start, see /tmp/imd.log" >&2; exit 1; }
echo "imd running: $(cat "/tmp/imd-$(id -u).current")"
