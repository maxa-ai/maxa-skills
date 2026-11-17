---
globs: plugins/**
---

Every change to a plugin's content requires a version bump in `plugins/<name>/.claude-plugin/plugin.json`. Updates won't propagate to users without it. CI enforces this — PRs that modify files under `plugins/<name>/` without bumping the version will fail.

Released plugins also have `plugins/<name>/.codex-plugin/plugin.json`, the manifest Codex reads. Bump its `version` at the same time. CI fails when the two manifests differ on `name`, `version` or `description`.

New plugins must also be registered in both catalogs: `.claude-plugin/marketplace.json` for Claude Code and `.agents/plugins/marketplace.json` for Codex. Don't set `version` on marketplace entries: `plugin.json` wins at install time, so a second copy only drifts. See [Release a new version](https://code.claude.com/docs/en/plugins/host-marketplace#release-a-new-version).
