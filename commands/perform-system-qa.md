---
name: perform-system-qa
description: Performs a test gap analysis of source code, specification, and the existing test suite across functional edge cases, unit/integration coverage, security, load/concurrency, and exploratory vectors, and writes a report of verified gaps with test case specifications to docs/qa/.
argument-hint: <scope or story documentation file>
disable-model-invocation: true
context: fork
---

# Test Gap Analysis

Analyze the source code, specification, and existing test suite in scope. Identify unhandled edge cases, functional
gaps, security and penetration risks, load and stress limitations, and exploratory test vectors that the current tests do
not cover.

The report is read by the engineers who own this code. They use it to decide which tests to write next, so every gap
must be real, located in the code, and specific enough to turn into a test.

---

## Scope of Analysis

$ARGUMENTS

---

## Analysis Framework

Analyze the scope across the following 5 dimensions.

### 1. Functional & Boundary Edge Cases

* Analyze input parameters, state transitions, domain logic, and data boundaries.
* Identify implicit assumptions (e.g., non-null values, list limits, chronological order, numeric overflow/underflow,
  off-by-one errors).
* Detail exact inputs/states that will cause unhandled exceptions or invalid state transitions.

### 2. Missing Unit & Integration Test Coverage

* Compare specifications directly against existing test suites.
* List untested code branches, uncovered error handlers, unverified failure recovery logic, and missing mock assertions
  for external dependencies.

### 3. Penetration & Security Test Scenarios

* Evaluate the code for injection risks, unauthorized state mutation, missing authorization checks, improper input
  sanitization, data leaks, and race conditions (TOCTOU).
* Formulate concrete penetration test cases designed to break security boundaries or manipulate payload structures.

### 4. Stress, Load & Concurrency Vectors

* Identify resource bottlenecks: memory allocations, DB connection pools, thread lock contention, unindexed queries, and
  async timeout handling.
* Define stress test scenarios (e.g., high-concurrency bursts, payload scaling, connection drops, slow-Loris style
  network delays) that test breaking points.

### 5. Exploratory & Unscripted Test Vectors

* Think like an adversarial user or unpredictable environment.
* Devise exploratory scenarios combining unusual user behaviors, partial system outages, retry storms, clock skew, or
  corrupted state persistence.

---

## Evidence Rules

* Base every gap on code you have read. Cite the file and line (`path/to/file.ts:42`) of the untested behavior.
* Before reporting a gap as untested, search the test suite for existing coverage (test names, the function name, the
  input case). If a test covers it, drop the gap.
* Report a security, load, or concurrency risk only when you can describe the concrete code path that makes it
  possible. Do not list generic risks that apply to any system.
* Assign each gap a confidence: **Confirmed** (you traced the code path and found no covering test) or **Suspected**
  (plausible, needs a check). List Suspected gaps after Confirmed gaps.
* Cover all 5 dimensions. If a dimension has no real gaps or does not apply to the scope, write one line saying so. Do
  not pad the report.

---

## Output Format Requirements

Save the report as `docs/qa/test-gap-analysis_<scope-slug>.md`, where `<scope-slug>` is a short kebab-case name of the
scope. Use the following Markdown template:

### Executive Summary

A concise 2-3 sentence overview of the test coverage health and the highest critical risk found.

### Priority Gap Matrix

| Category  | Missing Scenario / Edge Case | Evidence (file:line)  | Confidence (Confirmed/Suspected) | Risk Level (Critical/High/Med/Low) | Impact     | Recommended Test Type (Unit/Integration/Pen/Stress) |
|:----------|:-----------------------------|:----------------------|:---------------------------------|:-----------------------------------|:-----------|:----------------------------------------------------|
| Edge Case | *[Brief Description]*        | `src/foo.ts:42`       | Confirmed                        | High                               | *[Impact]* | Unit                                                |
| Security  | *[Brief Description]*        | `src/auth/guard.ts:7` | Suspected                        | Critical                           | *[Impact]* | Penetration                                         |

### Detailed Test Case Scenarios

For each key gap identified, provide a concrete test case specification in this format:

#### [Test ID] Title

* **Target Component/Method:**
* **Category:** [Functional Edge Case | Security / Pen | Stress / Load | Exploratory]
* **Evidence:** file:line and the code path involved; the test files searched for existing coverage
* **Confidence:** [Confirmed | Suspected — what must be checked]
* **Preconditions / Setup:**
* **Test Input / Action:**
* **Expected Result:**
* **Failure Condition (What breaks if untested):**

### Actionable Recommendations

* List 3–5 immediate engineering priorities to harden the suite.
