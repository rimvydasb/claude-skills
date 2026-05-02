---
name: new-architecture
description: Creates the architecture document based on the current repository
---

## Task Description

Your goal is to analize the current repository, project state and create a comprehensive architecture document
ARCHITECTURE.md

## Template

```text
# Project Name

## Main Functionality and Use Cases

## Technology Stack

## System View

## Basic Data Structures

## Persistence Database Layer

## Routing and API Layer

## Repository Structure
```

## Instructions

- Use Mermaid diagrams where applicable to illustrate the architecture, data flow, or any other relevant aspect of the
  system. use the best UML and Mermaid diagram practices to ensure clarity and readability. Avoid high level
  abstractions where possible and stay grounded to the real component and entity names.
- Use `tree` command to generate the repository structure and include it in the "Repository Structure" section. However,
  try to stay brief and highlight only important folders and files.
- No fluf, commercial pitch, stay grounded and very technical. The document should be useful for a new developer joining
  the project, so include any relevant details that would help them understand the architecture and how to navigate the
  codebase. However, stay brief, node that readers a highly technical.
- Store ARCHITECTURE.md in docs/ARCHITECTURE.md
- Use the best Markdown practices. Use stars `**` only for bolding and minus `-` for bullet points and lists where
  needed.
- Before starting, read `README.md` and `copilot-instructions.md` if these documents exists. Also, try reading
  `CLAUDE.md` or `AGENTS.md` if exists to familiarize with the priject.