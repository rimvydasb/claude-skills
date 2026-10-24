#!/usr/bin/env bash
# Idempotent setup of Node.js quality tooling in the current project (run from the project root).
# Usage: setup.sh [--force] [node-version]
#   --force        overwrite existing .prettierrc.json, .oxlintrc.json, .dependency-cruiser.cjs and hook scripts
#   node-version   value for .nvmrc when it does not exist (default: major version of the active Node)
# Existing config files are kept unless --force is given. package.json scripts and settings.json hooks are merged.
set -euo pipefail

skill_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
tpl="$skill_dir/templates"
force=0
node_version=""
for arg in "$@"; do
    case "$arg" in
        --force) force=1 ;;
        *) node_version="$arg" ;;
    esac
done

[ -f package.json ] || { echo "No package.json in $(pwd). Run npm init first." >&2; exit 1; }
command -v jq >/dev/null || { echo "jq is required." >&2; exit 1; }

install_file() { # src dest
    if [ -e "$2" ] && [ "$force" = 0 ]; then
        echo "kept      $2"
    else
        mkdir -p "$(dirname "$2")"
        cp "$1" "$2"
        echo "wrote     $2"
    fi
}

# 1. Node version lock
if [ -f .nvmrc ]; then
    echo "kept      .nvmrc ($(tr -d '[:space:]' <.nvmrc))"
else
    [ -n "$node_version" ] || node_version=$(node -p 'process.versions.node.split(".")[0]')
    echo "$node_version" >.nvmrc
    echo "wrote     .nvmrc ($node_version)"
fi

# 2. Shared configs
install_file "$tpl/prettierrc.json" .prettierrc.json
install_file "$tpl/oxlintrc.json" .oxlintrc.json
install_file "$tpl/dependency-cruiser.cjs" .dependency-cruiser.cjs
[ -f .dependency-cruiser-known-violations.json ] || echo '[]' >.dependency-cruiser-known-violations.json
if [ ! -f .prettierignore ]; then
    printf 'dist\nbuild\ncoverage\nnode_modules\n' >.prettierignore
    echo "wrote     .prettierignore"
fi

# 3. Hook scripts
for f in ensure-node-version.sh node-env.sh format-file.sh check.sh; do
    install_file "$tpl/hooks/$f" ".claude/hooks/$f"
    chmod +x ".claude/hooks/$f"
done

# 4. Hook registration in .claude/settings.json (adds missing commands only)
settings=.claude/settings.json
[ -f "$settings" ] || echo '{}' >"$settings"
merged=$(jq --slurpfile t "$tpl/hooks-settings.json" '
    reduce ($t[0].hooks | to_entries[]) as $e (.;
        reduce $e.value[] as $entry (.;
            if ([.hooks[$e.key][]?.hooks[]?.command] | index($entry.hooks[0].command))
            then .
            else .hooks[$e.key] += [$entry]
            end))' "$settings")
printf '%s\n' "$merged" >"$settings"
echo "merged    $settings hooks"

# 5. package.json scripts and devDependencies
npm pkg set \
    'scripts.format=prettier --write --log-level warn "**/*.{ts,tsx,js,cjs,mjs,json,md}"' \
    'scripts.format:check=prettier --check "**/*.{ts,tsx,js,cjs,mjs,json,md}"' \
    'scripts.lint=oxlint --quiet' \
    'scripts.lint:all=oxlint' \
    'scripts.depcruise=depcruise . --config .dependency-cruiser.cjs --ignore-known --output-type err-long' \
    'scripts.depcruise:baseline=depcruise-baseline . --config .dependency-cruiser.cjs' >/dev/null
echo "set       package.json scripts (format, format:check, lint, lint:all, depcruise, depcruise:baseline)"

missing=()
for pkg in prettier oxlint dependency-cruiser @swc/core; do
    jq -e --arg p "$pkg" '(.dependencies[$p] // .devDependencies[$p]) != null' package.json >/dev/null || missing+=("$pkg")
done
if [ "${#missing[@]}" -gt 0 ]; then
    npm install --save-dev "${missing[@]}"
fi

# 6. Verify
npx --no-install prettier --check .prettierrc.json .oxlintrc.json >/dev/null && echo "verified  prettier"
npx --no-install oxlint --quiet >/dev/null && echo "verified  oxlint"
npx --no-install depcruise . --config .dependency-cruiser.cjs --ignore-known --output-type err >/dev/null \
    && echo "verified  dependency-cruiser" \
    || echo "WARNING   dependency-cruiser reports violations; fix them or run: npm run depcruise:baseline"
