---
allowed-tools: Bash, Read, Glob, Grep
argument-hint: <start file or path to review>
description: Review a JS/TS file for architecture, quality, and testability
---

Review a JS/TS file for architecture, quality, and testability.
The goal is to maintain a high-quality codebase that is easy to understand, maintain, and extend. Your review should be
specific and actionable. Enable skeptical audit mode.

Start your review from this place: `$ARGUMENTS`.

## Architecture & Design

- Patterns and anti-patterns present
- Modularity and separation of concerns violations
- Coupling/cohesion issues across module boundaries
- Check if it is possible to improve code readability, testability and maintainability by introducing new abstractions,
  splitting or merging modules, or reorganizing code structure

## Code Quality

- Naming conventions (variables, functions, modules, files)
- Unnecessary complexity or indirection
- Modern JS/TS idiom gaps: prefer `const`, optional chaining (`?.`), nullish coalescing (`??`),
  `async/await` over raw `.then()` chains, destructuring, etc.
- Do not use single letter variables except in very specific cases (e.g. iterators, mathematical formulas) and even then
  prefer more descriptive names
- Do not use abbreviations in variable names unless they are widely understood (e.g. `id`, `url`, `config`), and even
  then prefer clarity to brevity

## Testability

- Check if this module is testable and test exists. If not, flag and suggest writing tests.
- The goal is to have testable, but simple code - prioritize simplicity and readability over testability, but flag the
  code if it is not testable at all.
- Use Glob to locate test files adjacent to or named after this module. If none found, flag as untested.
- Functions that mix logic with I/O, state mutation, or external calls — flag them and suggest extracting the logic into
  a pure function
- Dependencies instantiated inside functions (`new X()`, `require()` inside a function body, module-level singletons) —
  flag as injection candidates
- Functions that are only testable by mocking 3+ things — treat as a design smell, suggest decomposition
- State shared across calls (module-level variables, closures that accumulate) — flag as hidden coupling

## Output

Priority can be: High (brings higher value), Moderate, Low (can be skipped, nice to have fix)
Finding: location and brief problem description
Fix: specific actionable recommendation to address the finding and explanation of how it improves the code
Impact: maintenance and readability improvements, performance improvements, security improvements, etc.

Use the template below:

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