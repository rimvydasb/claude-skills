---
name: mermaid-diagrams
description: Rules for choosing, writing, and validating Mermaid diagrams in Markdown documentation (component, deployment, Kubernetes and Helm, flowchart, sequence, class, state, ER), with a script that renders every diagram in a file and reports syntax errors. Use whenever you write or edit a Mermaid diagram, or when the user asks to check or fix the diagrams in a document.
argument-hint: [ markdown file to validate ]
---

# Mermaid Diagrams

Diagrams replace prose. A reader must understand the depicted structure or flow from the diagram alone.

This file holds the rules that apply to every diagram. The notation for each diagram type lives in its own reference
document: read the one for the type you are writing, and no others.

When this skill is invoked with a Markdown file as the argument: validate the file (Section 3), read the reference
document for each diagram type the file contains, fix every error and every rule violation, and validate again until the
script reports no errors.

## 1. Choose the Diagram Type

Pick the row that matches the content, then read its document from `~/.claude/skills/mermaid-diagrams/references/`.

| Content                    | Level | Mermaid type                        | Read                             |
|----------------------------|-------|-------------------------------------|----------------------------------|
| Structure                  | High  | `flowchart` as a component diagram  | `component.md`                   |
| Structure                  | Low   | `classDiagram`                      | `class.md`                       |
| Deployment topology        | Any   | `flowchart` as a deployment diagram | `deployment.md`                  |
| Kubernetes or Helm release | Any   | `flowchart` as a deployment diagram | `deployment.md`, `kubernetes.md` |
| Behavior                   | High  | `flowchart`                         | `flowchart.md`                   |
| Behavior                   | Low   | `sequenceDiagram`                   | `sequence.md`                    |
| Lifecycle                  | Any   | `stateDiagram-v2`                   | `state.md`                       |
| Persistence data model     | Any   | `erDiagram`                         | `er.md`                          |

Read `syntax-pitfalls.md` from the same directory before writing a label that contains punctuation, and whenever the
validation script reports an error you cannot explain.

- A document that changes structure has a structural diagram. A document that changes behavior has a behavioral
  diagram.
- Every section that describes a workflow, process, or multi-step interaction has a diagram. A prose-only description
  of a multi-step process is incomplete.
- Prefer several small diagrams to one large diagram. Split a diagram that has more than 15 nodes or 20 messages.

## 2. General Rules

- Use the exact technical names from the code, or the names the code will use: `UserDatabase`, `compute()`. Do not use
  generic names such as "Service A" unless that is the real abstraction level.
- Put a heading or a one-sentence caption directly above each diagram that states what it depicts.
- A label or note has at most 1 sentence. Labels add information the shapes do not show: data element names, conditions,
  protocols.
- Do not re-tell the diagram in prose.
- Do not add colors, styles, or `%%{init}%%` themes unless a color encodes meaning. Documents render in light and dark
  themes.

## 3. Validation

Run the validation script for every document in which you created or changed a diagram:

```bash
bash ~/.claude/skills/mermaid-diagrams/scripts/validate.sh docs/file.md [more files...]
```

- The script renders every ` ```mermaid ` block with Mermaid CLI and prints `file:line` and the parser error for each
  invalid block. Exit code `0` means all diagrams are valid.
- Fix every reported error and run the script again until it exits with `0`. Do not report a diagram as valid without
  running the script.
- If the script cannot run (no Node.js, or no network for the first Mermaid CLI download), check each diagram against
  `references/syntax-pitfalls.md` and tell the user that the validation was manual.
- A valid syntax does not make a diagram correct. Check each diagram against the code: the names exist, and the calls
  happen in the depicted order.
- The script detects parse errors only. The pitfalls marked `(silent)` in `references/syntax-pitfalls.md` parse
  successfully but render wrongly; check them by reading the diagram source.

## Checklist

- [ ] Each diagram uses the type from Section 1 for its content and level.
- [ ] Each diagram follows the notation in its reference document.
- [ ] Each workflow or multi-step process has a diagram.
- [ ] Each diagram has a caption or heading, exact technical names, and labelled arrows.
- [ ] No prose re-tells a diagram.
- [ ] The validation script exits with `0` for every changed document.
