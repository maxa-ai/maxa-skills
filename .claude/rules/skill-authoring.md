---
globs: plugins/*/skills/**
---

Skills are scoped by area — one concern per skill, not monolithic. Each skill lives at `plugins/<plugin>/skills/<skill-name>/SKILL.md`.

Skill naming:

- Skill names are a verb plus an object, such as `build-data-model`.
- A skill name should make sense on its own. Avoid generic one-word names.
- Use the same name for the same concept everywhere.
- In text, call the main specification "Maxa AI Specification", or "Maxa spec" for short.

SKILL.md files use YAML frontmatter (`name`, `version`, `description`, `metadata`) followed by the skill prompt in markdown. The `description` field controls when the skill triggers — make it specific and action-oriented.

Each skill should include `evals/evals.json` with test cases and assertions following the skill-creator format. Test fixtures (Maxa specs, schemas, sample data) live in `tests/fixtures/` at the repo root — shared across plugins, not duplicated per skill. Eval workspaces (`*-workspace/`) are gitignored.
