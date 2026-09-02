---
name: documentation-clean-up
description: Cleans up the documentation files and ensures they are consistent with the current state of the codebase
argument-hint: <scope, file or directory>
---

# Documentation Clean-Up

## Scope

$ARGUMENTS

## Tasks

- [ ] Refine all documentation and code comments in specified scope based on following rules:
    - [ ] Refine comments in the way that they state facts verifiable from code in this file, or reference another file
      by path.
    - [ ] Eliminate forbidden comments: what the code does not do; what it used to do; alternatives considered and
      rejected; restatements of the identifier name; anything addressed to the reviewer ("note that", "as requested",
      "this is deliberate").
    - [ ] Move rationale, benchmarks, and rejected alternatives to docs/adr/. The code links to the ADR; it does not
      summarise it.
- [ ] Rewrite documentation and comments in AECMA Simplified English, now ASD-STE100 Simplified Technical English (STE)