# maxa-copilot-skills

Public Claude Code plugin marketplace for the Maxa organization.

## Available Plugins

| Plugin | Description |
|--------|-------------|
| *Coming soon* | |

## Installation

```bash
# Add the marketplace (once)
/plugin marketplace add maxa-ai/maxa-copilot-skills

# Install a plugin
/plugin install <plugin-name>@maxa-copilot-skills
```

## Usage

Once installed, invoke skills with the plugin namespace:

```
/<plugin-name>:<skill-name>
```

## Testing Locally

```bash
claude --plugin-dir ./plugins/<plugin-name>
```

## Validation

Run the CI checks locally before pushing:

```bash
.github/scripts/validate-plugins.sh
```

## Contributing

1. Create or modify a plugin under `plugins/<plugin-name>/`
2. Each plugin needs `.claude-plugin/plugin.json` (with `name` and `version`) and at least one `skills/<skill-name>/SKILL.md`
3. Register new plugins in `.claude-plugin/marketplace.json`
4. **Bump the version in `plugin.json` on every change** — updates won't propagate without it
