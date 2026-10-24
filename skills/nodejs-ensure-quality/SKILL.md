---
name: nodejs-ensure-quality
description: Set up or repair the standard quality tooling of a Node.js project .nvmrc Node lock, Prettier, oxlint and dependency-cruiser with the shared default configs, plus the Claude Code hooks that run them.
---

# Ensure Node.js quality tooling

Every Node.js project gets the same baseline. The defaults live in this skill's `templates/` folder, so all projects
start from one source.

## Run

From the project root (the folder with `package.json`):

```sh
.claude/skills/nodejs-ensure-quality/setup.sh [--force] [node-version]
```

If the skill is installed globally, use `~/.claude/skills/nodejs-ensure-quality/setup.sh`.

The script is idempotent:

| Step                                                            | Result                                                                                                                                                                                |
| --------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `.nvmrc`                                                        | Created with the given version, or the major version of the active Node. An existing file is kept.                                                                                    |
| `.prettierrc.json`, `.oxlintrc.json`, `.dependency-cruiser.cjs` | Copied from `templates/`. Existing files are kept unless `--force`.                                                                                                                   |
| `.dependency-cruiser-known-violations.json`, `.prettierignore`  | Created when missing.                                                                                                                                                                 |
| `.claude/hooks/*.sh`                                            | `ensure-node-version.sh`, `node-env.sh`, `format-file.sh`, `check.sh` copied from `templates/hooks/`.                                                                                 |
| `.claude/settings.json`                                         | Hook entries merged in (`SessionStart`, `PostToolUse`, `Stop`, `SubagentStop`). Existing hooks stay.                                                                                  |
| `package.json`                                                  | Scripts `format`, `format:check`, `lint`, `lint:all`, `depcruise`, `depcruise:baseline`. Missing dev dependencies installed: `prettier`, `oxlint`, `dependency-cruiser`, `@swc/core`. |

Then it runs Prettier, oxlint and dependency-cruiser once and prints the result.

## Hooks

| Hook                                   | Script                   | Behavior                                                                                                                    |
| -------------------------------------- | ------------------------ | --------------------------------------------------------------------------------------------------------------------------- |
| `SessionStart`                         | `ensure-node-version.sh` | Makes nvm's default Node match `.nvmrc`.                                                                                    |
| `PostToolUse` (Edit, Write, MultiEdit) | `format-file.sh`         | Runs `prettier --write`, then `oxlint` on the changed file. Lint errors go back to the agent (exit 2).                      |
| `Stop`, `SubagentStop`                 | `check.sh`               | Runs `npm run depcruise` and `npm run lint`. Failures go back to the agent. After 3 failed attempts it lets the agent stop. |

`node-env.sh` is sourced by the other scripts. It selects the `.nvmrc` Node and adds `node_modules/.bin` to `PATH`.

## After the run

1. Show the user the script output, including anything it kept instead of overwriting.
2. If dependency-cruiser reports violations in existing code, ask whether to fix them or record them with
   `npm run depcruise:baseline`. Never weaken the rules to make the run pass.
3. Project-specific rules go below the `Project rules` marker in `.dependency-cruiser.cjs`; project-specific oxlint
   rules go in `.oxlintrc.json` `overrides`. For extra checks in `check.sh` (typecheck, tests), add the script names to
   its `checks` array.
4. Do not copy project-specific changes back into `templates/` unless the user asks to change the shared defaults. When
   they do, edit the template files here and re-run with `--force` in other projects.

## Maintaining the defaults

| File                               | Content                                                                                                      |
| ---------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| `templates/prettierrc.json`        | Prettier options.                                                                                            |
| `templates/oxlintrc.json`          | oxlint categories and ignores.                                                                               |
| `templates/dependency-cruiser.cjs` | Generic rules (no cycles, no unresolvable imports, no dev dependencies in production code, no test imports). |
| `templates/hooks/`                 | Hook scripts.                                                                                                |
| `templates/hooks-settings.json`    | Hook registration merged into `settings.json`.                                                               |
