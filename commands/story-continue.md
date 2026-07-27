---
name: story-continue
description: Assist the architect to refine and complete the story
---

# Story refinement and continuation

Story (or new specification) definition Markdown file: $ARGUMENTS

General project information is stored in the ARCHITECTURE.md and README.md files.

## Tasks:

1. Analyze the story in $ARGUMENTS to gaps and inconsistencies. Update the document if small gaps or inconsistencies are
   found. If the gaps or inconsistencies are significant, add them to the "Open Questions" section. Create "Open
   Questions" section if it does not exist.
2. Find all "Todo", "TODO", "TBC" placeholders. Assist the architect in completing those gaps that are marked by these
   placeholders.

## General specification writing principles:

1. Prioritize Mermaid diagrams over textual descriptions if possible. If the story is about changing structure, add a
   structural
   diagram. If the story is about changing behavior, add a behavioral diagram.
    - Low level behavioral flow is defined using sequence diagrams. Sequence diagram uses components as actors and
      functions as actions.
    - High level behavioral flow is defined using flowcharts. Flow chart boxes are high level components. You can use
      boundaries to show isolated systems or even higher level components.
    - Low level structural diagram is defined using class diagrams. Class diagram uses real classes and fields. Use
      boundaries to show packages or namespaces.
    - High level structural diagram is defined using component diagrams. Component diagram uses high level components
      and
      their dependencies. Use boundaries to show isolated systems, namespaces, packages or even higher level components.
2. Prioritize Markdown tables where you need to describe a list of items with more than 2 attributes (numbering does not
   count). Use tables instead of bullet or number lists if you need to describe more than 2 attributes for each item,
   for example name, value and description (3 attributes). If you find a table that has 2 meaningfull attributes,
   convert it to the numbered or bullet list.
3. For simple listing and describing components, use bullet lists. Use bullet lists instead of tables if you need to
   describe 2 or fewer attributes for each item.
4. TypeScript component API is defined directly within TypeScript by defining TypeScript interfaces and types. For
   example:

```typescript
interface MyNewComponent {
    setName(name: string): boolean; // description of the method
    name: string; // description of the property
    // ...
}
```

5. Do not mention `previously it was`, `in the past we used, to` or `is carried over unchanged` in the story definition.
   The story definition is about the current state and the future state, not about the past.
   Catch words such as `legacy`, `old`, `deprecated` - they are not allowed, and it is possible we do not need such an
   information. However, in final comment it is good if you mention what you changed, but in the spec, you must
   concentrate in the future state.

## Markdown special notation:

- `> Todo:` - indicates a task that needs to be done.
- `> Architect notes:` - indicates architect notes or comments for you to pay attention to. If not relevant or
  mitigated, you can delete them.
- `[ ]`, `[x]` - indicates a checkbox for a task that needs to be done. All tasks that needs to be done must use
  checkboxes to track the progress. Each new specification or story topic better have very brief tasks lists with
  checkboxes that can help us to indicate if the following story topic is implemented.

# Notes

1. Note that the architect might not be aware of the alternative solutions. If you know a better architectural pattern,
   a better and clearer mental model that we can follow, please propose it to the architect.
2. Note that the architect, who writes the story definition, might not be aware of all the best practices. Also, know
   that the architect works in a narrow domain and might not be familiar with the best industry practices. Please advice
   architect if you found these gaps.
3. The goal is to make this story definition file as clear and consistent as possible, so that the implementation can be
   done without any confusion or misunderstandings and successfully as planned.
4. You are allowed to be critical and point out any inconsistencies or gaps you find - the author will be very glad if
   you correct him where really needed, for the sake of the story's success. Do not blindly agree with the architect
   ideas.
5. Note that we’re in the development phase; we do not have any obligation to maintain backward compatibility, and we’re
   allowed to make architectural changes if they're backed by a good reason.

---

Template:

## Open Questions

1. **Short title of the inconsistency or gap**: detailed description of the inconsistency or gap.
   Question to address: question that must be answered to resolve the inconsistency or gap.
   Option 1: possible way to resolve the inconsistency or gap.
   Option 2: another possible way to resolve the inconsistency or gap.
2. ...