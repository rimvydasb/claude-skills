---
name: story-review
description: A comprehensive "First Principles" review of the codebase
---

Story definition Markdown file: $ARGUMENTS

General project information is stored in the ARCHITECTURE.md and README.md files.

Analyze the story in $ARGUMENTS to determine if it is feasible to implement.
Identify all significant inconsistencies that must be addressed before implementation.
Find out all gaps in the story that could lead to confusion during implementation.

You will work based on industry standards, the best Rust, TypeScript, Node.js, React, and Next.js practices, and
project priorities defined in ARCHITECTURE.md.

**Step 1: Get familiar with the actual code versus story definition file**

Before starting the review, check whether the story definition file is up to date with the actual code. If the
story definition file is outdated and contains completed tasks; mark those tasks as completed.

**Step 2: Clarify minor inconsistencies by your own knowledge**

If clear and minor misalignment or inconsistencies are found, you can fix the story definition file by yourself
without asking questions. Do not lose important information, do a precise and minimal update to the story document, but
feel free to rephrase or rearrange the story definition to make it clearer and more consistent.

**Step 3: Clean up answered questions and add clarifications**

If the architect already replied to some open questions or the architect left his notes in the story definition file,
review those answers and update the actual story definition file where needed. You can also add clarifications (notes)
Markdown section `>` if needed to keep clarifications provided by those architect answers or notes. Remove answered
questions if they're answered.

**Step 4: Find remaining inconsistencies, blockers and gaps**

Review "Open Questions" section if related inconsistency still exists. Update existing "Open Questions" if related
issues still remain. Add "Open Questions" section if it does not exist. Find out and list all significant
inconsistencies and gaps that must be resolved before the implementation. If it is possible, provide options on how to
resolve each inconsistency or gap.

# Notes

1. Note that the architect might not be aware of the alternative solutions. This is very important if you already know
   A better architectural pattern, a better and clearer mental model that we can follow.
2. Note that the architect, who writes the story definition, might not be aware of all the best practices. Also, know
   that the architect works in a narrow domain and might not be familiar with the best industry practices.
3. The goal is to make this story definition file as clear and consistent as possible, so that the implementation can be
   done without any confusion or misunderstandings and successfully as planned.
4. You are allowed to be critical and point out any inconsistencies or gaps you find - the author will be very glad if
   you correct him where really needed, for the sake of the story's success, rather than blindly agreeing with the story
   definition.
5. Note that we’re in the development phase; we do not have any obligation to maintain backward compatibility, and we’re
   allowed to make architectural changes if they're backed by a good reason.

---

Template:

## Open Questions

1. **Short title of the inconsistency or gap**: detailed description of the inconsistency or gap.
   Question to address: question that must be answered to resolve the inconsistency or gap.
   Option 1: possible way to resolve the inconsistency or gap.
   Option 2: another possible way to resolve the inconsistency or gap.
2. ...