#!/usr/bin/env bash
set -euo pipefail

# Stop hook: summarise what Claude did in one sentence, then speak it via TTS.
# Reads hook JSON from stdin, parses transcript, calls OpenRouter API (haiku) for summary.

PLUGIN_DIR="$(cd "$(dirname "$0")" && pwd)"

[[ "${CLAUDE_TTS_ENABLED:-1}" == "0" ]] && exit 0

INPUT=$(cat)
TRANSCRIPT=$(echo "$INPUT" | jq -r '.transcript_path // ""')
CWD=$(echo "$INPUT" | jq -r '.cwd // ""')
TMP_DIR="${CWD:+$CWD/tmp}"
TMP_DIR="${TMP_DIR:-/tmp}"
DEBUG_LOG="$TMP_DIR/claude-tts-debug.log"

if [[ -z "$TRANSCRIPT" || ! -f "$TRANSCRIPT" ]]; then
  "$PLUGIN_DIR/speak.sh" "Ready" &
  exit 0
fi

# Extract the last assistant message text from the JSONL transcript.
# tac reverses line order; we process line-by-line so jq parses valid JSON per line.
LAST_MSG=$(tac "$TRANSCRIPT" | while IFS= read -r line; do
  text=$(echo "$line" | jq -r 'select(.type == "assistant") | .message.content[]? | select(.type == "text") | .text' 2>/dev/null)
  if [[ -n "$text" ]]; then
    echo "$text"
    break
  fi
done | head -c 2000)

# Debug logging when enabled
if [[ "${CLAUDE_HOOK_DEBUG:-0}" == "1" ]]; then
  mkdir -p "$TMP_DIR"
  {
    echo "--- $(date -Iseconds) ---"
    echo "TRANSCRIPT: $TRANSCRIPT"
    echo "LAST_MSG length: ${#LAST_MSG}"
    echo "LAST_MSG preview: ${LAST_MSG:0:200}"
  } >> "$DEBUG_LOG"
fi

if [[ -z "$LAST_MSG" ]]; then
  "$PLUGIN_DIR/speak.sh" "Ready" &
  exit 0
fi

# Load API key from env, then fall back to common .env locations
if [[ -z "${OPENROUTER_API_KEY:-}" ]]; then
  for ENV_FILE in "${HOME}/projects/config/.env" "${HOME}/.env" ".env"; do
    if [[ -f "$ENV_FILE" ]]; then
      OPENROUTER_API_KEY=$(grep -oP '^(VITE_)?OPENROUTER_API_KEY=\K.*' "$ENV_FILE" | tr -d '"' | tr -d $'\r' | head -1 || true)
      [[ -n "${OPENROUTER_API_KEY:-}" ]] && break
    fi
  done
fi

if [[ -z "${OPENROUTER_API_KEY:-}" ]]; then
  "$PLUGIN_DIR/speak.sh" "Ready" &
  exit 0
fi

# Build the API request - ask haiku for a one-sentence spoken summary
PAYLOAD=$(jq -n --arg msg "$LAST_MSG" '{
  model: "anthropic/claude-3.5-haiku",
  max_tokens: 120,
  messages: [{
    role: "user",
    content: ("Summarise what was done and the outcome in ONE short sentence for a text-to-speech readout. Be concise and natural. Speak as if you did the work (use \"I\"). Include the result or outcome. Do not use markdown, code blocks, or special characters. Here is the assistant message:\n\n" + $msg)
  }]
}')

API_RESPONSE=$(curl -s --max-time 8 \
  -H "Authorization: Bearer ${OPENROUTER_API_KEY}" \
  -H "content-type: application/json" \
  -d "$PAYLOAD" \
  https://openrouter.ai/api/v1/chat/completions 2>/dev/null)

SUMMARY=$(echo "$API_RESPONSE" | jq -r '.choices[0].message.content // ""' 2>/dev/null)

if [[ "${CLAUDE_HOOK_DEBUG:-0}" == "1" ]]; then
  {
    echo "API_KEY length: ${#OPENROUTER_API_KEY}"
    echo "API_RESPONSE: $API_RESPONSE"
    echo "SUMMARY: $SUMMARY"
  } >> "$DEBUG_LOG"
fi

if [[ -n "$SUMMARY" ]]; then
  "$PLUGIN_DIR/speak.sh" "$SUMMARY" &
else
  "$PLUGIN_DIR/speak.sh" "Ready" &
fi

exit 0
