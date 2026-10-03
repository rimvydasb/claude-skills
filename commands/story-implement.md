---
name: story-implement
argument-hint: <story definition file>
description: Implements the next incomplete phase of a story definition file, checks off tasks as they are verified, and stops at the end of the phase with a report for user review.
disable-model-invocation: true
---

Story definition Markdown file is: `$ARGUMENTS`

The general project information is stored in `docs/architecture.md` and `README.md` files.

Ensure the project compiles. If the project does not compile, do not proceed with the plan until all compilation errors
are resolved.

## Work Loop

The document `$ARGUMENTS` contains tasks under `## Tasks` that might be separated into phases.

1. Find the first phase that contains unchecked `- [ ]` tasks. Work only on this phase.
2. Take the next unchecked task in this phase and implement it.
3. Verify the task: build and run the tests relevant to it. A task is complete only when verification passes.
4. Mark the task as completed by changing the checkbox to `- [x]`, then continue with the next unchecked task in the same
   phase.

## Stop at the End of the Phase

When all tasks in the current phase are checked:

1. Run the verification of each acceptance criterion of the phase. Check a criterion only when its verification passes.
   If a criterion fails, fix the code and verify again. Do not weaken, skip, or delete tests or criteria.
2. Stop. Do not start the next phase.
3. Report to the user:
    - the completed phase, its tasks, and the result of each acceptance criterion;
    - the changed files;
    - the build, test, and lint results (pass/fail counts; failures verbatim);
    - each deviation from the story, and each decision you made that the story does not specify.

Also stop and report before the end of the phase when:

- a task is blocked, or its verification keeps failing after a reasonable attempt;
- the story is ambiguous or contradicts the code;
- a task requires a change to `docs/architecture.md` that the story does not describe.

The user starts the next phase by running this command again.
