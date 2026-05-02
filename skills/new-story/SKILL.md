---
name: new-story
description: Creates the new story file for the new feature
---

Analyze the following user story definition:
{{input}}

1. Create thew new story file under `docs/` with the name `NEW_FEATURE_STORY.md` where instead of NEW_FEATURE you will
   use the name of the feature in uppercase and with underscores instead of spaces.
2. Check existing `ARCHITECTURE.md` document - it could be that this story will require to update the architecture
   document with new components, services, or interactions.
3. Perform the necessary updates to the `ARCHITECTURE.md` document if needed, ensuring that all new components,
   services, and interactions are accurately represented in the structural and behavioral diagrams.
4. At the bottom of this story document write down the plan using the template below. You can split the implementation
   in phases if needed, but each phase must be complete in the terms that after each phase all tests passes and
   application can be started.

```text
# Story Name

## Summary

## Technical Breakdown

### Structural Diagram (optional)

### Behavioral Diagram (optional)

## Out of Scope (optional)

## Tasks

**Phase 1:**

- [ ] Ensure project compiles and existing tests are passing
- ...
- [ ] Mark all checkboxes as done in this document once verified

**Phase 2:**

- [ ] ...
- ...
- [ ] Mark all checkboxes as done in this document once verified

**Phase X:**

- [ ] Update required documentation after the implementation is complete
- [ ] Ensure new tests are added for the new feature and all tests are passing
- [ ] Perform linting and formatting to maintain code quality and consistency
- [ ] Review the implementation to ensure it meets the requirements and follows best practices
- [ ] Mark all checkboxes as done in this document once verified
```

---

**Tips while writing a story:**

- Use Mermaid diagrams if needed
- If the story is about changing structure, add a structural diagram
- If the story involves changing the sequence of actions, add a behavioral diagram
- You're allowed to say that you do not know something if you're unsure
- At the end of the story, add open questions as `## One Questions` if there are major concerns about the success of the
  story