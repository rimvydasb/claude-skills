---
name: documentation-clean-up
description: Cleans up code comments and doc comments in the given scope - removes outdated, duplicated, and reviewer-directed text, moves design decisions to docs/architecture-adr.md, rewrites comments in Simplified Technical English, and verifies that the build and tests still pass. For Markdown documents, use /docs-refine.
argument-hint: <scope, file or directory>
disable-model-invocation: true
---

# Documentation Clean-Up

Review the code comments and doc comments in scope. Make them accurate and consistent with the current code, and shrink
them to the minimum a reader needs to understand the code.

Edit only comments. Do not change code behavior. For Markdown documents, use `/docs-refine`.

Load the `spec-writing` skill before you edit, unless it is already loaded in this session. Sections 2, 3, and 5 apply to
comments.

## Scope

$ARGUMENTS

## Tasks

**Remove text that has no value for the reader:**

- [ ] Remove statements that:
    - explain what the code does not do;
    - explain what the code did before;
    - describe alternatives that are not implemented;
    - restate the identifier name;
    - address the reviewer ("note that", "as requested", "this is deliberate").
- [ ] Remove duplicated information. Aggregate comments where this reduces text and improves clarity.
- [ ] Keep information that is non-obvious and not quickly discoverable from the code.

**Sort reasoning with the `spec-writing` Section 5 rule:**

- [ ] A decision that constrains future changes (the chosen approach, a rejected alternative, removed behavior): move it
  to `docs/architecture-adr.md` as an ADR entry. Create the file only when you have an entry to write.
- [ ] Deferred work: keep it as one short `TODO` comment only if the project already uses them; otherwise report it to
  the user.
- [ ] The implementing agent's own thinking: delete it.

**Rewrite the remaining comments:**

- [ ] Write in ASD-STE100 Simplified Technical English (STE) with precise words.

**Comment style rules:**

- [ ] Use `//` for single-line comments.
- [ ] Use consecutive `//` lines instead of `/* */` blocks for multi-line implementation comments.
- [ ] Use doc comments (`/** */` in TypeScript/JavaScript, `///` and `//!` in Rust) only for public API and module
  documentation.
- [ ] Place a comment on the line above the code it describes.
- [ ] Use one consistent comment style within a file: start with a capital letter, write complete sentences in doc
  comments.
- [ ] Keep code examples inside doc comments compilable. Rust doc examples are doctests.

## Verification

- [ ] Run the project build, the test suite (including Rust doctests), and the linter.
- [ ] If a check fails because of a comment change, fix the comment and run the checks again.
- [ ] Report to the user: the changed files, the ADR entries added, and the build, test, and lint results (failures
  verbatim).

## Template

@~/.claude/skills/spec-writing/templates/adr.md
