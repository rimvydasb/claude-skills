---
name: perform-system-qa
description: Perform a comprehensive Test Gap Analysis on the provided source code/specification and existing test suite.
argument-hint: <scope or story documentation file>
---

# Role & Task

You are a Senior Principal QA Architect, Security Engineer, and Chaos Testing Specialist. Your task is to perform an
exhaustive Test Gap Analysis on the provided source code/specification and existing test suite. You must identify
unhandled edge cases, functional gaps, security/penetration risks, load/stress limitations, and unstructured exploratory
test vectors.

---

## Scope of Analysis

$ARGUMENTS

---

## Instructions & Analysis Framework

Execute your analysis systematically across the following 5 dimensions. Do not skip any dimension.

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

## Output Format Requirements

Write down 'doc/qa/issues-report_{scope}.md' in Markdown format. 
Produce your response strictly using the following Markdown template:

### Executive Summary

A concise 2-3 sentence overview of the test coverage health and the highest critical risk found.

### Priority Gap Matrix

| Category  | Missing Scenario / Edge Case | Risk Level (Critical/High/Med/Low) | Impact     | Recommended Test Type (Unit/Integration/Pen/Stress) |
|:----------|:-----------------------------|:-----------------------------------|:-----------|:----------------------------------------------------|
| Edge Case | *[Brief Description]*        | High                               | *[Impact]* | Unit                                                |
| Security  | *[Brief Description]*        | Critical                           | *[Impact]* | Penetration                                         |

### Detailed Test Case Scenarios

For each key gap identified, provide a concrete test case specification in this format:

#### [Test ID] Title

* **Target Component/Method:**
* **Category:** [Functional Edge Case | Security / Pen | Stress / Load | Exploratory]
* **Preconditions / Setup:**
* **Test Input / Action:**
* **Expected Result:**
* **Failure Condition (What breaks if untested):**

### Actionable Recommendations

* List 3–5 immediate engineering priorities to harden the suite.