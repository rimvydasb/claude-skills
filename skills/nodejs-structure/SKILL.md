---
name: nodejs-structure
description: When creating the new Node.js project, consider using the proposed structure in this skill.
user-invocable: false
---

# Proposed Node.js Project Structure and Stack

## Structure

```
.
├── AGENTS.md
├── README.md
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
│   └── trading212
├── ...
├── tsconfig.json
├── vite.config.ts
└── vitest.config.ts
```

> If user specified, prioritize user specified structure instead

## Base Stack

- Vite, Vite Test
- TanStack Query
- Fastify
- React
- Zod

> If user specified, prioritize user specified stack instead