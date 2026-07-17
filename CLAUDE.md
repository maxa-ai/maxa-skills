# CLAUDE.md

## Project Overview

Public Claude Code plugin marketplace for the Maxa organization. Each plugin lives under `plugins/<plugin-name>/` with its own `.claude-plugin/plugin.json` and skills. The marketplace manifest at `.claude-plugin/marketplace.json` registers all available plugins.

### Plugin naming convention

`maxa-` prefix + domain noun, one plugin per product line. Plugin names are stable identifiers — they appear in `/plugin install`, `enabledPlugins`, and `pluginConfigs`.

Current family: `maxa-specs`, `maxa-pipelines`, `maxa-preflight`, `maxa-analyst`.

### Repository structure

```
.claude-plugin/
└── marketplace.json         # Marketplace manifest (registers all plugins)
plugins/
└── <plugin-name>/
    ├── .claude-plugin/
    │   └── plugin.json      # Plugin manifest (name, version, description)
    └── skills/
        └── <skill-name>/
            └── SKILL.md     # Skill prompt and metadata
```

### Installation

```bash
# Add the marketplace (once per user)
/plugin marketplace add maxa-ai/maxa-copilot-skills

# Install a plugin
/plugin install <plugin-name>@maxa-copilot-skills
```

### Testing locally

```bash
claude --plugin-dir ./plugins/<plugin-name>
```

## Git and Source Control

GitHub with trunk-based development. Short-lived feature branches off `main`, merged frequently, deleted after merge.

### Commits

[Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) enforced. Format: `<type>[optional scope]: <description>`.

Types: `feat`, `fix`, `docs`, `refactor`, `chore`.

### Branches

- Linear-tracked: `feature/<linear-id>-<description>` (e.g. `feature/studio-894-description`)
- Other: `<username>/<type>/<description>` (e.g. `johnd/fix/database-timeout`)

### Pull requests

Rebase over `main` before submitting. Reference Linear tasks in PR title or branch name — `Fixes STUDIO-123` auto-closes the task on merge.

### Releases

[Google Release Please](https://github.com/googleapis/release-please) automates versioning and changelogs from commit history. `feat:` → minor, `fix:` → patch, `BREAKING CHANGE:` → major.
