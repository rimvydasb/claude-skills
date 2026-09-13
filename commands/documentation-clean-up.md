---
name: documentation-clean-up
description: Cleans up documentation and code comments in the given scope - removes outdated, duplicated, and reviewer-directed text, moves design reasoning to docs/architecture-adr.md, and rewrites documentation in Simplified Technical English.
argument-hint: <scope, file or directory>
disable-model-invocation: true
---

# Documentation Clean-Up

You will review all documentation and the code comments in the specified scope and refine them to ensure they are
accurate, clear, and consistent with the current state of the codebase. The goal is to eliminate any outdated or
misleading information and to ensure that all documentation accurately reflects the functionality and behavior of the
code. The second goal is to shrink the amount of the code comments and documentation to the minimum needed to understand
the code and its functionality.

## Scope

$ARGUMENTS

## Tasks

**Setup:**

- [ ] Create the `docs/architecture-adr.md` file if it does not exist.

**Refine all code comments in specified scope based on following rules:**

- [ ] Eliminate the following forbidden statements, sentences and text fragments that:
    - explains what the code does not do;
    - explains what the code what it used to do before;
    - alternatives considered and rejected, that are not implemented with the code;
    - restatements of the identifier name;
    - anything addressed to the reviewer ("note that", "as requested", "this is deliberate"). All of this information is
      not needed in the code comments and should be removed.

- [ ] Move reasoning, background information, and rejected alternatives to `docs/architecture-adr.md`, using the ADR
  template (`~/.claude/skills/spec-writing/templates/adr.md`).
- [ ] Eliminate duplicated information.
- [ ] Aggregate code comments if it helps to reduce the amount of text and improve clarity.
- [ ] Leave the information that is non-obvious and is not quickly discoverable from the code itself.
- [ ] Find out if the code comment holds important information or is just an internal reasoning that does not have any
  value for the reader. If it is just an internal reasoning that was done by the implementing agent, eliminate that code
  comment.

**Refine documentation in the specified scope based on following rules:**

- [ ] Rewrite documentation and comments in ASD-STE100 Simplified Technical English (STE).
- [ ] Apply the `spec-writing` standard (loaded below) to documentation files.
- [ ] Eliminate duplicated information.
- [ ] Aggregate information if it helps to reduce the amount of text and improve clarity.
- [ ] Validate every documentation file that contains Mermaid diagrams with the `mermaid-diagrams` validation script.

**Comments Style Rules:**

- [ ] Use `//` for single-line comments.
- [ ] Use consecutive `//` lines instead of `/* */` blocks for multi-line implementation comments.
- [ ] Use doc comments (`/** */` in TypeScript/JavaScript, `///` in Rust) only for public API documentation.
- [ ] Place a comment on the line above the code it describes.
- [ ] Use one consistent comment style within a file: start with a capital letter, write complete sentences in doc
  comments.

---

**Writing and diagram standards:**

@~/.claude/skills/spec-writing/SKILL.md

@~/.claude/skills/mermaid-diagrams/SKILL.md