# Contributing

Thank you for your interest in contributing to the Maxa Copilot Skills marketplace.

## Getting started

1. Fork the repository and create a feature branch from `main`
2. Make your changes following the guidelines below
3. Run validation locally: `.github/scripts/validate-plugins.sh`
4. Open a pull request against `main`

## Adding or modifying a plugin

Each plugin lives under `plugins/<plugin-name>/` with its own manifest and skills:

```
plugins/<plugin-name>/
├── .claude-plugin/
│   └── plugin.json      # name, version, description
└── skills/
    └── <skill-name>/
        ├── SKILL.md      # Skill prompt and metadata
        └── evals/
            └── evals.json  # Test cases and assertions
```

### Requirements

- **plugin.json** must include `name`, `version`, and `description`
- **SKILL.md** must include `name` and `description` in YAML frontmatter
- New plugins must be registered in `.claude-plugin/marketplace.json`
- To keep a plugin in `plugins/` without releasing it, leave it out of `marketplace.json` and add it to `UNRELEASED_PLUGINS` in `.github/scripts/validate-plugins.sh`
- **Bump the version** in `plugin.json` on every change — updates won't propagate without it

### Naming

Plugin names use the `maxa-` prefix followed by a domain noun (e.g., `maxa-specs`). See [CLAUDE.md](CLAUDE.md) for the naming convention.

### Testing

Test your plugin locally before submitting:

```bash
claude --plugin-dir ./plugins/<plugin-name>
```

### Evaluations

Each skill should include `evals/evals.json` with test cases following the [skill-creator](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/skill-creator) convention. Shared test fixtures live in `tests/fixtures/`.

## Commits

This project uses [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/). CI enforces this on pull requests.

```
feat(maxa-specs): add source-system routing to build-model
fix(maxa-specs): correct pre-flight checklist for GLAccount
docs: update README with new plugin
```

## Pull requests

- Keep PRs focused and reasonably sized
- Rebase over `main` before submitting
- Fill out the PR template (Summary, Why, What, Test Plan, Linear reference)

## Reporting issues

- **Bugs and feature requests** — open a GitHub issue
- **Security vulnerabilities** — email security@maxa.ai (see [SECURITY.md](.github/SECURITY.md))
