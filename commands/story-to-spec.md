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
   them into two topics `## Open Questions` and `## Future Improvements` if they exist. Add those topics if they do not
   exist.
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

## General specification writing principles:

1. Prioritize Mermaid diagrams over textual descriptions if possible. If the story is about changing structure, add a
   structural diagram. If the story is about changing behavior, add a behavioral diagram.
   - Low level behavioral flow is defined using sequence diagrams. Sequence diagram uses components as actors and
     functions as actions.
   - High level behavioral flow is defined using flowcharts. Flow chart boxes are high level components. You can use
     boundaries to show isolated systems or even higher level components.
   - Low level structural diagram is defined using class diagrams. Class diagram uses real classes and fields. Use
     boundaries to show packages or namespaces.
   - High level structural diagram is defined using component diagrams. Component diagram uses high level components
     and their dependencies. Use boundaries to show isolated systems, namespaces, packages or even higher level components.
2. Prioritize Markdown tables where you need to describe a list of items with more than 2 attributes (numbering does not
   count). Use tables instead of bullet or number lists if you need to describe more than 2 attributes for each item,
   for example name, value and description (3 attributes). If you find a table that has 2 meaningfull attributes,
   convert it to the numbered or bullet list.
3. For simple listing and describing components, use bullet lists. Use bullet lists instead of tables if you need to
   describe 2 or fewer attributes for each item.