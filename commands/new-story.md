---
name: new-story
description: Creates a new story definition file in docs/ for a feature, with a technical breakdown, proposed architecture changes, and a phased task plan. Does not modify docs/architecture.md.
argument-hint: <subject of the story>
disable-model-invocation: true
---

Analyze the following user story definition:
$ARGUMENTS

1. Review the existing documentation regarding the subject the user provided.
2. Create the new story file under `docs/` with the name `NEW_FEATURE_STORY.md` where instead of NEW_FEATURE you will
   use the name of the feature in uppercase and with underscores instead of spaces.
3. Read `docs/architecture.md`. Identify the new or changed components, services, and interactions that this story
   requires.
4. Describe those changes in the story's `## Architecture Changes` section, with structural and behavioral diagrams
   where needed. Do not modify `docs/architecture.md`: it describes approved and implemented architecture only. The
   story's final phase contains the task to update it.
5. Write the story using the template below. You can split the implementation into phases if needed, but each phase
   must be complete in the terms that after each phase all tests pass and the application can be started.

```text
# Story Name

## Summary

## Technical Breakdown

### Structural Diagram (optional)

### Behavioral Diagram (optional)

## Architecture Changes (optional)

## Out of Scope (optional)

## Tasks

**Phase 1:**

- [ ] Ensure project compiles and existing tests are passing
- ...
- [ ] Mark all checkboxes as done in this document once verified

**Phase 2:**

- [ ] ...
- ...
- [ ] Mark all checkboxes as done in this document once verified

**Phase X:**

- [ ] Update `docs/architecture.md` with the changes from `## Architecture Changes` (if any)
- [ ] Update required documentation after the implementation is complete
- [ ] Ensure new tests are added for the new feature and all tests are passing
- [ ] Perform linting and formatting to maintain code quality and consistency
- [ ] Review the implementation to ensure it meets the requirements and follows best practices
- [ ] Mark all checkboxes as done in this document once verified
```

---

**Specification writing principles are here, load this file:**

@~/.claude/commands/_spec-practices.md
