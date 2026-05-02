---
name: story-review
description: A comprehensive "First Principles" review of the codebase
---

Story definition Markdown file: {{input}}

The general project information is stored in `ARCHITECTURE.md` and `README.md` files.

Analyze the story in {{input}} to determine if it is feasible to implement.
Find out all significant inconsistencies that must be addressed before the implementation.
Find out all gaps in the story that could lead to confusion during implementation.

You will work based on the industry standards, the best TypeScript, Node Js, React and Next JS practices and project
priorities defined in `ARCHITECTURE.md`.

**Step 0:** Actual code vs story definition file:
Before starting the review, make sure to check if the story definition file is up to date with the actual code. If the
story definition file is outdated and contains tasks that are completed, mark those tasks as completed.

**Step 1:** For clear inconsistencies:
If clear and minor misalignments or inconsistencies are found, you can fix the story definition file by yourself.
without asking questions. Do not lose important information, but feel free to rephrase or rearrange the story
definition to make it clearer and more consistent.

**Step 2:** If Open Questions exists:
If the architect already replied to some "Open Questions" in the story definition file, review those answers and update
the actual story definition file or add "Clarifications" section if needed to reflect those answers. Remove answered
question form "Open Questions" section.

**Step 3:** For significant inconsistencies and gaps:
Review "Open Questions" section if related inconsistency still exists. Update existing "Open Questions" if related
issues still remain. Add "Open Questions" section if it does not exist, and list all significant inconsistencies and
gaps that must be resolved before the implementation. If it is possible, provide options on how to resolve each
inconsistency or gap.

# Notes

1. Note that the architect might not be aware of the alternative solutions. This is very important if you already know
   A better architectural pattern, a better and clearer mental model that we can follow.
2. Note that the architect, who writes the story definition, might not be aware of all the best practices. Also,
   know that the architect works in a narrow domain and might not be familiar with the best industry practices.
3. The goal is to make this story definition file as clear and consistent as possible, so that the implementation can be
   done without any confusion or misunderstandings and successfully as planned.
4. You are allowed to be critical and point out any inconsistencies or gaps that you find - the author will be very glad
   if you correct him instead, where really needed for the sake of story success, instead of blindly agreeing
   with.

---

Template:

## Open Questions

1. **Short title of the inconsistency or gap**: detailed description of the inconsistency or gap.
   Question to address: question that must be answered to resolve the inconsistency or gap.
   Option 1: possible way to resolve the inconsistency or gap.
   Option 2: another possible way to resolve the inconsistency or gap.
2. ...