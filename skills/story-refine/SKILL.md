---
argument-hint: <story definition file to refine>
description: Analyze and add the new requirements to the story definition file
---

Check the mentioned story definition Markdown file and new user requirements: `$ARGUMENTS`

The general project information is stored in `ARCHITECTURE.md` and `README.md` files.

1. Analyze the existing story definition and the new user requirements.

2. Intelligently add new requirements to the story definition file, refine existing story parts to meet the new
   requirements, and make sure that the story definition file is consistent and clear after the update. Make sure the
   new requirements are incorporated into the story and story-relevant parts are updated.
3. It could be that the story already contains questions that are answered with the new user requirements. In this case,
   delete the old question and make sure the answer is clearly answered, and new information is defined in the relevant
   section.
4. It could be that the story contains already implemented phases and tasks that are marked as - [x] completed checkboxes.
   Delete implemented tasks.
5. It could be that to incorporate new requirements, you will need to review the codebase and the architecture document.
   In this case, you should do it and make sure that the story definition file is consistent with the actual code and
   architecture document after the update. Breaking changes are allowed.
6. As a final step, plan the implementation of new requirements and add or update section `# Tasks` in the story
   document.