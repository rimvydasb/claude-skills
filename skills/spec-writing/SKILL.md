---
name: spec-writing
description: Writing standard for stories, specifications, architecture documents, and ADRs - Simplified Technical English, precise wording, fact-style headings, tables vs lists, current-state-only content, story notation, and document templates. Use whenever you write or edit a story, specification, architecture document, or architecture decision record.
user-invocable: false
---

# Specification Writing

Stories, specifications, and architecture documents describe what the system does. The readers are engineers and
implementing agents. They need facts they can build or verify against, with the minimum amount of text.

For every Mermaid diagram, follow the `mermaid-diagrams` skill (`~/.claude/skills/mermaid-diagrams/SKILL.md`).

## Documents and Templates

| Document               | Location                        | Template                                                     |
|------------------------|---------------------------------|--------------------------------------------------------------|
| Story                  | `docs/FEATURE_NAME_STORY.md`    | `templates/story.md`                                         |
| Specification          | `docs/FEATURE_NAME_SPEC.md`     | `templates/spec.md`                                          |
| Architecture           | `docs/architecture.md`          | Defined by the `new-architecture` skill                      |
| Architecture decisions | `docs/architecture-adr.md`      | `templates/adr.md`                                           |
| Open Questions section | Story, spec, or architecture    | `templates/open-questions.md`                                |

- Templates are in `~/.claude/skills/spec-writing/templates/`. Read the template before you create a document or a
  section of that type.
- `docs/architecture.md` describes approved and implemented architecture only. A story proposes changes in its
  `## Architecture Changes` section. The story's final phase updates `docs/architecture.md`.

## 1. Choose the Form

Use the most structured form that fits the content:

| Content                                                    | Form                                    |
|------------------------------------------------------------|-----------------------------------------|
| A process, workflow, or multi-step interaction             | Mermaid diagram                         |
| A structure: components, classes, dependencies             | Mermaid diagram                         |
| Items with 3 or more attributes (name, type, description)  | Table                                   |
| Comparisons and mappings (object property to table column) | Table                                   |
| Items with a name and a description                        | List: `- **Name:** description`         |
| Tasks                                                      | Checkbox list: `- [ ] Task`             |
| Questions                                                  | Numbered list                           |
| One fact or rule                                           | Sentence                                |

- Numbering does not count as an attribute. Convert a table with only 2 meaningful columns to a list.
- If an explanation needs more than 2 sentences, identify what it describes: a process becomes a diagram; elements and
  their attributes become a table.
- Do not re-tell a diagram or a table in prose.

## 2. Write Simplified Technical English

- Write in ASD-STE100 Simplified Technical English (STE), extended with standard software engineering terms.
- One sentence states one fact. A sentence has at most 20 words. A paragraph has at most 2 sentences.
- Use active voice and present tense: "The `RiskIndicator` computes the score."
- Use the exact technical names from the code, or the names the code will use, in backticks.
- Use one term for one concept in all related documents.

## 3. Use Precise Words

- Only components, services, functions, and people *interact*. Files, columns, and tables are *referenced*, *joined*,
  *read*, or *written*.
- State the behavior directly. Do not narrate a decision tree ("if X happens, then Y, otherwise Z"), unless the
  branching is the content, such as a state machine. Then use a diagram.
- Do not use vague words: "basically", "kind of", "sort of", "a little bit", "somewhat", "maybe", "probably", "thing",
  "stuff", "plumbing", "glue", "etc.".
- Do not use lowercase "should", "could", or "might" to describe behavior. For requirements, use the uppercase RFC 2119
  keywords `MUST`, `MUST NOT`, `SHOULD`, `MAY`.

## 4. Write Headings as Facts

No heading and no first sentence of a paragraph starts with **When**, **How**, or **Why**. These framings describe a
question, not a fact. Lead with the actor and the action: **WHO does WHAT**.

| Avoid                                            | Prefer                                                                 |
|--------------------------------------------------|------------------------------------------------------------------------|
| "How the TypeScript and SQL files interact"      | "Component interaction between the API layer and the risk schema"      |
| "When a Risk Indicator computes a score"         | "The Risk Indicator computes a score by..."                            |
| "Why a Risk Indicator does not write its result" | "The Risk Indicator delegates result persistence to the Result Writer" |

## 5. Describe the Current State Only

A document specifies the current behavior (in a story: the target behavior). It is not a record of the discussion that
produced it. We are in the development phase and do not document old features.

- Do not write about the past: "previously", "earlier", "in the past we used", "is carried over unchanged", "legacy",
  "old", "deprecated". These words mark text to review and usually to delete.
- Do not describe what something does *not* do, unless the absence is a contract the reader needs: "The endpoint does
  not retry on 4xx responses" is a contract; "We do not implement caching in phase 1" is discussion noise.
- Do not narrate rejected alternatives or internal reasoning. Record them in `docs/architecture-adr.md`.
- Keep material worth preserving in dedicated sections, as short bullet lists:
    - `## Limitations` - known constraints and deliberate scope boundaries.
    - `## Future Improvements` - follow-up work.
    - `## Clarifications` - decisions that fit no other section.
    - `## Open Questions` - unresolved gaps.
- Do not copy implementation code into specifications. Link to the file that defines a type or model. Stories are the
  exception: they define planned TypeScript APIs as interfaces (Section 6).

## 6. Story Notation

- `> Todo:` - a task that needs to be done.
- `> Architect notes:` - notes from the architect to the agent. Delete them when addressed or no longer relevant.
- `> Clarification:` - a kept explanation from an architect answer.
- `- [ ]`, `- [x]` - task checkboxes. Every story topic that needs implementation has a brief checkbox task list to
  track progress.
- TypeScript component APIs are defined as TypeScript interfaces and types, with a comment for each member:

```typescript
interface MyNewComponent {
    setName(name: string): boolean; // description of the method
    name: string; // description of the property
}
```

## Checklist

- [ ] Each process has a diagram. Each list of items with 3 or more attributes is a table.
- [ ] No sentence has more than 20 words. No paragraph has more than 2 sentences.
- [ ] No vague words. No lowercase "should", "could", or "might" describes behavior.
- [ ] No heading or paragraph starts with "When", "How", or "Why".
- [ ] No past-state, legacy, or rejected-alternative text outside `docs/architecture-adr.md`.
- [ ] Documents and sections follow their templates.
- [ ] Every Mermaid diagram passes the `mermaid-diagrams` checklist and validation script.
