# Story Template

File: `docs/FEATURE_NAME_STORY.md`. `FEATURE_NAME` is the feature name in uppercase, with underscores for spaces.

- Split the tasks into phases if needed. After each phase, all tests pass and the application starts.
- Each feature phase has a task to add tests for the code of that phase.
- Each phase ends with an `Acceptance criteria:` checkbox list. Each criterion names the command, the test name, or the
  manual step that verifies it. "Works correctly" is not a criterion.
- `## Verification` lists the real commands of the project. Find them in `package.json`, `Makefile`, `Cargo.toml`, CI
  files, or `README.md`. Do not invent commands.
- Add the E2E phase only if the project has an E2E test setup. Otherwise, omit the phase and the E2E row.

```markdown
# Story Name

## Summary

## Technical Breakdown

### Structural Diagram (optional)

### Behavioral Diagram (optional)

## Architecture Changes (optional)

## Out of Scope (optional)

## Open Questions (optional)

## Verification

| Check  | Command           |
|--------|-------------------|
| Build  | `npm run build`   |
| Lint   | `npm run lint`    |
| Test   | `npm test`        |
| E2E    | `npm run e2e`     |
| Start  | `npm run dev`     |

## Tasks

**Phase 1:**

- [ ] Ensure project compiles and existing tests are passing
- [ ] ...
- [ ] Add tests for the code of this phase

Acceptance criteria:

- [ ] `npm test` passes, including `<new test name>`
- [ ] ...

**Phase 2:**

- [ ] ...
- [ ] Add tests for the code of this phase

Acceptance criteria:

- [ ] ...

**Phase E2E (only if the project has an E2E setup):**

- [ ] Add E2E tests for the user flows of this story

Acceptance criteria:

- [ ] `npm run e2e` passes, including `<new E2E test name>`

**Phase X:**

- [ ] Update `docs/architecture.md` with the changes from `## Architecture Changes` (if any)
- [ ] Update the documentation that the implementation changes
- [ ] Review the implementation against this story and the project conventions

Acceptance criteria:

- [ ] Every command in `## Verification` passes
- [ ] The application starts with the Start command
```
