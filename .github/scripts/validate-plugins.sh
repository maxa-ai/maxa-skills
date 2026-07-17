#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
MARKETPLACE="$REPO_ROOT/.claude-plugin/marketplace.json"
PLUGINS_DIR="$REPO_ROOT/plugins"
errors=0

fail() {
  echo "FAIL: $1"
  errors=$((errors + 1))
}

# ── 1. Marketplace JSON validation ──

echo "── Validating marketplace.json ──"

if ! jq empty "$MARKETPLACE" 2>/dev/null; then
  fail "marketplace.json is not valid JSON"
else
  echo "OK: marketplace.json parses"

  if [ -z "$(jq -r '.name // empty' "$MARKETPLACE")" ]; then
    fail "marketplace.json missing required field: name"
  fi

  plugin_count=$(jq '.plugins | length' "$MARKETPLACE")
  if [ "$plugin_count" -eq 0 ]; then
    echo "WARN: marketplace.json has no plugins registered yet"
  else
    echo "OK: $plugin_count plugin(s) registered"
  fi
fi

# ── 2. Source path integrity ──

echo ""
echo "── Validating marketplace source paths ──"

for source in $(jq -r '.plugins[].source' "$MARKETPLACE"); do
  resolved="$REPO_ROOT/$source"
  if [ ! -d "$resolved" ]; then
    fail "marketplace source path does not exist: $source"
  elif [ ! -f "$resolved/.claude-plugin/plugin.json" ]; then
    fail "marketplace source path missing .claude-plugin/plugin.json: $source"
  else
    echo "OK: $source -> plugin.json found"
  fi
done

# ── 3. Orphan detection ──

echo ""
echo "── Checking for orphan plugins ──"

registered=$(jq -r '.plugins[].source' "$MARKETPLACE" | xargs -I{} basename {})
found_orphan=false

for plugin_dir in "$PLUGINS_DIR"/*/; do
  [ -d "$plugin_dir" ] || continue
  plugin_name="$(basename "$plugin_dir")"

  if ! echo "$registered" | grep -qx "$plugin_name"; then
    fail "plugin '$plugin_name' exists in plugins/ but is not registered in marketplace.json"
    found_orphan=true
  fi
done

if [ "$found_orphan" = false ]; then
  echo "OK: no orphan plugins"
fi

# ── 4. Plugin schema validation (claude plugin validate) ──

echo ""
echo "── Validating plugin schemas ──"

if command -v claude >/dev/null 2>&1; then
  for plugin_dir in "$PLUGINS_DIR"/*/; do
    [ -d "$plugin_dir" ] || continue
    plugin_name="$(basename "$plugin_dir")"

    if ! claude plugin validate "$plugin_dir" --strict 2>&1; then
      fail "$plugin_name failed claude plugin validate --strict"
    else
      echo "OK: $plugin_name passes claude plugin validate --strict"
    fi
  done
else
  echo "SKIP: claude CLI not available (install with: npm install -g @anthropic-ai/claude-code)"
fi

# ── 5. Version bump enforcement ──

echo ""
echo "── Checking version bumps ──"

BASE_REF="${GITHUB_BASE_REF:-main}"

if git rev-parse --verify "origin/$BASE_REF" >/dev/null 2>&1; then
  changed_files=$(git diff --name-only "origin/$BASE_REF"...HEAD 2>/dev/null || true)

  if [ -n "$changed_files" ]; then
    declare -A checked_plugins

    while IFS= read -r file; do
      if [[ "$file" == plugins/*/* ]]; then
        plugin_name=$(echo "$file" | cut -d/ -f2)

        [ "${checked_plugins[$plugin_name]:-}" = "1" ] && continue
        checked_plugins[$plugin_name]=1

        plugin_json="plugins/$plugin_name/.claude-plugin/plugin.json"
        [ -f "$plugin_json" ] || continue

        if ! git show "origin/$BASE_REF:$plugin_json" >/dev/null 2>&1; then
          echo "OK: $plugin_name is new, no version bump required"
          continue
        fi

        old_version=$(git show "origin/$BASE_REF:$plugin_json" | jq -r '.version // empty')
        new_version=$(jq -r '.version // empty' "$plugin_json")

        if [ "$old_version" = "$new_version" ]; then
          fail "$plugin_name: content changed but version not bumped (still $old_version)"
        else
          echo "OK: $plugin_name version bumped $old_version -> $new_version"
        fi
      fi
    done <<< "$changed_files"
  fi
else
  echo "SKIP: base branch origin/$BASE_REF not available (run with fetch-depth: 0)"
fi

# ── Summary ──

echo ""
if [ "$errors" -gt 0 ]; then
  echo "Validation failed with $errors error(s)"
  exit 1
else
  echo "All checks passed"
fi
