---
globs: plugins/*/skills/**
---

Skills are scoped by area — one concern per skill, not monolithic. Each skill lives at `plugins/<plugin>/skills/<skill-name>/SKILL.md`.

Skill naming:

- Skill names are a verb plus an object, such as `build-data-model`.
- A skill name should make sense on its own. Avoid generic one-word names.
- Use the same name for the same concept everywhere.
- In text, call the main specification "Maxa AI Specification", or "Maxa spec" for short.

SKILL.md files use YAML frontmatter followed by the skill prompt in markdown. The `description` field controls when the skill triggers — make it specific and action-oriented.

Use only the frontmatter fields that work in every Claude app:

- `name` and `description` (required)
- `license`, `compatibility`, `metadata`, `allowed-tools` (optional)

Do not use other fields. Claude Code accepts Claude Code-only fields such as `when_to_use`, `context`, and `paths`, and it ignores unknown fields such as `version`. Outside Claude Code (claude.ai, Cowork, the Skills API), any other field is a hard error, and the skill fails to load. Put extra data, such as a skill version, in `metadata`. See [Using skill frontmatter outside Claude Code](https://code.claude.com/docs/en/skills#using-skill-frontmatter-outside-claude-code).

Each skill should include `evals/evals.json` with test cases and assertions following the skill-creator format. Test fixtures (Maxa specs, schemas, sample data) live in `tests/fixtures/` at the repo root — shared across plugins, not duplicated per skill. Eval workspaces (`*-workspace/`) are gitignored.
