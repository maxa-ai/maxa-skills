---
globs: plugins/**
---

Every change to a plugin's content requires a version bump in `plugins/<name>/.claude-plugin/plugin.json`. Updates won't propagate to users without it. CI enforces this — PRs that modify files under `plugins/<name>/` without bumping the version will fail.

New plugins must also be registered in `.claude-plugin/marketplace.json`. Don't set `version` on marketplace entries: `plugin.json` wins at install time, so a second copy only drifts. See [Release a new version](https://code.claude.com/docs/en/plugins/host-marketplace#release-a-new-version).
