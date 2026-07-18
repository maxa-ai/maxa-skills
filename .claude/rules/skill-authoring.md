---
globs: plugins/*/skills/**
---

Skills are scoped by area — one concern per skill, not monolithic. Each skill lives at `plugins/<plugin>/skills/<skill-name>/SKILL.md`.

SKILL.md files use YAML frontmatter (`name`, `version`, `description`, `metadata`) followed by the skill prompt in markdown. The `description` field controls when the skill triggers — make it specific and action-oriented.

Each skill should include `evals/evals.json` with test cases and assertions following the skill-creator format. Test fixtures (bundles, schemas, sample data) live in `tests/fixtures/` at the repo root — shared across plugins, not duplicated per skill. Eval workspaces (`*-workspace/`) are gitignored.
