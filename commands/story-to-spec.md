---
name: story-to-spec
description: Rewrite story document into a specification document
---

Story definition Markdown file is: `$ARGUMENTS`

This is implemented and well tested. The goal is to rewrite the story definition file into a specification document that
can be used for future reference and understanding of the feature.

1. Preserve all Markdown diagrams if they exist in the story definition file. Check if those diagrams matching the
   implementation.
2. Preserve all document tree structures (usually code files) that explain how packages and files are organized in the
   project. Update files tree structure with factual documents. There is no need to explain each document in the tree
   structure or display absolutely every document so feel free to aggregate and summarize the document tree structure to
   bring clarity.
3. Preserve "next steps", "followup", "TODO", "TBC" "open questions", "future improvements" if any exists. Aggregate
   them into two topics `## Open Questions` and `## Future Improvements` (add those topics if they do not exist)
4. Remove all completed tasks and low level implementation details from the story definition file. The specification
   document should focus on describing the feature, its purpose, and how it works. There is no need to explain already
   obvious implementation details or easily discoverable aspects from the code itself. It is well accepted that user who
   will read this spec, will need to check the actual implementation to discover low level details.
5. Check if this specification document is consistent with the actual code and architecture document. If there are any
   inconsistencies, update the specification document to reflect the actual implementation. The source of truth is the
   implementation code and test cases.
6. If there are any definitions of object models or data structures in the form of the code (`interface`, `class`,
   `type`) add links to the actual code files where those models, types or structures are defined and implemented. These
   definitions in story document where used instead of Mermaid diagrams, but now we do not need to repeat the code in
   the specification document.
7. The specification content must be clear, concise, and easy to understand and later on to maintain. You can aggregate,
   summarize and organize the content to bring clarity.
8. You do not need to preserve the log of decisions or any architect and agent dialog notes in the document. However,
   you can aggregate or move important decisions to the `## Clarifications` section if they do not fit other topics.
9. Rename the file `$ARGUMENTS` that ends with `_STORY.md` to `_SPEC.md` to indicate that it is now a specification
   document (it this was not done before).

> We're in development phase, we're not documenting any old feature. Pay attention to everywhere where we mention words
> such as 'earlier', 'previously', 'legacy', 'old' - maybe these are "documentation smell" that needs to be reviewed and
> removed.

**Specification writing principles are here, load this file:**

@~/.claude/commands/_spec-practices.md