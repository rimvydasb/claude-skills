---
name: ts-code-review
description: Reviews TypeScript or JavaScript code (a file or directory) for architecture, mental model, code quality, and testability, and returns prioritized, verified findings with concrete fixes. Use when the user asks to review JS/TS code, a JS/TS module, or its testability.
argument-hint: <ts/js file or directory>
allowed-tools: Bash, Read, Glob, Grep
context: fork
---

# TypeScript / JavaScript Review

Review the code in scope for architecture, quality, and testability. Go beyond linting: evaluate the **mental model** the
code expresses and the **cognitive load** it puts on a developer. Look for what is wrong, not for what is acceptable.

The findings are read by the developers who own this code. They use them to decide what to change, so every finding must
be real, specific, and actionable.

Start the review here: `$ARGUMENTS`. Follow imports into other modules where needed to understand coupling and behavior.

## Architecture & Design

- Patterns and anti-patterns present
- Modularity and separation of concerns violations
- Coupling/cohesion issues across module boundaries
- Opportunities to improve readability, testability and maintainability by introducing new abstractions, splitting or
  merging modules, or reorganizing code structure

## Code Quality

- Current TypeScript best practices; flag anti-patterns and outdated practices
- Naming conventions (variables, functions, modules, files)
- Unnecessary complexity or indirection
- Modern JS/TS idiom gaps: prefer `const`, optional chaining (`?.`), nullish coalescing (`??`), `async/await` over raw
  `.then()` chains, destructuring, etc.
- Do not use single letter variables except in very specific cases (e.g. iterators, mathematical formulas) and even then
  prefer more descriptive names
- Do not use abbreviations in variable names unless they are widely understood (e.g. `id`, `url`, `config`), and even
  then prefer clarity to brevity
- Do not use an underscore prefix for private fields or functions. Use the `private` keyword, or do not export them
- Comment style is consistent across the module

## Testability

- Check if this module is testable and tests exist. If not, flag and suggest writing tests.
- The goal is testable but simple code - prioritize simplicity and readability over testability, but flag the code if it
  is not testable at all.
- Use Glob to locate test files adjacent to or named after this module. If none found, flag as untested.
- Functions that mix logic with I/O, state mutation, or external calls — flag them and suggest extracting the logic into
  a pure function
- Dependencies instantiated inside functions (`new X()`, `require()` inside a function body, module-level singletons) —
  flag as injection candidates
- Functions that are only testable by mocking 3+ things — treat as a design smell, suggest decomposition
- State shared across calls (module-level variables, closures that accumulate) — flag as hidden coupling

## Evidence Rules

- Every finding cites the file and line and names the function or module involved.
- Before reporting a finding, re-read the code and its usages to confirm the problem is real. A "missing null check" that
  a caller or a type already guarantees is not a finding. Drop findings you cannot confirm.
- Report only findings a senior developer on this codebase would act on. If the code has no significant problems, say
  so. Do not pad the list with minor style remarks.

## Output

Priority can be: High (brings higher value), Moderate, Low (can be skipped, nice to have fix)
Finding: location and brief problem description
Fix: specific actionable recommendation to address the finding and explanation of how it improves the code
Impact: maintenance and readability improvements, performance improvements, security improvements, etc.

Order findings by priority. Use the template below:

---
#1
**Priority:** High
**Finding:** ... (line X, function Y, module Z) ... problem description ...
**Fix:** ...
**Impact:** ...

#2
**Priority:** Moderate
...
---
