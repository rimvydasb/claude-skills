---
name: architecture-refine
description: Refines and finalizes the architecture document to me in align with documentation standards
argument-hint: <scope, file or directory>
---

# Architecture Refining and Finalisation

## Scope

$ARGUMENTS

## Standard

**Text:**

Where possible use AECMA Simplified English, now ASD-STE100 Simplified Technical English (STE). Everywhere where needed,
extend STE with technical software engineering terminology.

You're not allowed writing long textual explanations or text paragraphs. If a single paragraph of text has more than two
sentences and a single sentence has more than 10 words, consider changing it to Markdown table or mermaid diagram with
labels.

All architectural document must be free from internal reasoning. If needed, all reasoning can be added to
`Architectural Decisions Record`

No legacy functionality must be mentioned anywhere. No old behavior or previous functionality must be mentioned. Only
one exception is `Architectural Decisions Record` paragraph.

**Listing:**

You are allowed writing Markdown lists for:

1. Tasks - use `- [ ] Task...`
2. Elements with their descriptions - use `1. **Element:** description...`
3. Questions: `1. Question`

If you see that elements have more a

**Thinking:**

If you see that you need to explain something, and it might take or takes more than two sentences, think of what is it:
maybe you want to describe process, then use flow or sequence diagrams; maybe you want to describe elements and element
attributes, then use Markdown table.

**Diagrams:**

Prioritize Mermaid diagrams over textual explanations everywhere:

- Flow diagrams for high level process. Each Flow diagram box is a high level component that can do one and only one
  action. Flow diagram arrow must have a label with data element name.
- Sequence diagrams for low level process. Actors must be concrete components that are already implemented or should be
  implemented. Arrows represent function calls. Use labels where needed.
- All mermaid diagram notes or labels must be no longer than 1 sentence.
- Do not re-tell what is in diagram - it must be already obvious reading the diagram itself. Labels must contain
  non-obvious or additional information.

**Components Diagram:**

One of the most important diagrams is components diagram that, according UML standard, is considered to be System View.

- Use `subgraph` to show namespaces or logical groups of the components
- Use database view for persistence components
- Use solid arrows to show dependencies between components
- Use dotted arrows to show data flow between components
- All diagram arrows must have labels
- Component names must be exact technical names that will be used for the implementation, for example UserDatabase, etc.

**Tables:**

Use tables for any comparison, mappings or any descriptions of a list of elements where multiple categories (dimensions)
are involved. For example always use tables for class/object property to database table columns mappings, or component's
property, type and description declarations.

**Open Questions:**

At the end of the technical content, add `## Open Questions` block where below you will list all open questions
regarding the architecture and implementation. All questions must be listed in Markdown list.

**Architectural Decisions:**

Below the document there must be a paragraph `## Architectural Decisions Record` where you will write down a table. Type
column contains labels: DEPRECATED (was removed), REPLACED (new behavior instead of old), ADDED (completely new
behavior). Example:

| # | Type       | Before                     | Where               | Change                                             |
|---|------------|----------------------------|---------------------|----------------------------------------------------|
| 1 | DEPRECATED | What was before 1 sentence | File list, location | Reasoning or the change that as made in 1 sentence |
| 2 |            | ...                        | ...                 | ...                                                |
