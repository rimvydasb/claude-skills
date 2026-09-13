---
name: new-architecture
description: Analyzes the current repository and creates docs/architecture.md covering functionality, technology stack, system view, data structures, persistence, API layer, and repository structure, with Mermaid diagrams. Use when a project has no architecture document and the user asks to create one.
---

## Task Description

Analyze the current repository and project state, and create a comprehensive architecture document
`docs/architecture.md`.

If `docs/architecture.md` already exists, do not overwrite or modify it. Stop and tell the user; the existing document is
refined with `/architecture-refine`.

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

- Before starting, read `README.md` and `copilot-instructions.md` if these documents exist. Also read `CLAUDE.md` or
  `AGENTS.md` if they exist to become familiar with the project.
- Use Mermaid diagrams where applicable to illustrate the architecture, data flow, or any other relevant aspect of the
  system. Use the best UML and Mermaid diagram practices to ensure clarity and readability. Avoid high level
  abstractions where possible and stay grounded in the real component and entity names.
- Use the `tree` command to generate the repository structure and include it in the "Repository Structure" section.
  Stay brief and highlight only important folders and files.
- No fluff, no commercial pitch; stay grounded and technical. The document must be useful for a new developer joining
  the project, so include details that help them understand the architecture and navigate the codebase. Stay brief:
  readers are highly technical.
- Use the best Markdown practices. Use stars `**` only for bolding and minus `-` for bullet points and lists where
  needed.
