---
name: nodejs-structure
description: When creating the new Node.js project, use the proposed project structure in this skill as a baseline.
user-invocable: false
---

# Proposed Node.js Project Structure and Stack

## Structure

```
.
├── AGENTS.md
├── README.md
├── api-tests
│   ├── fixtures
│   ├── utils
│   ├── tests
│   └── ...
├── app
│   ├── App.tsx
│   ├── api
│   ├── components
│   ├── features
│   ├── index.html
│   ├── lib
│   ├── main.tsx
│   ├── routes
│   ├── theme.ts
│   ├── types.ts
│   └── ...
├── build
│   └── ...
├── docker
│   ├── Dockerfile
│   ├── docker-compose.dev.yml
│   ├── docker-compose.yml
│   └── ...
├── data
│   └── ...
├── dist
├── docs
│   ├── architecture
│   ├── bugs
│   ├── stories
│   ├── ...
├── drizzle
│   └── ...
├── drizzle.config.ts
├── e2e
│   ├── ...
├── node_modules
├── package-lock.json
├── package.json
├── playwright.config.ts
├── playwright.demo.config.ts
├── postcss.config.cjs
├── scripts
│   ├── start-in-docker.sh
│   ├── stop-in-docker.sh
│   └── ...
├── server
│   ├── (component name)
│   │   ├── (component).ts
│   │   ├── __tests__
│   │   ├── routing.ts
│   │   ├── types.ts
│   │   ├── utils.ts
│   │   └── ...
│   ├── (component 2 name)
│   │   ├── (component 2).ts
│   │   └── ...
│   └── ...
├── vitest.config.ts
├── tsconfig.json
├── vite.config.ts
└── ...
```

> If user specified, prioritize user specified structure instead

## Base Stack

- Vite, Vite Test
- TanStack Query
- Fastify
- React for the frontend (`app`)
- Zod
- Jest for `api-tests`

> If user specified, prioritize user specified stack instead