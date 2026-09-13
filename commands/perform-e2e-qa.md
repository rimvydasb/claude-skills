---
name: perform-e2e-qa
description: Performs exploratory end-to-end QA of a feature in the browser from a business user's perspective, compares behavior with the story or specification and the e2e suite, and writes a report of reproduced issues to docs/qa/.
argument-hint: <story definition file or scope>
disable-model-invocation: true
context: fork
---

Perform QA from the end-user perspective in this scope: `$ARGUMENTS`

Test as a business user of this application (underwriter, rules analyst, or administrator). Base expectations on what is
specified in the story or specification file, and on common sense and a general understanding of the application usage
flow.

The report is read by the developers who fix the issues and maintain the `e2e` suite. Every issue must be reproducible
from the report alone.

## Tasks

1. Find the gaps in `e2e` testing and in the current implementation:
    - Check what is specified in the story definition file and is not covered by `e2e` testing
    - Think about the general expectations of business users and gaps that the specification might not cover
    - Find edge cases that neither `e2e` testing nor the specification covers
2. Perform exploratory testing scoped to the discovered gaps in `e2e` testing and the story definition file.
3. Perform additional exploratory testing of at least 2-3 scenarios that a business user might encounter, but that were
   not clearly specified in the specification or captured in `e2e`: were these scenario flows performed successfully?
   Does the application behavior make sense? Is the application behavior consistent and based on common sense?
4. Perform additional exploratory testing of at least 2-3 scenarios that touch edge cases, unexpected user behavior, and
   error handling: were these scenario flows performed without crashing the GUI or the application? Did the application
   report errors correctly? Was the application behavior consistent, did it make sense, and did the application recover
   from the edge case? Try valid, invalid, empty, and boundary inputs, and other strategies.
5. If you discovered a scenario that is worth adding to `e2e`, that explores interesting and challenging user behavior
   paths, document it and suggest its inclusion in the test suite.

> Exploratory testing is done by exploring Storybook interactively in the browser. Read the story or specification and
> the `e2e` test files to find gaps; do not read the application implementation.

> **Out of scope:** architecture, design and code quality, non-functional testing.

> **In the scope:** functional testing, user experience, overall application behavior.

## Evidence Rules

- Report an issue only after you reproduced it in the browser at least twice with the same steps.
- For each issue, record the exact steps, the input values, the current behavior, and the expected behavior.
- State the source of each expected behavior: the specification section, or `Assumption` when it comes from common
  sense. The reader decides whether an assumption-based issue is a defect.
- Separate application defects from test environment problems (Storybook setup, missing mock data). Report environment
  problems in their own section.
- Do not report a scenario that works correctly as an issue. A short report with real issues is better than a long report
  with doubtful ones.

## Report

Save the report as `docs/qa/e2e-issues-report_<scope-slug>.md`, where `<scope-slug>` is a short kebab-case name of the
scope. Document defects with screenshots where possible, and with reproduction steps. Use the following template:

```markdown
# E2E Issues Report

Scope: $ARGUMENTS
Testing date: <today's date, YYYY-MM-DD>

## Issues Found

- [ ] **Issue 1:** short description of the issue

  Steps to reproduce:
    1. ...
    2. ...

  Current behavior: the current behavior of the application that causes the issue.
  Expected behavior: the behavior expected when the issue is resolved. Source: specification section | Assumption

- [ ] **Issue 2:** short description of the issue...

## Environment Problems

- ...

## Recommendations

- [ ] **Recommendation 1:** description of the scenario that is worth adding to `e2e` testing
    1. Scenario step 1...
    2. Next step...

- [ ] **Recommendation 2:** description of another scenario that is worth adding to `e2e` testing...
```
