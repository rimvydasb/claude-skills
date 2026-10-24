---
name: refine-bug-report
description: Create or refine a bug report document - use it when problem is big or you stuck while solving it
argument-hint: [ existing-file-path | problem-description ]
---

Find this file or a problem description: $ARGUMENTS

The problem must be defined in a Markdown file.

# A Single Problem Content Template

1. **[LABEL] Problem XX: Problem Name**

> Start paragraph with a problem number only if document contains multiple problems. Then write a very brief name of the
> problem

> Instead of LABEL, put an actual status of the problem:
> - Default/Initial state: NEW (New problem),
> - Final state: FIXED (Exact fixed applied in this or other branch, or repository), NOT A BUG (fix is not required,
>   this might be undocumented behavior or misunderstanding), BLOCKED (unable to fix due to other problems,
>   explanation below)

- **Branch:** ...
- **Job:** (Jenkins or GitHub Actions job name if it is CI/CD problem)
- **Job URL:** (URL to the job if it is CI/CD problem)
- **Environments:** (list all affected environments where the problem occurs ❌ and where does not occur ✅)
- **Source code:** (list of all file directories that are under investigation or needed for the reference, and those
  directories are outside THIS repository)
- **Last updated:** (timestamp of the last update to this issue)

2. **Problem description** - a single paragraph describing what is the problem and what is the expected behavior
3. **Evidence** - original stack trace, error log or other log snippets that shows the fact of the error. These error
   trace snippets must also help to quickly trace back the full error log in the log.
4. **Sequence diagram** - a Mermaid sequence diagram that shows the calls between components and where call breaks due
   to the bug you're investigating. Add ⛔where the call breaks, mention with ❌ what calls never happened because of the
   bug, and also label with ✅ calls that are happening. The sequence diagram must help to understand where exactly the
   problem "lives". Do not store diagrams for DISPROVEN assumptions - the **Sequence diagram** must always represent the
   current state of the problem. Use icons ⛔, ❌, ✅ where possible in a sequence diagram.
5. **Assumptions** - a list of assumptions and ideas that try to explain what could be wrong in the CI/CD, code or
   environment. You must label all assumptions with the following labels:
    - **[DISPROVEN]** - previous assumption that appears to be incorrect
    - **[PROVEN]** - the assumption that is correct and proven based on hard evidences: logs, actual code, etc.
    - **[INVESTIGATING]** - assumption that is under investigation
6. **Attempts Log** - what approaches have you tried that failed
7. **Applied Changes Log** - briefly mention what additional log lines, fixes are already applied to this branch where
   you are investigating the problem
8. **Next Steps** - what approaches we need to try next to investigate, mitigate or finally solve the problem

- Each Next Steps and Attempts Log items must be chronological, feel free to add timestamp if needed
- Each Next Steps item must have the following labels (you can combine labels):
    - **[TROUBLESHOOTING]** - the next attempt or a task that has a goal to get additional information to better
      understand
      the problem
    - **[FIX]** - the task that attempts to mitigate or finally fix the problem
    - **[BLOCKER]** - the problem that requires fixing first
    - **[QUESTION]** - the question that developer needs to answer. Add question label to those tasks that are
      impossible to
      answer with tools that you have on hands and requires reaching other teams or web interfaces that are not
      accessible right now.
    - **[NOT NEEDED]** - usually previous label is changed to "no needed" when this previously planned step appears to
      be
      unnecessary or redundant.

# Task

- Refine the document based on this "Problem content". Continue working with this issue.

## Additional Notes

- All acronyms and abbreviations must first appear with expanded name in brackets e.g. DMP (Decision Management
  Platform), ASG (AWS Auto Scaling Group), etc.