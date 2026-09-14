# Architecture Decision Record Template

File: `docs/architecture-adr.md`. This is the only document that records reasoning, rejected alternatives, and past or
removed behavior. Create the file only when you have an entry to write.

- Append new entries at the end. Do not renumber or rewrite existing entries.
- To change an accepted decision, append a new entry and set the old entry's Status to `Superseded by ADR-00N`.
- The heading states the decision as a fact: **WHO does WHAT**.
- Each field has at most 3 sentences. Write one `Rejected` line for each rejected alternative; omit the field if there
  is none.
- Record removed or replaced behavior in `Context` (what existed) and `Consequences` (what is gone).

TEMPLATE STARTS:

```markdown
# Architecture Decision Record

## ADR-001: <The component does something>

- **Status:** Accepted | Superseded by ADR-00N
- **Context:** The problem or force that required a decision, and the affected components or files.
- **Decision:** The chosen approach.
- **Rejected:** `<alternative>` - reason.
- **Consequences:** The trade-offs, the follow-up constraints, and the removed behavior.
```

TEMPLATE ENDS.
