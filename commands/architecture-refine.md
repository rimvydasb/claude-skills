---
name: architecture-refine
description: Refines an architecture document in the given scope to the documentation standard - Simplified Technical English, diagrams and tables instead of prose, a component diagram as System View, Open Questions, and decisions recorded in docs/architecture-adr.md.
argument-hint: <scope, file or directory>
disable-model-invocation: true
---

# Architecture Refining and Finalisation

## Scope

$ARGUMENTS

Refine the architecture documents in scope to the `spec-writing` and `mermaid-diagrams` standards loaded below.

## Tasks

- [ ] Replace long textual explanations with diagrams, tables, or lists (`spec-writing` Section 1). A process becomes a
  flowchart (high level) or a sequence diagram (low level); elements with attributes become a table.
- [ ] Rewrite the remaining text in Simplified Technical English with precise words and fact-style headings
  (`spec-writing` Sections 2-4).
- [ ] Remove internal reasoning, legacy functionality, and old or previous behavior (`spec-writing` Section 5). Record
  each removed decision and its reasoning in `docs/architecture-adr.md` with the ADR template.
- [ ] Include a component diagram as the System View (the UML System View). Follow the component diagram notation in
  `mermaid-diagrams`. Component names are the exact technical names used by the implementation, for example
  `UserDatabase`.
- [ ] Use tables for class or object property to database column mappings, and for component property, type, and
  description declarations.
- [ ] Add `## Open Questions` at the end of the technical content, with all open questions about the architecture and
  implementation (Open Questions template).
- [ ] Validate every document in scope with the `mermaid-diagrams` validation script.

## Templates

@~/.claude/skills/spec-writing/templates/open-questions.md

@~/.claude/skills/spec-writing/templates/adr.md

---

**Writing and diagram standards:**

@~/.claude/skills/spec-writing/SKILL.md

@~/.claude/skills/mermaid-diagrams/SKILL.md
