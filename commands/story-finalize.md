---
name: story-finalize
description: Use this skill when finalizing technical design documents (architecture specs, schema docs, API specs) before they're considered done. Triggers on requests like "finalize this doc", "clean up this spec for final review", or "prepare this design doc for sign-off". Removes redundancy, fixes unprofessional wording, validates diagrams, and enforces a consistent structural style across a set of related documents. Not for first-draft writing — this is a polish/audit pass on existing content.
---

# Story Finalize

Polish a set of related technical documents into a final, professional design artifact. This is an editing pass, not a
drafting pass — the technical content already exists; the job is to remove noise, fix tone, and enforce consistency.

## When to use this skill

- The user references two or more related docs (e.g. an architecture doc + a schema doc) and asks to "finalize" or
  "clean up for review".
- The docs are meant to be a final design reference, not a working/discussion draft.

If only one document is involved, or the user is still actively designing (not finalizing), apply the same rules but
skip the cross-document dedup pass.

## Process

1. Read all referenced documents fully before editing any of them. Cross-document duplication can't be found by reading
   one file at a time.
2. Build a mental (or scratch) map of which concept is explained in which document — this is your source of truth for
   the dedup pass.
3. Apply the fixes below in order: structure → tone → content scope → diagrams. Fixing tone before content scope tends
   to create rework, since removed sections often take flawed headings with them.
4. Do a final read-through against the Verification Checklist before returning the result.

## Fix 1 — Cross-document duplication

- If a concept is explained in full in one document and referenced in another, keep the full explanation in exactly one
  place and replace the duplicate with a short reference (e.g. "See §3.2 in risk-service-architecture.md for the retry
  policy").
- Do not duplicate a definition, a flow description, or a table across documents just because both documents touch the
  topic. Pick the document where the concept structurally belongs (schema doc owns schema, architecture doc owns
  flow/components) and reference from the other.
- Do not over-trim: if removing the duplicate would force the reader to jump documents mid-explanation to understand a
  single flow, keep a one-sentence summary plus the reference.

## Fix 2 — Unprofessional or imprecise wording

- Only components, services, functions, or people *interact*. Files, columns, or tables do not "interact" — they are
  *referenced*, *joined*, *read*, or *written*. Rewrite any sentence that anthropomorphizes an artifact.
- Replace vague boolean/conditional narration ("if X happens, then Y, otherwise Z") with direct statements of the actual
  behavior. State what the system does; don't narrate the decision tree that got you there unless the branching itself
  is the content being documented (e.g. an actual state machine).
- Flag and fix inconsistencies between the two documents where you have enough context to resolve them confidently (e.g.
  a field name that doesn't match between schema and architecture doc, a component name used two different ways). If
  you're not confident which version is correct, leave a `<!-- TODO: confirm X vs Y -->` comment instead of guessing.
- Do not use sloppy or imprecise language like "basically", "kind of", "sort of", "a little bit", "somewhat", "maybe",
  "probably", "might", "could", "should", "plumbing", "harness", "harnessing", "glue", "thing", "stuff", "etc." - all
  these words are vague and unprofessional. Replace them with precise, factual language.

## Fix 3 — Heading and paragraph style

No heading or opening sentence of a paragraph may start with **When**, **How**, or **Why**. These framings describe a
question being answered, not a fact being stated — they read as tutorial/FAQ style, not spec style.

Rewrite to lead with the actor and the action: **WHO does WHAT**.

| Avoid                                            | Prefer                                                                 |
|--------------------------------------------------|------------------------------------------------------------------------|
| "How the TypeScript and SQL files interact"      | "Component interaction between the API layer and the risk schema"      |
| "When a Risk Indicator computes a score"         | "The Risk Indicator computes a score by..."                            |
| "Why a Risk Indicator does not write its result" | "The Risk Indicator delegates result persistence to the Result Writer" |

## Fix 4 — Scope: describe what the system does, not what it doesn't

A final design document specifies behavior. It is not a record of the design discussion that produced it.

- Remove narration of rejected alternatives, deferred features, or "we decided not to implement X" — this belongs in a
  design-discussion doc or PR description, not the final spec.
- Remove descriptions of what a function, method, or process does *not* do, unless that absence is itself a load-bearing
  contract the reader needs (e.g. "this endpoint does not retry on 4xx" is a meaningful API contract; "we're not
  implementing caching in phase 1" is discussion noise).
- If there's material that's genuinely useful to preserve (known constraints, deliberate scope boundaries), consolidate
  it into a single `## Limitations` section rather than scattering negative statements throughout the doc. Keep that
  section tight — a bullet list, not prose.

## Fix 5 — Mermaid diagram validation

- Every diagram must be checked for syntax validity, not just visually plausible. Common failure patterns to check for
  specifically:
    - Sequence diagrams: `alt`/`else`/`end` blocks must be properly closed; labels after `alt`/`opt`/`loop` must not
      contain unescaped special characters (colons, parentheses) that break the parser.
    - Node labels with special characters (`(`, `)`, `:`, `"`) must be quoted or escaped.
    - Every opened block (`subgraph`, `alt`, `loop`, `par`) has a matching `end`.
- Mentally trace or (if tooling is available) actually render each diagram before finalizing. Don't assume a diagram is
  valid because it was written correctly in a previous version of the doc — edits to surrounding text sometimes get
  copy-pasted into diagram labels.
- Every diagram must be self-descriptive: a reader should understand the flow from the diagram alone, without needing to
  read a paragraph of prose first. This means: meaningful node/actor labels (not "Service A", "Service B" unless that's
  genuinely the abstraction level), and a title or caption stating what flow is depicted.

## Fix 6 — Workflow sections require a diagram

Any section that describes a workflow, process flow, or multi-step interaction — whether or not it uses the literal word
"workflow" — must be accompanied by a Mermaid diagram (flowchart or sequence diagram, whichever fits the flow shape).
Prose-only descriptions of multi-step processes are treated as incomplete.

## Verification checklist (run before returning the result)

- [ ] No concept is fully explained in more than one document; cross-references used instead.
- [ ] No sentence attributes "interaction" to files, columns, or tables — only to components/services.
- [ ] No heading or paragraph opens with "When", "How", or "Why".
- [ ] No prose describes rejected alternatives or what something does *not* do, except inside a single, concise
  `## Limitations` section (if needed) or where the negative is a real behavioral contract.
- [ ] Every Mermaid diagram has been traced for syntax correctness (matched blocks, escaped special characters).
- [ ] Every Mermaid diagram is understandable without a prose walkthrough.
- [ ] Every workflow/process description has an accompanying diagram.
- [ ] Any unresolved inconsistency between documents is marked with a `TODO` comment rather than silently guessed.

**Specification writing principles are here, load this file:**
@~/.claude/commands/_spec-practices.md