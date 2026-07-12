---
name: story-to-spec
description: Rewrite story document into a specification document
---

Story definition Markdown file is: `$ARGUMENTS`

This story should be already implemented and well tested. The goal is to rewrite the story definition file into a
specification document that can be used for future reference and understanding of the feature.

1. Preserve all Markdown diagrams if they exist in the story definition file. Check those diagrams and make sure they
   are matching the implementation.
2. Preserve all document tree structures that explain how packages and files are organized in the project. Check those
   structures and make sure they are matching the implementation.
3. Remove all completed tasks and low level implementation details from the story definition file. The specification
   document should focus on describing the feature, its purpose, and how it works.
4. Check if this specification document is consistent with the actual code and architecture document. If there are any
   inconsistencies, update the specification document to reflect the actual implementation.
5. If there are any definitions of object models or data structures in the form of the code, add links to the actual
   code files where those models or structures are defined and implemented.
6. Rename the file `$ARGUMENTS` that ends with `_STORY.md` to `_SPEC.md` to indicate that it is now a specification
   document.

> We're in development phase, we're not documenting any old feature. Pay attention to everywhere where we mention words
> such as 'earlier', 'previously', 'legacy', 'old' - maybe these are "documentation smell" that needs to be reviewed and
> removed.