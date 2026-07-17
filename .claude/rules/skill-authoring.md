---
globs: plugins/*/skills/**
---

Skills are scoped by area — one concern per skill, not monolithic. Each skill lives at `plugins/<plugin>/skills/<skill-name>/SKILL.md`.

SKILL.md files use YAML frontmatter (`name`, `version`, `description`, `metadata`) followed by the skill prompt in markdown. The `description` field controls when the skill triggers — make it specific and action-oriented.
