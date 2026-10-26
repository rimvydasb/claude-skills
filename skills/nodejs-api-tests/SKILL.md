---
name: nodejs-api-tests
description: When user asks to create API Tests for the new Node.js project, use the following practices.
user-invocable: false
---

# Proposed API Tests Practice

1. API Tests should be written using `jest` and TypeScript. You can use the root `package.json` to add `jest` as a dev
   dependency
2. API Tests should be placed in the folder `api-tests`
3. API Tests must cover all HTTP return codes and other edge cases
4. To simulate other services, use WireMock as well as `wiremock-captain`. If needed, include WireMock to
   `docker-compose.test.yml` or `docker-compose.dev.yml`

## Proposed Structure

```text
.
├── api-tests
│   ├── fixtures
│   ├── utils
│   ├── tests
│   └── ...
└── ...
```
