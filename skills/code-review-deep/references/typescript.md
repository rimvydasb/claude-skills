# TypeScript / JavaScript Review Checks

Apply these checks in addition to the general lenses of `code-review-deep`.

## Architecture and Design

- Patterns and anti-patterns present.
- Modularity and separation of concerns violations.
- Coupling and cohesion issues across module boundaries.
- Opportunities to improve readability, testability, and maintainability by introducing abstractions, splitting or
  merging modules, or reorganizing code structure.

## Enforcement vs. Hope

- Invariants that discriminated unions, `readonly`, branded types, or constructor validation could enforce instead of
  runtime checks or comments.
- `any`, unchecked `as` casts, and non-null assertions (`!`) that bypass the type system.

## Code Quality

- Current TypeScript best practices; flag anti-patterns and outdated practices.
- Naming conventions for variables, functions, modules, and files.
- Modern idiom gaps: prefer `const`, optional chaining (`?.`), nullish coalescing (`??`), `async/await` over raw
  `.then()` chains, destructuring.
- Do not use single-letter variables, except in narrow cases such as iterators or mathematical formulas. Even then,
  prefer descriptive names.
- Do not use abbreviations in names unless they are widely understood (`id`, `url`, `config`). Prefer clarity to
  brevity.
- Do not use an underscore prefix for private fields or functions. Use the `private` keyword, or do not export them.
- Comment style is consistent across the module.

## Testability

- Use Glob to locate test files adjacent to or named after the module (including `__tests__/` folders). If none exist,
  flag the module as untested.
- Functions that mix logic with I/O, state mutation, or external calls: suggest extracting the logic into a pure
  function.
- Dependencies instantiated inside functions (`new X()`, `require()` inside a function body, module-level singletons):
  flag as injection candidates.
- Module-level variables or closures that accumulate state across calls: flag as hidden coupling.
