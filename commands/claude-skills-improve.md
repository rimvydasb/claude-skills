---
name: claude-skills-improve
description: Reviews the Claude Code skills and commands in ~/.claude against current Anthropic guidance and research on agentic development, and writes a report of decompositions, new skills, and red flags to docs/skills-review-YYYY-MM-DD.md.
disable-model-invocation: true
---

Review @skills/ and @commands/ against the current LLM development practices recommended by Anthropic, and against
research on agentic development approaches.

## Sources

Fetch these sources before you review. If a fetch fails, search for the current version of the page. Prefer these
sources over memory, and cite the source of each practice you apply.

| Source                                | URL                                                                                          |
|---------------------------------------|----------------------------------------------------------------------------------------------|
| Claude Code skills                    | https://code.claude.com/docs/en/skills                                                       |
| Claude Code subagents                 | https://code.claude.com/docs/en/sub-agents                                                   |
| Claude Code best practices            | https://code.claude.com/docs/en/best-practices                                               |
| Agent Skills authoring best practices | https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices             |
| Equipping agents with Agent Skills    | https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills |
| Effective context engineering         | https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents           |

Work history: `~/.claude/history.jsonl` contains the user's past prompts (field `display`, project in `project`). Use it
to find repeated requests, repeated corrections, and frustrations. Summarize patterns; do not copy private content.

## Questions

1. Should I create separate skills (by decomposing existing skills or commands) so those practices don't repeat across
   skills and commands? List all decompositions I should do, if any.
2. What completely new skills should I recommend based on my work history, encountered problems and best practices? Are
   there additional skills or commands I'm missing right now that would help improve the agentic development process?
   List all these recommendations.
3. What major red flags do you see in my skills and commands? List all fixes I should make to improve them. For example,
   some skills or commands may be too complex, too similar, overlapping, or even contradictory. List all these issues
   and recommend fixes.

## Evidence Rules

- Cite the file and line (`commands/story-refine.md:19`) for every red flag and decomposition.
- Cite the history pattern (a short quote or a command usage count) for every new-skill recommendation.
- Report only issues that change agent behavior or cost. Do not pad the report.

## Report

Save the report as `~/.claude/docs/skills-review-<today's date, YYYY-MM-DD>.md`. Give each item a stable ID (`D1`, `N1`,
`R1`) so the user can refer to it. End the report with a suggested order of work. After saving, print the report path
and a short summary of the highest-value items.
