# dev-workflow

Development workflow commands and skills for Claude Code. Provides orchestrated implementation, conventional commits, safe implementation with loop detection, comprehensive UI testing, and AI image generation.

## Commands

| Command | Description |
|---------|-------------|
| `/commit` | Automatic conventional git commit — analyzes changes and commits with proper type/scope/description |
| `/orchestrate` | Orchestrated multi-stage implementation with subagents, progress updates, and loop detection |
| `/safe-implementation` | Safe implementation workflow with Task Master integration, circuit breakers, and recovery strategies |
| `/test-ui` | Comprehensive UI testing with Playwright MCP using parallel subagents for 99% confidence coverage |

## Skills

| Skill | Description |
|-------|-------------|
| `nano-banana` | AI image generation via Gemini CLI's nanobanana extension — generates blog images, thumbnails, icons, diagrams, patterns, and more |

## Installation

```bash
/plugin install dev-workflow@sean-plugins
```

## Requirements

- **nano-banana skill**: Requires [Gemini CLI](https://github.com/google-gemini/gemini-cli) and a `GEMINI_API_KEY`
- **test-ui command**: Requires Playwright MCP server configured
- **orchestrate/safe-implementation**: Work with any project, optionally integrates with Task Master MCP
