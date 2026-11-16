---
name: spec-writing
description: Writing standard - Simplified Technical English for facts, labelled reasoning blocks for rationale and assumptions, fact-style headings, tables vs lists, story notation, templates. Use whenever you write or edit a story, specification, architecture document, or ADR that describes what a system does or will do. Not for documents of argument and judgment - strategy, prospect, vision, roadmap rationale, research, market or competitive analysis.
user-invocable: false
---

# Specification Writing

Stories, specifications, and architecture documents have two readers:

- **The human reviewer** scans the document. They need a predictable structure: tables, diagrams, short facts, tasks.
- **The implementing agent** reads every word and has no access to the conversation that produced the document. It
  needs the facts, the reasons behind them, the starting point, and an honest statement of what is not verified.

The standard serves both with two lanes:

- **Fact lane** - what the system does or will do. Structured, short, in Simplified Technical English. This is what
  the human scans.
- **Reasoning lane** - why, what else was considered, what is assumed, what is risky. Plain prose inside labelled
  blocks and sections (Section 5). The human can skip a block by its label; the agent reads it.

**Completeness has priority over every other rule.** The rules below decide *where* and *in what form* information
goes. They never decide that information is left out. If a rule and the content conflict - a fact needs its reason
to be understood, a value is a guess, a sentence needs 28 words to stay unambiguous - keep the content and move it to
the reasoning lane, or break the rule. A story that passes the lint but hides a reason, a caveat, or a guess from the
implementing agent has failed.

This standard is wrong for a document whose value is the argument itself - a strategy, prospect, or analysis. Do not
apply it to such a document, even if it sits next to specifications. When the user asks to *explore options* before a
design, the exploration is part of the deliverable: record it in `## Design Decisions` of the story, or in a separate
research document if it is longer than about a page.

For every Mermaid diagram, follow the `mermaid-diagrams` skill.

## Documents and Templates

| Document               | Location                     | Template                                                 |
|------------------------|------------------------------|----------------------------------------------------------|
| Story                  | `docs/feature-name-story.md` | [templates/story.md](templates/story.md)                 |
| Specification          | `docs/feature-name-spec.md`  | [templates/spec.md](templates/spec.md)                   |
| Architecture           | `docs/architecture.md`       | [templates/architecture.md](templates/architecture.md)   |
| Architecture decisions | `docs/architecture-adr.md`   | [templates/adr.md](templates/adr.md)                     |
| Open Questions section | Story, spec, or architecture | [templates/open-questions.md](templates/open-questions.md) |

- Read only the template for the document or section you write. Skip the read if the template is already in context.
- If the project has its own template for the document type, the project template has priority for section names and
  order. Add the sections of this standard that it lacks (`## Context and Gap`, `## Design Decisions`,
  `## Verification`) where they fit. Tell the user which template you used.

## Workflow

1. Read the template. Write or edit the document with the rules below.
2. Run `python3 ${CLAUDE_SKILL_DIR}/scripts/lint.py <file.md>`. It checks the fact lane: sentence and paragraph
   length, vague words, lowercase modals, When/How/Why openers, past-state words, and placeholders. It does not check
   the reasoning lane.
3. Fix each finding and run the script again. Fix a finding by rewriting or by moving the text to the reasoning lane -
   never by deleting information the implementer needs. A finding that only a loss of meaning can fix is a false
   positive: leave the text and say so in your reply.
4. Review the document against the checklist at the end. The checklist covers the rules the script cannot check.

## 1. Choose the Form

Use the most structured form that fits the content. A reader scans a table or a diagram faster than prose, and an
agent maps each row or node to code. Structure fits facts; it does not fit an argument, which is why reasoning goes
to the reasoning lane instead of into a table cell.

| Content                                                    | Form                                       |
|------------------------------------------------------------|--------------------------------------------|
| A process, workflow, or multi-step interaction             | Mermaid diagram                            |
| A structure: components, classes, dependencies             | Mermaid diagram                            |
| Items with 3 or more attributes (name, type, description)  | Table                                      |
| Comparisons and mappings (object property to table column) | Table                                      |
| Items with a name and a description                        | List: `- **Name:** description`            |
| Tasks                                                      | Checkbox list: `- [ ] Task`                |
| Questions                                                  | Numbered list                              |
| One fact or rule                                           | Sentence                                   |
| A reason, a trade-off, an assumption, a risk               | Reasoning-lane block or section (Section 5) |

