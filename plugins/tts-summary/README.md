# tts-summary

A Claude Code plugin that speaks a one-sentence summary of what Claude did after each task using text-to-speech.

## How it works

After Claude finishes a task, this hook:
1. Reads the conversation transcript
2. Sends the last assistant message to OpenRouter (Claude 3.5 Haiku) for a one-sentence summary
3. Speaks the summary aloud using `edge-tts`

## Prerequisites

- **[edge-tts](https://github.com/rany2/edge-tts)**: `pip install edge-tts`
- **Audio player** (one of): `mpv`, `ffplay`, or `mpg123`
- **[jq](https://jqlang.github.io/jq/)**: JSON processor
- **OpenRouter API key**: Set `OPENROUTER_API_KEY` in your environment or a `.env` file

## Installation

```
/plugin marketplace add seansoreilly/claude-plugins
/plugin install tts-summary@sean-plugins
```

## Configuration

Set these environment variables (in `~/.claude/settings.json` under `env`, or in your shell):

| Variable | Default | Description |
|----------|---------|-------------|
| `CLAUDE_TTS_ENABLED` | `1` | Set to `0` to disable TTS |
| `CLAUDE_TTS_VOICE` | `en-AU-NatashaNeural` | Any [edge-tts voice](https://gist.github.com/ppakyow/89bce14e5a564ee35af7b7e948e8e4f4) |
| `CLAUDE_TTS_RATE` | `+10%` | Speech rate adjustment |
| `OPENROUTER_API_KEY` | — | Your OpenRouter API key |
| `CLAUDE_HOOK_DEBUG` | `0` | Set to `1` for debug logging |

### Popular voices

| Voice | Locale | Gender |
|-------|--------|--------|
| `en-AU-NatashaNeural` | Australian | Female |
| `en-AU-WilliamNeural` | Australian | Male |
| `en-US-JennyNeural` | American | Female |
| `en-US-GuyNeural` | American | Male |
| `en-GB-SoniaNeural` | British | Female |
| `en-GB-RyanNeural` | British | Male |
