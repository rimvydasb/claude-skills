---
name: docs-refine
description: Refines one or more documentation files (stories excluded) - architecture documents, specifications, schema and API docs - to the documentation standard. Removes cross-document duplication, past-state text, and imprecise wording, converts prose to diagrams and tables, moves decisions to docs/architecture-adr.md, and validates Mermaid diagrams. An editing pass on existing content, not first-draft writing.
argument-hint: <documents, or a directory of documents>
disable-model-invocation: true
---

# Documentation Refine

Documents in scope: `$ARGUMENTS`

Refine the documents in scope into final, professional design documents. This is an editing pass, not a drafting pass:
the technical content already exists. The job is to remove noise, fix wording, and enforce consistency.

Load the `spec-writing` and `mermaid-diagrams` skills before you edit, unless they are already loaded in this session.

Edit only Markdown documents in scope. Do not change code or code comments; use `/documentation-clean-up` for those.

## Process

1. Read all documents in scope fully before you edit any of them. Cross-document duplication is not visible one file at
   a time.
2. Build a map of which concept is explained in which document. This map is the source of truth for Fix 1.
3. Apply the fixes in order: structure → content scope → wording → diagrams. Content removed early takes its flawed
   headings and sentences with it, so wording fixes are not wasted.
4. Apply the conditional fixes that match the documents in scope.
5. Run the Verification Checklist before you return the result.

## Fix 1 - Cross-Document Duplication and Inconsistency

Skip this fix when the scope contains one document.

- Keep the full explanation of a concept in exactly one document. Replace each duplicate with a short reference, for
  example "See §3.2 in `risk-service-architecture.md` for the retry policy".
- Put a concept in the document where it structurally belongs: the schema document owns the schema, the architecture
  document owns components and flows.
- Do not over-trim. If removing a duplicate forces the reader to switch documents in the middle of one flow, keep a
  one-sentence summary and the reference.
- Fix inconsistencies (a field name that differs between documents, a component with two names) when the code or the
  documents show which version is correct. Otherwise, add an item to `## Open Questions`. Do not guess.

## Fix 2 - Content Scope

Apply `spec-writing` Section 5 (Describe the Current State Only):

- Remove past-state text, narration of what something does not do, and discussion noise.
- Sort each piece of reasoning with the Section 5 rule: a decision that constrains future changes goes to
  `docs/architecture-adr.md` as an ADR entry; deferred work goes to `## Future Improvements`; the author's own thinking is
  deleted.
- Create `docs/architecture-adr.md` only when you have an entry to write.

## Fix 3 - Form, Wording, and Headings

Apply `spec-writing` Sections 1-4:

- Convert prose to diagrams, tables, or lists. A process becomes a flowchart (high level) or a sequence diagram (low
  level); elements with attributes become a table.
- Use tables for class or object property to database column mappings, and for component property, type, and description
  declarations.
- Rewrite the text in Simplified Technical English with precise words.
- Rewrite headings and paragraph openers as **WHO does WHAT**.

## Fix 4 - Diagrams

- Apply the `mermaid-diagrams` standard. Every section that describes a workflow, process, or multi-step interaction has
  a diagram, whether or not it uses the word "workflow".
- Every diagram is self-descriptive: a reader understands the flow from the diagram alone.
- Run the validation script on every document in scope. Do not assume a diagram is valid because it was valid before:
  edits to the surrounding text sometimes leak into diagram labels.

## Conditional Fixes - Architecture Documents

Apply to `docs/architecture.md` and to documents under `docs/architecture/`:

- [ ] The document has a `## System View` with a component diagram. Follow the component diagram notation in
  `mermaid-diagrams`. Component names are the exact technical names used by the implementation, for example
  `UserDatabase`.
- [ ] The document ends its technical content with `## Open Questions` (template below), with all open questions about
  the architecture and the implementation.

## Verification Checklist

- [ ] No concept is fully explained in more than one document; cross-references are used instead.
- [ ] Each unresolved inconsistency is an item in `## Open Questions`, not a guess.
- [ ] The `spec-writing` checklist passes for every document.
- [ ] The `mermaid-diagrams` checklist passes, and the validation script exits with `0` for every document.

## Templates

@~/.claude/skills/spec-writing/templates/open-questions.md

@~/.claude/skills/spec-writing/templates/adr.md
