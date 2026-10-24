---
name: nodejs-ensure-quality
description: Recommended quality tooling for a Node.js project - .nvmrc Node lock, Prettier, oxlint, dependency-cruiser - and the Claude Code hooks that run them. Use to set up or repair that tooling in a project. The agent adapts the reference templates to the project and changes nothing without approval.
---

# Ensure Node.js quality tooling

This skill is a recommendation, not an installer. The reference files in `templates/` show the baseline. Adapt them to
the project in front of you. Do not copy them blindly. The baseline can differ per project and change between versions
of this skill.

## Baseline

| Concern             | Recommendation                                                                      | Reference                                                      |
| ------------------- | ----------------------------------------------------------------------------------- | -------------------------------------------------------------- |
| Node version        | `.nvmrc` with the Node major the project targets.                                   | -                                                              |
| Formatting          | Prettier. Ignore build output and `node_modules`.                                   | `templates/prettierrc.json`                                    |
| Linting             | oxlint. `lint` reports errors only, `lint:all` reports everything.                  | `templates/oxlintrc.json`                                      |
| Architecture rules  | dependency-cruiser: no cycles, no unresolvable imports, no dev dependencies in production code, no test imports. Known violations go to a baseline file. | `templates/dependency-cruiser.cjs` |
| package.json        | Scripts `format`, `format:check`, `lint`, `lint:all`, `depcruise`, `depcruise:baseline`. | Commands in the script table below the hooks section.      |
| Claude Code hooks   | Format and lint each edited file. Run depcruise and lint before the agent stops.    | `templates/hooks/`, `templates/hooks-settings.json`            |

dependency-cruiser needs `@swc/core` only to parse TypeScript. Skip it for JavaScript-only projects.

## Hooks

| Hook                                   | Script                   | Behavior                                                                                                                    |
| -------------------------------------- | ------------------------ | --------------------------------------------------------------------------------------------------------------------------- |
| `SessionStart`                         | `ensure-node-version.sh` | Makes nvm's default Node match `.nvmrc`. This changes the machine-wide nvm default, so make it opt-in.                      |
| `PostToolUse` (Edit, Write, MultiEdit) | `format-file.sh`         | Runs `prettier --write`, then `oxlint` on the changed file. Lint errors go back to the agent (exit 2).                      |
| `Stop`, `SubagentStop`                 | `check.sh`               | Runs `npm run depcruise` and `npm run lint`. Failures go back to the agent. After 3 failed attempts it lets the agent stop. |

`node-env.sh` is sourced by the other scripts. It selects the `.nvmrc` Node through nvm and adds `node_modules/.bin` to
`PATH`. The scripts need `jq`. `check.sh` has a `checks` array for extra scripts such as typecheck or tests.

The package.json scripts the baseline uses:

| Script               | Command                                                                                  |
| -------------------- | ---------------------------------------------------------------------------------------- |
| `format`             | `prettier --write --log-level warn "**/*.{ts,tsx,js,cjs,mjs,json,md}"`                   |
| `format:check`       | `prettier --check "**/*.{ts,tsx,js,cjs,mjs,json,md}"`                                    |
| `lint`               | `oxlint --quiet`                                                                         |
| `lint:all`           | `oxlint`                                                                                 |
| `depcruise`          | `depcruise . --config .dependency-cruiser.cjs --ignore-known --output-type err-long`     |
| `depcruise:baseline` | `depcruise-baseline . --config .dependency-cruiser.cjs`                                  |

## Procedure

### 1. Inspect (read only)

Change nothing in this step. Find out:

- the package manager (lockfile: `package-lock.json`, `pnpm-lock.yaml`, `yarn.lock`, `bun.lock`)
- the Node version manager and the existing `.nvmrc` or `engines` field
- whether the project uses TypeScript
- existing formatter, linter and import-rule setups (ESLint, Biome, Prettier configs, existing scripts)
- existing `.claude/settings.json` hooks and `.claude/hooks/`
- whether `jq` is installed

### 2. Report a plan and wait for approval

List each item as one of: add, change, keep, skip. Give the reason for every change and every skip. Show a diff
against the template for any file that already exists. Do not touch anything before the user approves.

### 3. Apply the approved items

- Use the project's package manager for installs and scripts. Never create a second lockfile.
- Never overwrite an existing config, script or hook. Merge by hand into `package.json` and `.claude/settings.json`,
  keeping all existing entries.
- Treat these as opt-in and name each one in the plan: `.nvmrc` creation, `ensure-node-version.sh` (it changes the nvm
  default), `@swc/core`, and any replacement of an existing tool.
- Copy hook scripts as they are unless the project needs a change. Make them executable.
- Adjust the templates to the project (globs, ignores, source folders) instead of editing the project to fit them.

### 4. Verify (read only)

Run Prettier, oxlint and dependency-cruiser once. Report the result as it is. Existing violations are not a failure of
the setup:

- Ask the user whether to fix them or record them with the `depcruise:baseline` script.
- Never weaken a rule to make the run pass.
- Do not run `--write` or baseline commands as part of verification.

### 5. Report

Tell the user what was added, changed and kept, and what is still open.

## Project-specific changes

- Project rules go below the `Project rules` marker in `.dependency-cruiser.cjs`. Project oxlint rules go in
  `.oxlintrc.json` `overrides`. Extra checks go in the `checks` array of `check.sh`.
- Do not copy project-specific changes back into `templates/` unless the user asks to change the shared defaults.

## Maintaining the defaults

Edit the files in `templates/` to change the recommendation. Existing projects are not updated automatically. To
refresh one, run this procedure there and review the diffs.
