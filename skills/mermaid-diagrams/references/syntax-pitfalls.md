# Syntax Pitfalls

Read this before writing a label that contains punctuation, and whenever the validation script reports an error you
cannot explain.

| Pitfall                                              | Broken                       | Fixed                                                                              |
|------------------------------------------------------|------------------------------|------------------------------------------------------------------------------------|
| Parentheses or brackets inside a node label          | `A[compute(x)]`              | `A["compute(x)"]`                                                                  |
| Double quotes inside a quoted label (silent)         | `A["say "hi""]`              | `A["say #quot;hi#quot;"]`                                                          |
| Lowercase `end` as a node id                         | `A --> end`                  | `A --> End`                                                                        |
| Node id starts with `o` or `x` after a link (silent) | `A---oRisk` (draws a circle) | `A--- oRisk` or `A---Risk`                                                         |
| Semicolon in a sequence message                      | `A->>B: save; commit`        | `A->>B: save#59; commit`                                                           |
| Block without `end`                                  | `alt valid` ... (no `end`)   | Close every `subgraph`, `alt`, `opt`, `loop`, `par`, `critical`, `rect` with `end` |
| Angle-bracket generics in a class diagram (silent)   | `List<String> items`         | `List~String~ items`                                                               |
| Stereotype in `<<>>` in a flowchart label (silent)   | `A["<<container>>"]` (renders `<>`) | `A["«container»<br>orders-api"]`                                          |
| Edge to a subgraph without an id                     | `subgraph API Layer`         | `subgraph api["API Layer"]`, then `api --> B`                                      |

A pitfall marked `(silent)` parses successfully and renders wrongly, so the validation script cannot catch it. Check
those by reading the diagram source.

`<<...>>` is valid in a `classDiagram`, where `<<interface>>` renders as `«interface»`. It is not valid in a
`flowchart`: the renderer treats `<container>` as an HTML tag and drops it.
