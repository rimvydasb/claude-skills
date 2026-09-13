# Specification Template

File: `docs/FEATURE_NAME_SPEC.md`. A specification describes an implemented feature: its purpose and how it works. It
omits details that are obvious or quick to find in the code; the reader checks the implementation for low-level
details. Omit optional sections that have no content.

```markdown
# Feature Name

## Summary

Purpose of the feature and the problem it solves.

## Structure

Structural diagram (component or class diagram).

File tree of the relevant packages and files. Aggregate folders; do not list or explain every file.

## Behavior

One behavioral diagram (flowchart or sequence diagram) for each workflow.

## Data Model (optional)

| Model or type | Purpose | Defined in           |
|---------------|---------|----------------------|
| `RiskScore`   | ...     | [risk.ts](../src/...) |

## Limitations (optional)

## Clarifications (optional)

## Open Questions (optional)

## Future Improvements (optional)
```
