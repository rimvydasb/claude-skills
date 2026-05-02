---
name: rust-story-doc-review
description: A comprehensive "First Principles" review of the Rust codebase
---

Story definition Markdown file: {{story}}

The general project information is stored in `ARCHITECTURE.md` and `GEMINI.md` files.

Analyze the story in {{story}} to determine if it is feasible to implement.
Find out all significant inconsistencies that must be addressed before the implementation.
Find out all gaps in the story that could lead to confusion during implementation.

You will work based on the industry standards, the best Rust practices and project priorities defined in `GEMINI.md`,
update the story definition file

**Step 0:** Actual code vs story definition file:
Before starting the review, make sure to check if the story definition file is up to date with the actual code. If the
story definition file is outdated and contains tasks that are completed, mark those tasks as completed.

**Step 1:** For clear inconsistencies:
If clear and minor misalignments or inconsistencies are found, you can fix the story definition file by yourself,
without asking questions. Do not lose important information, but feel free to rephrase or rearrange the story
definition to make it more clear and consistent.

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
   better architectural patter, better and more clear mental model that we can follow.
2. Note that the architect, who writes the story definition, might not be aware of all the best practices in Rust. Also,
   know that the architect works in a narrow domain, and might not know the best industry practices.
3. You can damage mental model and increase cognitive load (code complexity) for the sake of the WASM size and
   performance. However, this must be done with the full awareness of the trade-offs and only if it is really necessary.

---

## Open Questions

1. **Short title of the inconsistency or gap**: detailed description of the inconsistency or gap.
   Question to address: question that must be answered to resolve the inconsistency or gap.
   Option 1: possible way to resolve the inconsistency or gap.
   Option 2: another possible way to resolve the inconsistency or gap.
2. ...