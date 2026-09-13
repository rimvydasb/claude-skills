---
name: story-finalize
description: Polishes one or more related technical design documents (architecture, schema, API specs) for final sign-off - removes cross-document duplication and imprecise wording, validates Mermaid diagrams, and enforces a consistent structure. An editing pass on existing content, not first-draft writing.
argument-hint: <design documents to finalize>
disable-model-invocation: true
---

# Story Finalize

Documents: `$ARGUMENTS`

Polish a set of related technical documents into a final, professional design artifact. This is an editing pass, not a
drafting pass — the technical content already exists; the job is to remove noise, fix tone, and enforce consistency.

If only one document is involved, apply the same rules but skip Fix 1.

## Process

1. Read all referenced documents fully before editing any of them. Cross-document duplication can't be found by reading
   one file at a time.
2. Build a mental (or scratch) map of which concept is explained in which document — this is your source of truth for
   Fix 1.
3. Apply the fixes below in order: structure → content scope → wording → diagrams. Removing out-of-scope content before
   fixing wording avoids rework, since removed sections take their flawed headings and sentences with them.
4. Do a final read-through against the Verification Checklist before returning the result.

## Fix 1 — Cross-document duplication and inconsistency

- If a concept is explained in full in one document and referenced in another, keep the full explanation in exactly one
  place and replace the duplicate with a short reference (e.g. "See §3.2 in risk-service-architecture.md for the retry
  policy").
- Do not duplicate a definition, a flow description, or a table across documents just because both documents touch the
  topic. Pick the document where the concept structurally belongs (schema doc owns schema, architecture doc owns
  flow/components) and reference from the other.
- Do not over-trim: if removing the duplicate would force the reader to jump documents mid-explanation to understand a
  single flow, keep a one-sentence summary plus the reference.
- Fix inconsistencies between the documents where you have enough context to resolve them confidently (e.g. a field name
  that doesn't match between schema and architecture doc, a component name used two different ways). If you're not
  confident which version is correct, leave a `<!-- TODO: confirm X vs Y -->` comment instead of guessing.

## Fix 2 — Content scope

Apply Section 5 of the `spec-writing` standard (Describe the Current State Only). Remove narration of rejected
alternatives, deferred features, and what something does not do. Consolidate material worth preserving into the
`## Limitations`, `## Future Improvements`, `## Clarifications`, and `## Open Questions` sections.

## Fix 3 — Form, wording, and headings

Apply Sections 1-4 of the `spec-writing` standard: convert prose to tables, lists, or diagrams; rewrite text in STE with
precise words; rewrite headings and paragraph openers as **WHO does WHAT**.

## Fix 4 — Diagrams

- Apply the `mermaid-diagrams` standard. Any section that describes a workflow, process flow, or multi-step interaction
  — whether or not it uses the literal word "workflow" — has a diagram.
- Every diagram is self-descriptive: a reader understands the flow from the diagram alone.
- Run the `mermaid-diagrams` validation script on every document. Don't assume a diagram is valid because it was valid
  in a previous version of the doc — edits to surrounding text sometimes get copy-pasted into diagram labels.

## Verification checklist (run before returning the result)

- [ ] No concept is fully explained in more than one document; cross-references used instead.
- [ ] Any unresolved inconsistency between documents is marked with a `TODO` comment rather than silently guessed.
- [ ] The `spec-writing` checklist passes for every document.
- [ ] The `mermaid-diagrams` checklist passes, and the validation script exits with `0` for every document.

---

**Writing and diagram standards:**

@~/.claude/skills/spec-writing/SKILL.md

@~/.claude/skills/mermaid-diagrams/SKILL.md
