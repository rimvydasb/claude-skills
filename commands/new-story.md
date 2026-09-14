---
name: new-story
description: Creates a new story definition file in docs/ for a feature, with a technical breakdown, proposed architecture changes, and a phased task plan. Does not modify docs/architecture.md.
argument-hint: <subject of the story>
disable-model-invocation: true
---

Analyze the following user story definition:
$ARGUMENTS

1. Review the existing documentation regarding the subject the user provided.
2. Create the new story file under `docs/` with the name `NEW_FEATURE_STORY.md` where instead of NEW_FEATURE you will
   use the name of the feature in uppercase and with underscores instead of spaces.
3. Read `docs/architecture.md`. Identify the new or changed components, services, and interactions that this story
   requires.
4. Describe those changes in the story's `## Architecture Changes` section, with structural and behavioral diagrams
   where needed. Do not modify `docs/architecture.md`: it describes approved and implemented architecture only. The
   story's final phase contains the task to update it.
5. Write the story using the story template below. You can split the implementation into phases if needed, but each
   phase must be complete in the terms that after each phase all tests pass and the application can be started.
6. Validate every diagram in the story with the `mermaid-diagrams` validation script.

@~/.claude/skills/spec-writing/templates/story.md

---

**Writing and diagram standards:** load the `spec-writing` and `mermaid-diagrams` skills before you write, unless they
are already loaded in this session. Apply them to the story.
