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
      and their dependencies. Use boundaries to show isolated systems, namespaces, packages or even higher level
      components.
2. Prioritize Markdown tables where you need to describe a list of items with more than 2 attributes (numbering does not
   count). Use tables instead of bullet or number lists if you need to describe more than 2 attributes for each item,
   for example name, value and description (3 attributes). If you find a table that has 2 meaningfull attributes,
   convert it to the numbered or bullet list.
3. For simple listing and describing components, use bullet lists. Use bullet lists instead of tables if you need to
   describe 2 or fewer attributes for each item.
4. Do not mention `previously it was`, `in the past we used, to` or `is carried over unchanged` in the story or
   specification definition. The specification definition is about the current state, not about the past. Catch words
   such as `legacy`, `old`, `deprecated` - they are "specification smell", and it is possible we do not need that
   information.