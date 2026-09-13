---
name: story-review
description: Reviews a story definition file against the codebase and docs/architecture.md, fixes minor gaps, completes Todo/TBC placeholders, applies architect answers, and records significant gaps as Open Questions with resolution options. Edits only the story file.
argument-hint: <story definition file>
disable-model-invocation: true
---

# Story Review

Story definition Markdown file: `$ARGUMENTS`

Project context:

- `docs/architecture.md` and `README.md` describe the project.
- `CLAUDE.md`, `AGENTS.md` or `GEMINI.md` (if present) define project priorities and conventions (for example, WASM
  binary size before performance).

The result of this review is an updated story file that can be implemented without confusion. The architect reads the
`## Open Questions` section and answers the questions in the story file.

## Constraints

- Edit only `$ARGUMENTS`. Do not modify code, tests, or `docs/architecture.md`. If the story requires architecture
  changes, describe them in the story. `docs/architecture.md` is updated only after the story is approved and
  implemented.
- Do not lose important information. Make precise, minimal edits; rephrasing and reordering for clarity is allowed.
- We are in the development phase: backward compatibility is not required, and architectural changes are allowed when
  backed by a clear reason.

## Steps

**Step 1: Compare the story with the code**

Check whether the story is up to date with the code. Mark a task `- [x]` only when you have located the code that
implements it (and the tests, where the task requires tests). If you are not sure, leave the task unchecked. In your
final message to the user, list each task you marked with the file path that proves it.

**Step 2: Apply architect answers and notes**

- Review answers the architect wrote under `## Open Questions` and in `> Architect notes:` blocks.
- Incorporate each answer into the relevant story section. Add a `> Clarification:` note where the reasoning must be
  kept.
- Remove answered questions and addressed architect notes.

**Step 3: Fix minor gaps and complete placeholders**

- Fix clear, minor inconsistencies directly, without asking questions.
- Find `Todo`, `TODO`, `TBC` and `> Todo:` placeholders. Complete those you can resolve from the code, the documentation,
  and the story. Turn the rest into Open Questions.

**Step 4: Record significant gaps as Open Questions**

- Re-check existing Open Questions: remove those that no longer apply, update those that remain.
- Add each significant inconsistency, blocker, or gap that must be resolved before implementation. Create the
  `## Open Questions` section if it does not exist.
- Each question references the story section (and the code file, where relevant) it is about, and offers resolution
  options where possible.
- Report only real problems. If the story is ready for implementation, say so. Do not invent questions to fill the
  section.

## Review Standard

- Apply industry standards and current best practices for the project's languages and frameworks, weighed against the
  project priorities.
- The architect works in a narrow domain and may not know alternative solutions or best practices from other areas. If
  you know a better architectural pattern or a clearer mental model, propose it as an Open Question with options.
- Be critical. Do not agree with the architect's ideas by default; the architect wants to be corrected where the story
  would fail.
- A decision that increases complexity or cognitive load can be correct when it serves a higher project priority (for
  example, WASM size or performance). Make such trade-offs explicit instead of rejecting them.

## Story Conventions

The story notation (`> Todo:`, `> Architect notes:`, `> Clarification:`, checkboxes, TypeScript interfaces) is defined in
Section 6 of the writing standard below. Write Open Questions with this template:

@~/.claude/skills/spec-writing/templates/open-questions.md

If you change a diagram, validate the story with the `mermaid-diagrams` validation script.

---

**Writing and diagram standards - apply them to the story:**

@~/.claude/skills/spec-writing/SKILL.md

@~/.claude/skills/mermaid-diagrams/SKILL.md
