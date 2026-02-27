# Nano Banana

A Claude Code skill for generating and editing images using the Gemini CLI's nanobanana extension.

## Features

- **Text-to-image generation** - Create images from natural language prompts
- **Image editing** - Modify existing images with instructions
- **Photo restoration** - Repair damaged or old photos
- **Icon generation** - Create app icons and favicons
- **Diagram creation** - Generate flowcharts and architecture diagrams
- **Pattern generation** - Create seamless textures and patterns
- **Story/sequential images** - Generate narrative image sequences

## Prerequisites

1. **Gemini CLI** - Install from [gemini-cli](https://github.com/google-gemini/gemini-cli)
2. **Gemini API Key** - Get one from [Google AI Studio](https://aistudio.google.com/)
3. **nanobanana extension** - Installed via Gemini CLI

## Setup

```bash
# Install Gemini CLI
npm install -g @google/gemini-cli

# Set API key
export GEMINI_API_KEY="your-api-key"

# Install nanobanana extension
gemini extensions install https://github.com/gemini-cli-extensions/nanobanana
```

## Usage

Once installed, Claude Code will automatically use this skill when you ask for image generation. Examples:

- "Generate a blog header image for a post about machine learning"
- "Create a YouTube thumbnail for a coding tutorial"
- "Make an app icon for a productivity tool"
- "Draw a flowchart showing user authentication"
- "Edit this image to remove the background"

## License

MIT
