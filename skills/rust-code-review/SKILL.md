---
name: rust-code-review
description: First-principles review of Rust code for structural and behavioral problems, with a focus on WASM binary size and stack usage. Produces a _REVIEW.md report in docs/ with Mermaid diagrams, verified findings, and a refactoring roadmap. Use when the user asks to review Rust modules, crates, or Rust architecture.
argument-hint: <file, module, or directory to review>
context: fork
---

# Rust First-Principles Review

Review the Rust code in scope to identify structural and behavioral rot. Move beyond linting and evaluate the **Mental
Model** the code expresses and the **Cognitive Load** it puts on a developer.

The report is read by the developers who own this code. They use it to decide what to refactor, so findings must be
real, located in the code, and ordered by impact.

## Scope

$ARGUMENTS

Do not modify source code during this review. Write the review as a Markdown file (code snippets inside it are allowed)
and save it as `docs/<scope-slug>_REVIEW.md`, where `<scope-slug>` is a short kebab-case name of the scope. Write
all diagrams with the `mermaid-diagrams` skill, and run its validation script on the saved review.

## Context

- Start with `docs/architecture.md` and `CLAUDE.md`.
- Check `*_SPEC.md` files in `docs/` for details on specific components.
- Some Markdown files may be outdated. When a document and the code disagree, the code is the fact; report the
  disagreement as a finding.

## Goal

The overall goal is to maintain a clean, maintainable, and performant codebase that adheres to State-of-the-Art Rust
patterns.

### Phase 1: Structural & Behavioral Analysis

Before proposing changes, perform a deep-dive analysis:

1. **Structural Mapping:** Generate a **Mermaid `classDiagram`** showing the module hierarchy, trait implementations,
   and dependency flow. Identify "God Objects" or circular dependencies.
2. **Behavioral Trace:** Identify the core state transitions. Use a **Mermaid `stateDiagram`** to show how the system
   moves from one valid state to another.
3. **Mental Model Consistency:** Does the naming and module structure map 1:1 to the business domain, or is there a
   "Cognitive Gap" between the code and the intended architecture?

### Phase 2: First Principles Skeptical Review

Analyze the findings from Phase 1 through these seven critical lenses:

1. **Logic Fragility:** Where does the logic break? Identify edge cases currently unhandled or silently ignored (e.g.,
   partial writes, unhandled async cancellations, or `unwrap()` calls).
2. **Enforcement vs. Hope:** Does the code structurally enforce system invariants (via the Type-State pattern or Private
   Fields), or is it 'hoping' the developer remembers to call `validate()`?
3. **Structural Inconsistency:** Where does the implementation contradict the intended architecture (e.g., Domain logic
   leaking into Infrastructure/Adapters)?
4. **Abstraction Audit:** What are the underlying assumptions and principles of this code? Are they valid and
   well-founded for a SOTA Rust system?
5. **Cognitive Load:** Identify functions or modules with high cyclomatic complexity. Where is the "Mental Model" most
   likely to collapse for a new developer?
6. **Code Smell:** Identify places where the code behavior does not match what the code expresses, or where the code
   looks suspicious. Investigate each such place and find out whether it hides a bug, a design flaw, or a detachment
   from the intended architecture.
7. **WASM Memory & Stack Profiling:** Where does this code allocate on the heap (`Box`, `Vec`, `String`) when a
   stack-allocated or zero-copy alternative (e.g., `&str`, slices) would suffice? Identify recursive functions or deep
   call chains that threaten the WASM stack limit.

### Evidence Rules

- Every finding cites the file and line (`src/module.rs:42`) and names the code construct involved.
- Before reporting a finding, re-read the code and its callers to confirm it. Check for handling elsewhere: a caller
  that validates, a type that makes the state impossible, a test that covers the edge case. If you cannot confirm the
  finding, drop it, or mark it **Suspected** and state what must be checked.
- Report a WASM size or stack concern only when you can name the concrete construct (the generic, the `format!` call,
  the recursive function). Do not state byte sizes you have not measured.
- If a lens has no real findings, say so in one line. Do not pad a lens to fill the report.

### Phase 3: Summary and Recommendations

Based on the above analysis, provide a clear and direct summary of the architectural health of the codebase. Highlight
areas of strength and weakness in the Mental Model. Provide a prioritized list of refactoring steps to address the most
critical issues.

- [ ] **Mermaid Diagram:** A visual representation of the current module architecture: high level structural and
  behavioral diagrams.
- [ ] **Architectural SWOT:** Highlight where the Mental Model is strongest and where it collapses.
- [ ] **Refactoring Roadmap:** A developer-to-developer list of actionable steps to reach SOTA status. Include Mermaid
  diagrams for proposed architecture changes if needed. For actionable steps use Markdown checkboxes to track progress.

## Project Priorities

1. **Small WASM Size First:** The primary goal is small WASM binary size. Performance is second.
2. **Small Stack Size Second**: Optimize for low stack usage in WASM environments.
3. **Performance Third:** Optimize for speed only after size and stack considerations are met.
4. **Maintainability** and code clarity are important but secondary to the above goals.

> - Keep in mind that some architecture decisions that may seem to increase cognitive load or add complexity could be
    justified if they significantly reduce WASM size or stack usage.
> - Always consider the trade-offs in the context of the project priorities.

## Strict Constraints (WASM Focus)

Do NOT suggest standard SOTA patterns if they introduce binary bloat. Specifically:

- **No Heavy Error Handling:** Do not suggest `anyhow` or `eyre`. Expect and evaluate lightweight, custom `enum` error
  types.
- **Monomorphization Awareness:** Flag excessive use of generics or large trait objects (`dyn Trait`) that duplicate
  code or inflate the vtable.
- **Formatting Bloat:** Flag usage of `format!()`, `to_string()`, or heavy `#[derive(Debug)]` implementations that leak
  into the final WASM binary.
- **Dependency Audit:** If the code uses heavy crates (e.g., `serde` without `alloc`, `regex`), suggest lightweight
  WASM-friendly alternatives.

**Output Requirements:** Developer-to-developer, direct, and skeptical. No sales fluff. If the current architecture is
fundamentally flawed, say so.
