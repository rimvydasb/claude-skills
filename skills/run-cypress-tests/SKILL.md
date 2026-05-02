---
name: run-cypress-tests
description: Run the Cypress E2E test suite using ./bin/run-cypress-tests.sh, interpret results, and fix failures
---

Run the Cypress E2E tests for the current project. If a specific spec file is provided, run only that spec: {{spec}}

Inspect `./bin/run-cypress-tests.sh` in the repository to understand how the script manages the dev server and test
lifecycle before proceeding.
Inspect `cypress/e2e/` to understand what flows are already covered.

**Step 1:** Run the tests

If `{{spec}}` is provided, run:

```bash
./bin/run-cypress-tests.sh --spec "{{spec}}"
```

Otherwise, run the full suite:

```bash
./bin/run-cypress-tests.sh
```

**Step 2:** Interpret the output

- Exit code `0` and all specs marked `✓` — tests passed. Report which specs ran and confirm success.
- Exit code non-zero — tests failed. Collect the full failure output, including stack traces and the names of failing
  specs.
- `Error: dev lock detected` — another dev server is running or a stale lock file exists. Resolve the conflict (stop the
  server or remove the lock file) and retry Step 1.
- `Timeout waiting for server` — the app failed to start within 30 s. Read `server.log` (it is printed automatically)
  and diagnose the startup error before retrying.

**Step 3:** On failure, diagnose and fix

Read each failing spec file from `cypress/e2e/`. For each failure:

- Identify whether the failure is a **test bug** (wrong selector, outdated assertion) or an **application bug** (
  component broke, API changed).
- Check `cypress/screenshots/` for visual evidence of what the browser rendered when the test failed.
- Fix the root cause in the application code or test code as appropriate.
- Re-run only the affected spec (using `--spec`) to confirm the fix before running the full suite again.

**Step 4:** Confirm final state

Re-run the full suite once all fixes are in place. Report the final pass/fail count.

# Notes

1. The script kills any process on the configured port before starting the dev server — do not start the dev server
   manually before running the script.
2. Screenshots are cleared at the start of every run. Only screenshots from the latest run are present in
   `cypress/screenshots/`.
3. If the app requires backing services (e.g., a database), check the project README or `docker-compose.yml` and start
   them before running the script.
4. All extra arguments after the script name are forwarded directly to `cypress run`, so any valid Cypress CLI flag
   works (e.g., `--headed`, `--browser firefox`).
5. Keep Cypress updated to leverage the latest features and fixes.
6. Use `data-testid` attributes in your React components to create stable selectors for Cypress tests.