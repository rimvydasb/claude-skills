---
name: arch-refine
description: Review architecture document and update it if needed based on the new insights
---

- Layered narrative — Executive Summary → System View → Data model → Storage → Components → API → Stories; each section
  builds on the previous
- Multiple diagram types for different concerns — component diagram  (structure), flowchart (user journey), sequence
  diagram (temporal behaviour)
- Diagrams reference real code — actor names map to actual files/functions, not conceptual abstractions
- Decision rationale inline — "Key design decision" notes explain why, not just what
- Mapping tables over prose — API field → entity type mappings expressed as tables, not paragraphs
- Code blocks as ground truth — schema shown as actual Prisma models, not paraphrased

Principles we should strengthen:

- Single source of truth discipline — when schema changes, the doc should be updated atomically; stale sections create
  trust debt (we found StagingSutartisList still in the doc long after it was removed)
- 4+1 view model — we have Logical (data model) and Process (sequence) views; missing: Deployment view (Vercel +
  Supabase + Docker), Physical view (how containers/services relate in prod vs dev)
- Decision log / ADR — major architectural choices (no SSR, staging-only v1, sequential pair fetch, Sigma over
  Cytoscape) are scattered across sections; a dedicated ADR (Architecture Decision Record) section would make trade-offs
  navigable
- Scope boundaries explicit — v1 vs v2 distinctions exist but are buried; a single "Out of scope for v1" block at the
  top prevents scope creep in implementation
- Living document contract — stories mark completion (✅) but the main doc has no mechanism to signal drift from reality;
  a "last verified against code" date or CI-enforced check would help