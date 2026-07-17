---
globs: plugins/**
---

Every change to a plugin's content requires a version bump in `plugins/<name>/.claude-plugin/plugin.json`. Updates won't propagate to users without it. CI enforces this — PRs that modify files under `plugins/<name>/` without bumping the version will fail.

New plugins must also be registered in `.claude-plugin/marketplace.json`.
