#!/usr/bin/env bash
set -euo pipefail

# TTS wrapper using edge-tts (async, non-blocking)
# Usage: speak.sh "Text to speak" [voice] [rate]

TEXT="${1:-Ready}"
VOICE="${2:-${CLAUDE_TTS_VOICE:-en-AU-NatashaNeural}}"
RATE="${3:-${CLAUDE_TTS_RATE:-+10%}}"

# Skip if TTS disabled
[[ "${CLAUDE_TTS_ENABLED:-1}" == "0" ]] && exit 0

# Debounce "Ready" messages (3 second cooldown)
LOCKFILE="/tmp/claude-tts-ready.lock"
if [[ "$TEXT" == "Ready" ]]; then
  if [[ -f "$LOCKFILE" ]]; then
    LAST=$(cat "$LOCKFILE" 2>/dev/null || echo 0)
    NOW=$(date +%s)
    if (( NOW - LAST < 3 )); then
      exit 0  # Too soon, skip
    fi
  fi
  date +%s > "$LOCKFILE"
fi

# Generate unique temp file
TMPFILE="/tmp/claude-tts-$$.mp3"

# Run in background to avoid blocking Claude
{
  edge-tts --text "$TEXT" --voice "$VOICE" --rate "$RATE" \
    --write-media "$TMPFILE" 2>/dev/null

  if [[ -f "$TMPFILE" ]]; then
    if command -v afplay >/dev/null 2>&1; then
      afplay "$TMPFILE"
    elif command -v mpv >/dev/null 2>&1; then
      mpv --no-video --volume=70 "$TMPFILE" 2>/dev/null
    elif command -v ffplay >/dev/null 2>&1; then
      ffplay -nodisp -autoexit -loglevel error "$TMPFILE" 2>/dev/null
    elif command -v mpg123 >/dev/null 2>&1; then
      mpg123 -q "$TMPFILE"
    fi
    rm -f "$TMPFILE"
  fi
} &

exit 0
