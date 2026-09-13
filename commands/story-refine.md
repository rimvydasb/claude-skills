---
name: story-refine
argument-hint: <story definition file to refine> <new requirements>
description: Incorporates new requirements into an existing story definition file, removes questions they answer and completed tasks, and re-plans the Tasks section. Edits only the story file.
disable-model-invocation: true
---

Check the mentioned story definition Markdown file and new user requirements: `$ARGUMENTS`

The general project information is stored in `docs/architecture.md` and `README.md` files.

1. Analyze the existing story definition and the new user requirements.
2. Intelligently add new requirements to the story definition file, refine existing story parts to meet the new
   requirements, and make sure that the story definition file is consistent and clear after the update. Make sure the
   new requirements are incorporated into the story and story-relevant parts are updated.
3. It could be that the story already contains questions that are answered with the new user requirements. In this case,
   delete the old question and make sure the answer is clearly answered, and new information is defined in the relevant
   section.
4. It could be that the story contains already implemented phases and tasks that are marked as - [x] completed checkboxes.
   Delete implemented tasks.
5. It could be that to incorporate new requirements, you will need to review the codebase and `docs/architecture.md`.
   In this case, you should do it and make sure that the story definition file is consistent with the actual code and
   architecture document after the update. Breaking changes are allowed.
6. Do not modify `docs/architecture.md`. If the new requirements change the architecture, describe the changes in the
   story's `## Architecture Changes` section.
7. As a final step, plan the implementation of new requirements and add or update section `## Tasks` in the story
   document.
8. If you changed a diagram, validate the story with the `mermaid-diagrams` validation script.

---

**Writing and diagram standards - apply them to the story:**

@~/.claude/skills/spec-writing/SKILL.md

@~/.claude/skills/mermaid-diagrams/SKILL.md