- Numbering does not count as an attribute. Convert a table with only 2 meaningful columns to a list.
- If a factual explanation needs more than 2 sentences, identify what it describes: a process becomes a diagram;
  elements and their attributes become a table.
- Do not re-tell a diagram or a table in prose. Do add what the diagram or table cannot show: the reason for a
  non-obvious arrow, the constraint behind a value.
- A table cell holds a value, not an explanation. If a cell needs a reason, put a `> Rationale:` block under the table
  and name the row.

## 2. Write Simplified Technical English in the Fact Lane

- Write fact-lane text in ASD-STE100 Simplified Technical English (STE), extended with standard software engineering
  terms. STE applies to the document only, not to your reasoning or your replies to the user.
- One sentence states one fact. Aim for at most 20 words. A sentence that states a fact *and its reason* ("because",
  "so that", "therefore") may have up to 30 words - do not cut the reason to meet the limit.
- A fact-lane paragraph has at most 2 sentences. Short sentences make each fact checkable on its own.
- Use active voice and present tense: "The `RiskIndicator` computes the score."
- Use the exact technical names from the code, or the names the code will use, in backticks.
- Use one term for one concept in all related documents.
- If STE makes a sentence cryptic, write the plain sentence. Clarity has priority over the word list.

## 3. Use Precise Words in the Fact Lane

- Only components, services, functions, and people *interact*. Files, columns, and tables are *referenced*, *joined*,
  *read*, or *written*.
- State the behavior directly. Do not narrate a decision tree ("if X happens, then Y, otherwise Z"), unless the
  branching is the content, such as a state machine. Then use a diagram.
- Do not use vague words: "basically", "kind of", "sort of", "a little bit", "somewhat", "maybe", "probably", "thing",
  "stuff", "plumbing", "glue", "etc.".
- Do not use lowercase "should", "could", or "might" to describe behavior. For requirements, use the uppercase RFC 2119
  keywords `MUST`, `MUST NOT`, `SHOULD`, `MAY`.
- **Never state a guess as a fact.** The ban on hedging words is a ban on vague writing, not on uncertainty. A value
  you chose without evidence, a name you recall but did not check, an approach you did not test: write it as a fact
  and attach an `> Assumption:` block that says what is unverified and how to verify it (Section 5).

## 4. Write Headings as Facts

No heading and no first sentence of a fact-lane paragraph starts with **When**, **How**, or **Why**. These framings
describe a question, not a fact. Lead with the actor and the action: **WHO does WHAT**.

| Avoid                                            | Prefer                                                                 |
|--------------------------------------------------|------------------------------------------------------------------------|
| "How the TypeScript and SQL files interact"      | "Component interaction between the API layer and the risk schema"      |
| "When a Risk Indicator computes a score"         | "The Risk Indicator computes a score by..."                            |
| "Why a Risk Indicator does not write its result" | "The Risk Indicator delegates result persistence to the Result Writer" |

## 5. Keep the Reasoning - in the Reasoning Lane

The implementing agent was not in the conversation. A decision without its reason gets undone by the next agent that
finds a "better" approach; a guess stated as a fact gets built on. Record reasoning - in marked places, so the
reviewer can skip it.

### Labelled blocks

A block is a Markdown quote that starts with a label. Put it directly under the fact, table, or diagram it belongs to.
Inside a block, write normal prose: no sentence limit, hedging and past tense are allowed, be as long as the content
needs and no longer.

| Label              | Content                                                                                             |
|--------------------|-----------------------------------------------------------------------------------------------------|
| `> Rationale:`     | The reason for the fact above it, and what goes wrong if the fact is changed.                       |
| `> Assumption:`    | What is not verified, why you believe it, and the command, file, or URL that verifies it.           |
| `> Context:`       | The existing code or behavior the fact builds on or replaces, with file paths.                      |
| `> Risk:`          | What can fail in the implementation, and the fallback.                                              |
| `> Source:`        | The link or file a non-obvious external fact comes from (a vendor API, a version, a licence change). |
| `> Clarification:` | A kept explanation from an architect answer.                                                        |

```markdown
| Minimum version | IntelliJ Platform 2025.3 |

> Rationale: the LSP API is part of the free unified distribution from 2025.3. Before that it needed a paid IDE, so
> a lower minimum would lock out Community users.
> Source: https://blog.jetbrains.com/platform/2025/09/...

- The plugin registers an `LspServerSupportProvider`.

> Assumption: the extension-point name is from memory. Check it against the LSP page of the IntelliJ Platform SDK
> docs for the target version before writing `plugin.xml`.
```

