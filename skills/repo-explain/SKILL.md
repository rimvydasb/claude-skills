---
allowed-tools: Bash, Read, Glob, Grep
argument-hint: <question about the repository>
description: Analyzes the repository and produces a Markdown explanation with Mermaid diagrams
---

You are a senior software architect. Answer the following question about this repository:

> $ARGUMENTS

## Instructions

1. **Read Basic Documents** - Find `ARCHITECTURE.md` in `docs/` or `README.md` in root to get familiar with the purpose
   of the project
2. **Explore structure first** — run `tree -L 4 --gitignore` and read `package.json` / `pom.xml` / `build.gradle` /
   `pyproject.toml` (whichever applies). Do not guess file contents.
3. **Read relevant source files** — trace from entry points to the modules that are relevant to answering the question.
   Read only what you need.
4. **Identify**:
    - Key abstractions / domain types
    - Data flow (how data enters, transforms, exits)
    - Control flow (who calls what, in what order)
    - External dependencies that matter to the question
5. **Produce a Markdown document** and save it to `docs/explain/<slug>.md` where `<slug>` is a short kebab-case
   identifier derived from the question (e.g. `how-auth-works`, `pin-type-resolution`).

## Output document structure

```
# <Question restated as a heading>

## Summary
One paragraph, plain English. What is the answer? No jargon without definition.

## Structural view (Optional)
Mermaid class or component diagram showing the key types/modules and their relationships.
Use `classDiagram` for OOP/type-heavy code, `graph LR` for module/package topology.

## Behavioral view (Optional)
Mermaid sequence or flowchart showing the runtime flow relevant to the question.
Use `sequenceDiagram` if the answer involves multiple actors/services.
Use `flowchart TD` if it is a single process with branching logic.

## Data flow (Optional)
Mermaid flowchart showing how data moves through the system. Focus on the relevant data types and transformations.

## Key files
| File | Role |
|------|------|
| `src/foo/Bar.ts` | ... |

## Design decisions & trade-offs
Bullet list. Only include decisions that are directly relevant to the question.
Not general observations.

## Open questions / gaps
If the code is unclear, incomplete, or the question cannot be fully answered from source alone — say so here explicitly.
```

## Rules

- Never hallucinate file contents. If a file is too large, read only the relevant portion.
- Mermaid diagrams must be syntactically valid. Prefer simple diagrams over complex ones.
- The document must answer the specific question — do not produce a generic repo overview.
- If the question is ambiguous, state your interpretation at the top of the Summary section.
- Save the file and confirm the path at the end.

## Handling Special Cases

### When the question is about data flow

Use Mermaid `flowcharts` to explain data flow from API to data source depending on what user asks.
Use `subgraph` for software layers

```mermaid
flowchart LR
    subgraph AL["API Layer..."]
        ...
    end

    subgraph DL["Data Layer..."]
        ...
    end

    subgraph OE["Other Layer..."]
        ...
    end

    AL1 -->|" explanation... "| DL1
```