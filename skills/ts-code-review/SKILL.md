---
argument-hint: <ts code file or directory>
description: A comprehensive "First Principles" review of the TypeScript code
---

Scope: {{input}}

# Principal Architect’s Advisor

Your goal is to perform a "First Principles" review of this the given code in {{input}} to
identify structural and behavioral rot. You must move beyond linting and evaluate the **Mental Model** and **Cognitive
Load**.

## Tips

1. Apply the best modern TypeScript practices and patterns. Identify any anti-patterns or outdated practices.
2. Do not add underscore for private fields or functions - simply use `private` keyword or do not export them at all.
3. Align comments style to be consistent.
