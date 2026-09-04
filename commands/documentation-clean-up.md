---
name: documentation-clean-up
description: Cleans up the documentation files and ensures they are consistent with the current state of the codebase
argument-hint: <scope, file or directory>
---

# Documentation Clean-Up

You will review all documentation and the code comments in the specified scope and refine them to ensure they are
accurate, clear, and consistent with the current state of the codebase. The goal is to eliminate any outdated or
misleading information and to ensure that all documentation accurately reflects the functionality and behavior of the
code. The second goal is to shrink the amount of the code comments and documentation to the minimum needed to understand
the code and its functionality.

## Scope

$ARGUMENTS

## Tasks

- [ ] **Setup:**
    - [ ] Create `docs/architecture-adr.md` directory if it does not exist.

**Refine all code comments in specified scope based on following rules:**

- [ ] Refine comments in the way that they state facts verifiable from code in this file, or reference another file by
  path.
- [ ] Eliminate forbidden comments: 
  - what the code does not do; 
  - what it used to do; 
  - alternatives considered and rejected; 
  - restatements of the identifier name; 
  - anything addressed to the reviewer ("note that", "as requested", "this is deliberate").
- [ ] Move reasoning, background information, and rejected alternatives to `architecture-adr.md`.
- [ ] Eliminate duplicated information.
- [ ] Aggregate code comments if it helps to reduce the amount of text and improve clarity.

**Refine documentation in the specified scope based on following rules:**

- [ ] Rewrite documentation and comments in AECMA Simplified English, now ASD-STE100 Simplified Technical English (STE)
- [ ] Eliminate duplicated information.
- [ ] Aggregate information if it helps to reduce the amount of text and improve clarity.