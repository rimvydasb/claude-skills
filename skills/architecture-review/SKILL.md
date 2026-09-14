---
name: architecture-review
description: Principal-level review of a whole system's architecture for over-engineering, redundant services, containers, and datastores, unclear use-case decomposition, and misplaced responsibilities, judged against what the product actually needs. Writes docs/architecture/<scope-slug>_REVIEW.md with current and target diagrams and a simplification roadmap. Use when the user asks for an architecture review, asks whether a system is over-engineered or too complex, or wants the system decomposed by use case. For a code-level review of a module, use code-review-deep.
argument-hint: [ scope or focus question ]
context: fork
allowed-tools: Read, Glob, Grep, Write, Bash(git log:*), Bash(tree:*), Bash(rg:*), Bash(wc:*), Bash(docker compose config:*), Bash(bash ~/.claude/skills/mermaid-diagrams/scripts/validate.sh:*)
---

# Architecture Review

Act as a principal software architect. Review the system in scope and decide whether its architecture fits what the
product needs.

The report is read by the owners of the system. They build with agentic development and may not have formal software
engineering training. Agentic development tends to add layers, duplicate abstractions, and infrastructure the product
does not need. For each finding, name the principle involved and the concrete cost the owners pay for the problem.

## Scope

$ARGUMENTS

If the scope is empty, review the whole repository. If the scope is a question, answer it explicitly in the Verdict.

Do not modify code or architecture documents. Only write the report.

## Step 1: Establish the Product Needs

Read `README.md`, `docs/architecture.md` (or `docs/architecture/`), and `CLAUDE.md` or `AGENTS.md`. Record the needs
that justify architecture: users and their number, core use cases, data volume, deployment target (a laptop, a single
server, a cloud), team size, and availability expectations.

- Cite the source of each need. Mark a need without a source as `Assumption`.
- Judge every later finding against these needs, not against a generic enterprise ideal.

## Step 2: Map the Current System from the Code

Build the inventory from the code and configuration, not from documents:

- Deployables: containers, images, processes, serverless functions. Sources: compose files, Dockerfiles, CI workflows.
- Datastores, caches, queues, and external services.
- Workspaces, packages, and crates, with their dependency direction.
- Entry points for each core use case.

When a document and the code disagree, the code is the fact; report the disagreement as a finding.

## Step 3: Review Through the Lenses

1. **Proportionality:** For each deployable, datastore, cache, queue, and layer: which need requires it, and what breaks
   if it is removed? Typical findings: separate frontend and backend images for a single-user app, a cache or broker
   without a measured need, service boundaries for a one-person team.
2. **Redundancy:** Parallel implementations of one concept: two database wrappers, copied tables or views for one
   consumer, context objects that duplicate a single state value, duplicated configuration.
3. **Use-Case Decomposition:** Each core use case has one owning module. Modules are named by the domain, not by the
   technology. Shared capabilities (for example a query service) are dependencies, not copies. Flag use cases spread
   across many modules and modules that serve no use case.
4. **Boundaries and Dependency Direction:** Cycles, domain code that depends on infrastructure, clients that bypass the
   API to reach the database, databases shared between services.
5. **Data Ownership:** Each table or store has one writer. Derived data is distinguishable from the source of truth.
   Filtering rules live in one place (a view or a query module), not in every consumer.
6. **Delivery and Operations:** How the system is built, published, deployed, and started. Who pulls each published
   image. How many commands a user runs to start the system. Resource footprint relative to the needs.
7. **Agentic-Development Artifacts:** Dead code paths, half-finished migrations, speculative extension points, flags and
   configuration nobody reads, documentation of components that do not exist.

## Evidence Rules

- Every finding cites evidence: `file:line`, a compose service name, a Dockerfile, or a workflow job.
- Mark each finding **Confirmed** (traced in code or configuration) or **Suspected** (state what must be checked).
- For a proportionality or redundancy finding, name the component, the need it claims to serve, the simpler alternative,
  and what the alternative costs. Do not recommend removing a component without saying what replaces its capability.
- Do not state resource numbers you have not measured. Give the command that measures them (for example
  `docker stats`).
- Accept complexity that serves a recorded need. State the trade-off instead of rejecting it.
- If a lens has no real findings, say so in one line. Do not pad the report.

## Report

Save the report as `docs/architecture/<scope-slug>_REVIEW.md`, where `<scope-slug>` is a short kebab-case name of the
scope. Load the `mermaid-diagrams` skill for every diagram, and run its validation script on the saved report. Write the
text in Simplified Technical English: short sentences, active voice, exact technical names.

```markdown
# <System> Architecture Review

## Verdict

At most 3 sentences: is the architecture fit for purpose, what is the largest risk, and what is the largest
simplification.

## Product Needs

| Need | Value | Source |
|------|-------|--------|

## Current Architecture

### Component View

Component diagram (`flowchart`).

### Deployment View

Deployment diagram (`flowchart` with a `subgraph` for each host or container).

### Use Case Map

| Use case | Owning module | Other modules involved |
|----------|---------------|------------------------|

## Findings

| # | Lens | Finding | Evidence | Confidence | Impact (High/Moderate/Low) |
|---|------|---------|----------|------------|----------------------------|

### 1. <Finding title>

- **Problem:** ...
- **Principle:** ...
- **Simpler alternative:** ...
- **Cost of change:** ...

Write a detail block for each High-impact finding.

## Target Architecture

Component diagram of the proposed architecture. Add a deployment diagram if the deployment changes.

## Simplification Roadmap

- [ ] Step 1 - each step ships on its own and leaves the system working.

## Open Questions

Use the Open Questions template: `~/.claude/skills/spec-writing/templates/open-questions.md`.
```

After saving, return the report path and the Verdict.
