#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
MARKETPLACE="$REPO_ROOT/.claude-plugin/marketplace.json"
PLUGINS_DIR="$REPO_ROOT/plugins"
# Plugins kept in plugins/ but intentionally not registered in marketplace.json.
# They skip the orphan, version-bump, and directory-profile checks; schema validation still runs.
UNRELEASED_PLUGINS=(maxa-preflight)
errors=0

fail() {
  echo "FAIL: $1"
  errors=$((errors + 1))
}

is_unreleased() {
  local name
  for name in "${UNRELEASED_PLUGINS[@]}"; do
    [ "$name" = "$1" ] && return 0
  done
  return 1
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
    if is_unreleased "$plugin_name"; then
      echo "OK: $plugin_name is unreleased, not registered on purpose"
      continue
    fi
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

    # Released plugins also get Anthropic's directory checks (README, license, icon).
    validate_args=(--strict)
    if ! is_unreleased "$plugin_name"; then
      validate_args+=(--profile directory)
    fi

    if ! claude plugin validate "$plugin_dir" "${validate_args[@]}" 2>&1; then
      fail "$plugin_name failed claude plugin validate ${validate_args[*]}"
    else
      echo "OK: $plugin_name passes claude plugin validate ${validate_args[*]}"
    fi
  done
else
  echo "SKIP: claude CLI not available (install with: npm install -g @anthropic-ai/claude-code)"
fi

# ── 5. Codex catalog and manifests ──
#
# Codex reads .agents/plugins/marketplace.json before the legacy .claude-plugin
# catalog, and .codex-plugin/plugin.json before .claude-plugin/plugin.json.
# Both catalogs list the same plugins. Both manifests share name, version and
# description, so the version bump check in section 6 covers the Codex manifest.

echo ""
echo "── Validating Codex catalog and manifests ──"

CODEX_MARKETPLACE="$REPO_ROOT/.agents/plugins/marketplace.json"

if [ ! -f "$CODEX_MARKETPLACE" ]; then
  fail ".agents/plugins/marketplace.json is missing"
elif ! jq empty "$CODEX_MARKETPLACE" 2>/dev/null; then
  fail ".agents/plugins/marketplace.json is not valid JSON"
else
  echo "OK: .agents/plugins/marketplace.json parses"

  if [ "$(jq -r '.name // empty' "$CODEX_MARKETPLACE")" != "$(jq -r '.name // empty' "$MARKETPLACE")" ]; then
    fail "the two marketplace catalogs have different names"
  fi

  missing=$(jq -r '.plugins[]
    | select((.name // "") == "" or (.source.path // "") == "" or (.policy.installation // "") == ""
             or (.policy.authentication // "") == "" or (.category // "") == "")
    | .name // "<unnamed>"' "$CODEX_MARKETPLACE")
  for name in $missing; do
    fail "Codex catalog entry '$name' needs name, source.path, policy.installation, policy.authentication and category"
  done

  for source in $(jq -r '.plugins[].source.path // empty' "$CODEX_MARKETPLACE"); do
    if [ ! -d "$REPO_ROOT/$source" ]; then
      fail "Codex catalog source path does not exist: $source"
    fi
  done

  claude_names=$(jq -r '.plugins[].name' "$MARKETPLACE" | sort)
  codex_names=$(jq -r '.plugins[].name' "$CODEX_MARKETPLACE" | sort)
  if [ "$claude_names" != "$codex_names" ]; then
    fail "the Codex and Claude catalogs list different plugins (Claude: $(echo $claude_names), Codex: $(echo $codex_names))"
  else
    echo "OK: both catalogs list the same plugins"
  fi
fi

for plugin_dir in "$PLUGINS_DIR"/*/; do
  [ -d "$plugin_dir" ] || continue
  plugin_name="$(basename "$plugin_dir")"
  codex_json="$plugin_dir.codex-plugin/plugin.json"
  claude_json="$plugin_dir.claude-plugin/plugin.json"

  if [ ! -f "$codex_json" ]; then
    if is_unreleased "$plugin_name"; then
      echo "OK: $plugin_name is unreleased, no Codex manifest required"
    else
      fail "$plugin_name has no .codex-plugin/plugin.json"
    fi
    continue
  fi

  errors_before=$errors

  if ! jq empty "$codex_json" 2>/dev/null; then
    fail "$plugin_name: .codex-plugin/plugin.json is not valid JSON"
    continue
  fi

  for field in name version description; do
    if [ "$(jq -r ".$field // empty" "$codex_json")" != "$(jq -r ".$field // empty" "$claude_json")" ]; then
      fail "$plugin_name: '$field' differs between .codex-plugin/plugin.json and .claude-plugin/plugin.json"
    fi
  done

  # Listing limits from OpenAI's plugin submission docs.
  problems=$(jq -r '
    .interface as $i
    | [ (["displayName","shortDescription","longDescription","developerName","logo","composerIcon"][]
          | select(($i[.] // "") == "") | "interface.\(.) is required"),
        (if ($i.capabilities | type) != "array" then "interface.capabilities must be an array" else empty end),
        (if ($i.displayName // "" | length) > 30 then "interface.displayName is over 30 characters" else empty end),
        (if ($i.shortDescription // "" | length) > 30 then "interface.shortDescription is over 30 characters" else empty end),
        (if ($i.longDescription // "" | length) > 4000 then "interface.longDescription is over 4000 characters" else empty end),
        (if ($i.developerName // "" | length) > 80 then "interface.developerName is over 80 characters" else empty end),
        (if ($i.defaultPrompt // [] | length) > 3 then "interface.defaultPrompt has more than 3 prompts" else empty end),
        (($i.defaultPrompt // [])[] | select(length > 128) | "interface.defaultPrompt over 128 characters: \(.)"),
        (if ($i.brandColor // "#000000" | test("^#[0-9A-Fa-f]{6}$") | not) then "interface.brandColor must be #RRGGBB" else empty end)
      ] | .[]' "$codex_json")
  while IFS= read -r problem; do
    [ -n "$problem" ] && fail "$plugin_name: $problem"
  done <<< "$problems"

  for icon in $(jq -r '.interface.logo // empty, .interface.composerIcon // empty' "$codex_json" | sort -u); do
    if [ ! -f "$plugin_dir$icon" ]; then
      fail "$plugin_name: icon file not found: $icon"
    fi
  done

  if [ "$errors" -eq "$errors_before" ]; then
    echo "OK: $plugin_name passes the Codex manifest checks"
  fi
done

# ── 6. Version bump enforcement ──

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

        if is_unreleased "$plugin_name"; then
          echo "OK: $plugin_name is unreleased, no version bump required"
          continue
        fi

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
