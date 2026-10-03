---
name: code-review-deep
description: First-principles review of Rust or TypeScript/JavaScript code (a file, module, crate, or directory) for mental model, cognitive load, invariant enforcement, structure, and testability, with language-specific checks loaded from reference files. Produces a verified, prioritized _REVIEW.md report in docs/ with Mermaid diagrams and a refactoring roadmap. Use when the user asks to review Rust or JS/TS code, a module, its architecture, or its testability. Not for a diff or PR (use /code-review) or a whole system (use architecture-review).
argument-hint: <file, module, crate, or directory to review>
context: fork
allowed-tools: Read, Glob, Grep, Write, Bash(git log:*), Bash(git show:*), Bash(tree:*), Bash(rg:*), Bash(wc:*), Bash(bash ~/.claude/skills/mermaid-diagrams/scripts/validate.sh:*)
---

# Deep Code Review

Review the code in scope to identify structural and behavioral rot. Move beyond linting and evaluate the **mental model**
the code expresses and the **cognitive load** it puts on a developer. Look for what is wrong, not for what is acceptable.

The report is read by the developers who own this code. They use it to decide what to refactor, so findings must be
real, located in the code, and ordered by impact.

## Scope

$ARGUMENTS

Start in scope. Follow imports and callers into other modules where needed to understand coupling and behavior.

Do not modify source code during this review. Save the review as `docs/<scope-slug>_REVIEW.md`, where `<scope-slug>` is
a short kebab-case name of the scope. Load the `mermaid-diagrams` skill for every diagram, and run its validation script
on the saved review.

## Language References

Detect the languages from the file extensions in scope. Read the matching reference before Phase 2:

| Files in scope                                   | Reference                                                     |
|--------------------------------------------------|---------------------------------------------------------------|
| `.rs`, `Cargo.toml`                              | `~/.claude/skills/code-review-deep/references/rust.md`       |
| `.ts`, `.tsx`, `.js`, `.jsx`, `.mjs`, `.cjs`     | `~/.claude/skills/code-review-deep/references/typescript.md` |

- If the scope contains both languages, read both references.
- For other languages, apply only the general lenses below and state this in the report.

## Context

- Start with `docs/architecture.md` and `CLAUDE.md` or `AGENTS.md`. Check `*_SPEC.md` files in `docs/` for details on
  specific components.
- Some Markdown files may be outdated. When a document and the code disagree, the code is the fact; report the
  disagreement as a finding.
- Read the project priorities from `CLAUDE.md` (for example, WASM binary size before performance). A decision that adds
  complexity can be correct when it serves a higher priority. Make such trade-offs explicit instead of rejecting them.

## Phase 1: Structural and Behavioral Analysis

1. **Structural Map:** Draw a component diagram (`flowchart`, with the component notation of `mermaid-diagrams`) of the
   modules or packages and their dependency direction. Add a `classDiagram` only for key types, traits, or interfaces.
   Identify "God Objects" and circular dependencies.
2. **Behavioral Trace:** Identify the core state transitions and draw them as a `stateDiagram-v2`. If the code has no
   state machine, draw the main call flow as a `sequenceDiagram`.
3. **Mental Model Consistency:** Check whether the naming and module structure map 1:1 to the business domain, or whether
   there is a "Cognitive Gap" between the code and the intended architecture.

## Phase 2: First-Principles Skeptical Review

Analyze the Phase 1 results through these lenses:

1. **Logic Fragility:** Where does the logic break? Identify edge cases that are unhandled or silently ignored.
2. **Enforcement vs. Hope:** Does the code structurally enforce its invariants through types and visibility, or does it
   hope the developer remembers to call `validate()`?
3. **Structural Inconsistency:** Where does the implementation contradict the intended architecture (for example,
   domain logic leaking into infrastructure or adapters)?
4. **Abstraction Audit:** What assumptions and principles does this code rest on? Are they valid for this project and its
   priorities?
5. **Cognitive Load:** Identify functions or modules with high cyclomatic complexity, unnecessary indirection, or unclear
   naming. Where is the mental model most likely to collapse for a new developer?
6. **Code Smell:** Find places where the code behavior does not match what the code expresses, or where the code looks
   suspicious. Investigate each place: does it hide a bug, a design flaw, or a detachment from the intended architecture?
7. **Testability:** Do tests exist for this code? Flag logic mixed with I/O or state mutation, dependencies created inside
   function bodies, code that needs 3 or more mocks to test, and hidden state shared across calls. Prefer simple code
   over testable-at-any-cost code, but flag code that cannot be tested at all.
8. **Language-Specific Checks:** Apply every check from the language reference.

## Evidence Rules

- Every finding cites the file and line (`src/module.rs:42`) and names the function, type, or module involved.
- Before reporting a finding, re-read the code and its callers to confirm it. Check for handling elsewhere: a caller that
  validates, a type that makes the state impossible, a test that covers the edge case.
- Mark each finding **Confirmed** (you traced the code path) or **Suspected** (plausible; state what must be checked).
  Drop findings you can neither confirm nor describe as a concrete check.
- Report only findings a senior developer on this codebase would act on. If a lens has no real findings, say so in one
  line. Do not pad the report with minor style remarks.

## Report

Developer-to-developer, direct, and skeptical. No sales fluff. If the architecture is fundamentally flawed, say so.

```markdown
# <Scope> Review

## Summary

2-3 sentences on the health of the code and the most critical problem.

## Strengths and Weaknesses

- **Strongest mental model:** ...
- **Where the mental model collapses:** ...

## Structure

Structural diagram(s) from Phase 1.

## Behavior

Behavioral diagram from Phase 1.

## Findings

### 1. <Finding title>

- **Priority:** High | Moderate | Low
- **Confidence:** Confirmed | Suspected - what must be checked
- **Lens:** <lens name>
- **Location:** `path/file.rs:42`, `function_name`
- **Problem:** ...
- **Fix:** specific change and how it improves the code
- **Impact:** maintainability, correctness, size, performance, or security effect

## Refactoring Roadmap

- [ ] Step 1 ...
- [ ] Step 2 ...

Add diagrams of the proposed structure where a step changes it.
```

Order findings by priority: High (high value), Moderate, Low (optional). After saving, return the report path and the
High-priority findings as a short list.
