---
description: Retrospective on the just-finished session, producing concrete fixes to skills, scripts, and CLAUDE.md
argument-hint: [optional focus area]
allowed-tools: Read, Grep, Glob, WebFetch, WebSearch
disable-model-invocation: true
---

The task is finished. Do not continue it or modify any files. Your job is a retrospective on this session.
Focus area (if given): $ARGUMENTS

## Rules

- Ground every claim in a specific moment from this session (the tool call, error, or user message).
  If you cannot point to one, drop the claim.
- If earlier context was compacted or you cannot see it, say so. Do not reconstruct.
- Before proposing anything, read the existing `CLAUDE.md`, `.claude/skills/*/SKILL.md`, and scripts directory
  so you do not duplicate what exists.
- Only propose an addition if it would have saved at least one wasted tool call, retry, or user correction
  in this session, or if the same pattern clearly recurs. Prefer editing or removing over adding.

## Analyze

1. **Friction**: Where did you waste effort? List user corrections, failed or repeated tool calls,
   wrong assumptions, and exploration that led nowhere. For each, name the root cause
   (missing context, wrong skill guidance, no script for a deterministic step, ambiguous instruction).
2. **What worked**: Which skills, scripts, and CLAUDE.md instructions did you actually use, and did each
   one help or mislead? Cite where.
3. **Stale or unused**: Which loaded skills or instructions were irrelevant, wrong, or contradicted what
   you found in the code?

## Check against current guidance

Do this only after completing the Analyze section, so session evidence drives the lookup.

1. WebFetch these primary sources first:
   - https://docs.claude.com/en/docs/agents-and-tools/agent-skills/best-practices
   - https://www.anthropic.com/engineering/claude-code-best-practices
   - https://code.claude.com/docs/en/skills
2. Use WebSearch only for a specific friction item these pages do not cover. Accept results from
   anthropic.com, claude.com, docs.claude.com, or code.claude.com only. Ignore third-party blogs and forums.
3. Cite guidance only when it changes a proposal: it explains a friction item's root cause or
   contradicts something in the current skills or CLAUDE.md. Include the URL in the proposal row.
   Do not summarize guidance that does not map to this session.

## Output

A table of proposals ranked by impact, max 7 rows:

| # | Problem (with session evidence) | Fix type | Target file | Exact change |

- Fix type is one of: CLAUDE.md edit, skill edit, new skill, script, hook, delete.
- "Exact change" is the literal text to add, replace, or remove, or for a script, its name, inputs,
  outputs, and the command it replaces.
- End with one line: the single change you would make first, and why.