### `## Design Decisions` (stories)

Every non-obvious choice in a story has an entry: the architecture, a rejected option the user proposed or an agent
would reach for, a value that looks arbitrary. Number the entries so tasks and open questions can refer to them.

```markdown
### D1: The browser hosts call the `LanguageService` in process

- **Decision:** what is chosen, as a fact.
- **Reason:** the forces and evidence. Prose, as long as needed.
- **Rejected:** `<alternative>` - why it lost, and what would make it win.
- **Revisit if:** the condition that invalidates the decision. (optional)
```

- When the story is implemented, move each decision that constrains future changes to `docs/architecture-adr.md` with
  the ADR template. Create the ADR file if it does not exist.
- Specifications and architecture documents do not have `## Design Decisions`. They link to the ADR and use
  `> Rationale:` blocks for short local reasons.

### `## Context and Gap` (stories)

A story describes the target, but the agent starts from the code as it is. State the starting point where it matters:
which existing files hold related behavior, what they lack, what moves or is replaced. Use a table of
`Existing | State today | Change` where there are 3 or more items. Past tense is allowed here.

### What still does not belong in the document

- The author's process: steps tried, dead ends without a lesson, notes to the reviewer, "this is deliberate".
- Discussion of a decision that is already recorded - one entry in `## Design Decisions`, not a retelling in each
  section.
- In specifications and architecture documents: past behavior. Record removed behavior in an ADR entry. Words such as
  "previously", "legacy", "old", "deprecated" mark text to move there.
- What something does *not* do, unless the absence is a contract or a decision: "The endpoint does not retry on 4xx
  responses" is a contract. "The browser hosts do not run an LSP server" is a decision - keep it and give it a
  `> Rationale:` or a `D` number.

### Dedicated sections

- `## Limitations` - known constraints and deliberate scope boundaries, each with its cause.
- `## Future Improvements` - follow-up work.
- `## Clarifications` - facts that answer a question the reader will ask.
- `## Open Questions` - unresolved gaps. Each option states its trade-off. Mark your recommended option and give the
  reason. An open question the agent can proceed without says which option the story assumes.

Do not copy implementation code into specifications. Link to the file that defines a type or model. Stories are the
exception: they define planned TypeScript APIs as interfaces (Section 6).

## 6. Story Notation

- `> Todo:` - planned work that is not yet written or decided in detail.
- `## Open Questions` - anything unresolved: gaps, inconsistencies, decisions the architect must make.
- Use only these two placeholder formats. Do not use `TODO`, `TBC`, or HTML comments such as `<!-- TODO -->`.
- `> Architect notes:` - notes from the architect to the agent. Delete them when addressed or no longer relevant.
- The reasoning-lane labels of Section 5.
- `- [ ]`, `- [x]` - task checkboxes. Every story topic that needs implementation has a brief checkbox task list to
  track progress. A task that depends on a decision or an assumption names it: "(D2)", "(see Assumption in IDE
  integrations)".
- TypeScript component APIs are defined as TypeScript interfaces and types, with a comment for each member:

```typescript
interface MyNewComponent {
    setName(name: string): boolean; // description of the method
    name: string; // description of the property
}
```

## Checklist

- [ ] An agent with only this document and the repository can implement it without the conversation. Nothing the
  user was told in chat is missing from the document.
- [ ] Each non-obvious decision has its reason and its rejected alternatives (`## Design Decisions`, `> Rationale:`,
  or an ADR entry).
- [ ] Each unverified name, version, value, or approach has an `> Assumption:` block. Each external fact has a
  `> Source:`.
- [ ] A story states the starting point in `## Context and Gap`.
- [ ] `scripts/lint.py` exits with 0, or each remaining finding is a false positive that you reported.
- [ ] Each process has a diagram. Each list of items with 3 or more attributes is a table. No prose re-tells a diagram
  or a table.
- [ ] Each technical name matches the code. One term names one concept.
- [ ] Reasoning is in the reasoning lane, not mixed into fact sentences or table cells. The fact lane still reads
  as a complete outline when every quote block is skipped.
- [ ] The document follows its template.
- [ ] Every Mermaid diagram passes the `mermaid-diagrams` checklist and validation script.
