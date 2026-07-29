---
name: perform-e2e-qa
description: Perform e2e QA and write down issues-report
argument-hint: <story definition file or scope>
---

You will do QA from the end-user perspective. You will work in this scope: `$ARGUMENTS`

You will think as a business user of this application (underwriter, rules analyst, or administrator), you will be based
on what is specified in the story or specification file as well as common sense and general understanding of application
usage flow.

## Tasks:

1. Check what gaps do we have `e2e` testing and what is missing in the current implementation:
    - Check what is specified in the story definition file and what is not covered by `e2e` testing
    - Think about the general expectations from the business users and gaps that might not be covered by specification
    - What edge cases where not covered by `e2e` testing and specification
2. Perform exploratory testing that are scoped to discovered gaps in `e2e` testing and the story definition file.
3. Perform additional exploratory testing of at least 2-3 scenarios that you think business user might encounter, but
   were not clearly specified in the specification or captured in `e2e`: were these scenario flows performed
   successfully? Do application behaviour make sense? Is application behaviour consistent and based on the common sense?
4. Perform additional exploratory testing of at least 2-3 scenarios that touches edge cases, unexpected user behaviour,
   and error handling: were these scenario flows performed successfully without charging GUI or application? Do
   application correctly reported errors? Was application behaviour consistent, made sense and did application recovered
   from the edge case? Try valid, invalid, empty, and boundary inputs, other strategies.
5. If you discovered a scenario that is worth adding to `e2e`, that explores interesting and challenging user behaviour
   paths, document it and suggest its inclusion in the test suite.

> Exploratory testing should be done by exploring Storybook interactively using the browser, without reading
> implementation details.

> **Out of scope:** architecture, design and code quality, non-functional testing.

> **In the scope:** functional testing, user experience, overall application behavior.

Write down all issues, bugs, and inconsistencies that you find during the testing. Write down
`docs/qa/issues-report_{scope}.md` in Markdown format. Document defects with screenshots and reproduction steps. Use the
following template to write down the issues report.

Template:

# Issues Report

Scope: $ARGUMENTS Testing date: $CURRENT_DATE

## Issues found:

- [ ] Issue 1: Description of the issue

Current behavior: Describe the current behavior of the application that is causing the issue. Expected behavior:
Describe the expected behavior of the application that should be observed if the issue is resolved.

- [ ] Issue 2: Description of the issue...

## Recommendations:

- [ ] Recommendation 1: description of the scenario that is worth adding to `e2e` testing

1. Scenario step 1...
2. Next step...

- [ ] Recommendation 2: description of another scenario that is worth adding to `e2e` testing...