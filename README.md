# maxa-copilot-skills

Public Claude Code plugin marketplace for the Maxa organization.

## Available Plugins

| Plugin | Skills | Description |
|--------|--------|-------------|
| `maxa-specs` | `build-model`, `check-model`, `analyze` | Activate a Maxa AI Specification for data modeling, transform implementation, and business analysis |
| `maxa-preflight` | `date-filter-spec`, `install`, `guide` | Automate Autopilot Preflight workflows — date-filter spec generation, binary installation, and guided usage for data engineers extracting source system data into DuckDB |

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
/maxa-specs:build-model         # Build data models and transforms from the AI specification
/maxa-specs:check-model         # Audit an existing model against AI specification requirements
/maxa-specs:analyze             # Produce business deliverables (risk register, gap analysis, etc.)

/maxa-preflight:date-filter-spec  # Generate a per-table date-filtering decision spec
/maxa-preflight:install           # Install the autopilot-preflight binary
/maxa-preflight:guide             # Learn what commands are available and how to use them
```

## Testing Locally

```bash
claude --plugin-dir ./plugins/<plugin-name>
```

## Evaluations

Each skill includes `evals/evals.json` with test cases and assertions, compatible with Anthropic's [skill-creator](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/skill-creator) plugin. Test fixtures (AI specifications, schemas) are in `tests/fixtures/`.

To run evaluations:

```bash
# Install skill-creator (once)
/plugin install skill-creator@claude-plugins-official

# Evaluate a specific skill
/skill-creator:skill-creator evaluate my build-model skill
```

The eval runner spawns with-skill and without-skill agents for each test case, grades assertions, and produces an HTML viewer for side-by-side comparison. Eval workspaces (`*-workspace/`) are gitignored.

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
