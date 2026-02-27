#!/usr/bin/env bash
set -euo pipefail

# Stop hook: summarise what Claude did in one sentence, then speak it via TTS.
# Uses last_assistant_message from hook input (no transcript parsing needed).
# Calls OpenRouter API (haiku) for summary, then speaks via edge-tts.

PLUGIN_DIR="$(cd "$(dirname "$0")" && pwd)"
DEBUG_LOG="/tmp/claude-tts-debug.log"

[[ "${CLAUDE_TTS_ENABLED:-1}" == "0" ]] && exit 0

INPUT=$(cat)

# Extract last assistant message directly from hook input
LAST_MSG=$(echo "$INPUT" | jq -r '.last_assistant_message // ""' | head -c 2000)

{
  echo "=== HOOK FIRED $(date '+%Y-%m-%dT%H:%M:%S%z') ==="
  echo "LAST_MSG length: ${#LAST_MSG}"
  echo "LAST_MSG preview: ${LAST_MSG:0:200}"
} >> "$DEBUG_LOG"

if [[ -z "$LAST_MSG" ]]; then
  echo "No last_assistant_message, saying Ready" >> "$DEBUG_LOG"
  "$PLUGIN_DIR/speak.sh" "Ready" &
  exit 0
fi

# Load API key from env, then fall back to common .env locations
if [[ -z "${OPENROUTER_API_KEY:-}" ]]; then
  for ENV_FILE in "${HOME}/projects/config/.env" "${HOME}/.env" ".env"; do
    if [[ -f "$ENV_FILE" ]]; then
      OPENROUTER_API_KEY=$(grep -E '^(VITE_)?OPENROUTER_API_KEY=' "$ENV_FILE" | head -1 | sed 's/^[^=]*=//' | tr -d '"' | tr -d $'\r' || true)
      [[ -n "${OPENROUTER_API_KEY:-}" ]] && break
    fi
  done
fi

if [[ -z "${OPENROUTER_API_KEY:-}" ]]; then
  echo "No OPENROUTER_API_KEY found, saying Ready" >> "$DEBUG_LOG"
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

{
  echo "API_KEY found: yes (${#OPENROUTER_API_KEY} chars)"
  echo "SUMMARY: $SUMMARY"
} >> "$DEBUG_LOG"

if [[ -n "$SUMMARY" ]]; then
  "$PLUGIN_DIR/speak.sh" "$SUMMARY" &
else
  "$PLUGIN_DIR/speak.sh" "Ready" &
fi

exit 0
