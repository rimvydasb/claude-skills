---
name: product-prospect
description: Runs an evidence-based strategic, technical, market and AI-era assessment of a product I develop and creates or updates its long-term prospect document (vision, SWOT/TOWS, competition, scenarios, roadmap).
argument-hint: "[optional: focus area or research area to resume, e.g. 'competition' or 'AI landscape']"
disable-model-invocation: true
---

# Product Prospect — Strategic Assessment and Vision Building

## Objective

Produce an honest, evidence-based assessment of what the product could become, where it could win, where it would
lose, and whether its fundamental product and technology bets make sense.

Act as an independent combination of:

- Product strategist.
- Software architect.
- Domain expert for the product's problem space.
- Market and competitive analyst.
- AI and agentic systems architect.

The goal is not to validate my existing ideas or justify the current architecture. The goal is to help me make better
strategic decisions.

I am the developer and architect of the product. I need to know whether it has real market potential, what problems the
market struggles with, what existing solutions fail to address, and where the product could create meaningful value.

Be pragmatic, critical and intellectually honest. No sales pitch, artificial optimism or generic startup advice.

Do not judge the product by GitHub stars or public popularity. Repositories may be private on purpose.

`$ARGUMENTS` (optional) names a focus area or a research area to resume. If empty, resume from the progress section of
the latest prospect document, or start from the beginning.

## Step 0 — Load the product brief

All product-specific context lives in a **product brief**, not in this skill.

1. Look for `prospect-brief.md` in the prospect folder. Default folder: `docs/architecture/prospect/`. If the
   repository's `CLAUDE.md` names a different folder, use that.
2. If the brief exists, read it and treat it as the source of product-specific context.
3. If the brief does not exist, create it:
    - Inspect the repository (`README`, `CLAUDE.md`, `docs/`, build files, main source folders) to draft it.
    - Ask me only for what the code and docs cannot tell you: strategic ambitions, target users I have in mind, other
      repository locations, and domain-specific questions I want answered.
    - Save the brief before starting research.

The brief contains:

| Field                         | Purpose                                                                              |
|-------------------------------|--------------------------------------------------------------------------------------|
| Product name                  | Used throughout the document.                                                        |
| One-paragraph description     | What the product is, in plain words.                                                 |
| Strategic ambitions           | 1–3 ambitions. Treated as hypotheses to test, not requirements.                      |
| Code locations                | All repositories and folders to inspect (core, UI, services, SDKs).                  |
| Market categories             | Segments and product categories to research.                                         |
| Known competitors             | Starting list. The investigation must extend it.                                     |
| Domain-specific deep dives    | Extra questions specific to this product (e.g. "should we build our own language?"). |
| Domain-specific assumptions   | Product-specific assumptions to challenge, added to the generic list in section 6.   |
| Scenario overrides (optional) | Custom names or descriptions for the strategic scenarios.                            |
| Output folder (optional)      | Where prospect documents are written, if not the default.                            |

## Investigation

### 1. Understand the product

Inspect every code location listed in the brief. Understand:

- Current architecture and design philosophy.
- Core domain model and execution or runtime model.
- Key technical assets (languages, engines, algorithms, data models, UI paradigms).
- Extensibility and integration options (APIs, SDKs, plugins, embedding).
- Experience for each user type (developer, business user, operator, admin).
- Testing, debugging, observability and explainability.
- Strengths, limitations and architectural constraints.
- Maturity: test coverage, stability, documentation, packaging, deployment.

Rules:

- Separate **implemented**, **partially implemented**, **planned** and **assumed** capabilities. Label each.
- Do not judge the product only from documentation. Inspect the code.
- Cite file paths for important claims about the implementation.

### 2. Understand the market

Research the current landscape for every category in the brief. Add adjacent categories you find.

For relevant products and competitors, study their actual capabilities, positioning, target customers, pricing model
(where public) and limitations.

Identify:

- What customers are trying to achieve (jobs to be done).
- Where existing tools create friction.
- What problems remain poorly solved.
- What customers are dissatisfied with (forums, reviews, issue trackers, migration stories).
- What customers pay for, and who holds the budget.
- Which problems are technically interesting but commercially unimportant.
- Switching costs and migration barriers that protect incumbents.

Use current sources. Label every claim as **verified fact**, **market observation** or **hypothesis**.

### 3. The AI-native landscape

Critical section. Do not assume that today's categories of software (engines, modelers, DSLs, visual editors, SaaS
apps) stay equally relevant as AI models and agents improve.

#### 3.1 AI-generated applications and coding agents

Investigate the **current, verified** capabilities of AI application builders and coding agents relevant to this
product. At minimum: Claude (Artifacts, Claude Code), ChatGPT app-building features, and other leading AI app
builders and coding agents. Verify claims against official sources. Do not mix up the capabilities of different
products.

Answer:

- If a user can describe the problem and get a working custom app, why would they need this product?
- Could AI produce the product's core artifact (code, model, config, document) directly?
- Does AI make the product's interface (visual editor, DSL, forms) more important as a way to inspect and validate
  AI output — or less important?
- Could the product become the execution, validation or governance layer behind AI-generated software?
- Could the product become an environment where AI creates and maintains the product's artifacts?

Evaluate four futures for the product's core work: humans do it, AI does it, humans and AI collaborate, AI does it
dynamically at runtime. Say which is most likely for which user segment.

#### 3.2 Agent protocols and distribution (MCP, MCP Apps, WebMCP, others)

Evaluate whether the product should expose capabilities to AI agents. Check current protocol status and maturity
before assessing.

- **MCP server:** which tools would agents actually call (discover, execute, validate, test, explain, version)?
- **MCP Apps / rich UI inside AI clients:** is there value in embedding the product's UI inside agent clients?
- **WebMCP / browser agents:** should web apps built on the product expose structured tools to browser agents?
- Backend MCP versus browser-side WebMCP: when each fits.

Decide whether agent integration should be: a simple integration interface, a first-class architectural capability,
a distribution channel, or the foundation of an agent-native product. Assess the risk of depending on evolving
protocols. Do not assume universal adoption.

#### 3.3 AI versus the product's core approach

Compare the product's approach (for example deterministic execution, explicit models, structured data, manual
workflows) with:

- Direct LLM reasoning.
- AI-generated custom code.
- Existing non-AI alternatives.
- Hybrid architectures (AI for intent and maintenance, the product for reliable execution, humans for approval).

Find where each wins. Pay attention to domains where reproducibility, auditability, safety, cost or latency matter.
Decide whether a hybrid architecture is a real market opportunity or only an attractive technical concept.

#### 3.4 Commoditization

List what AI can already generate cheaply that overlaps with the product (an engine, a DSL, an editor, a full app,
integrations). Then decide what stays hard to do reliably and valuable, for example:

- Execution guarantees, correctness and performance.
- Governance, versioning and reproducibility.
- Explainability and observability.
- Testing and simulation.
- Enterprise integration, security and compliance.
- Domain-specific abstractions and accumulated domain knowledge.
- Trust, support and operational reliability.

#### 3.5 AI-native opportunities

For each promising opportunity, give: the problem, the user, why existing solutions fall short, why this product could
do it better, technical complexity, differentiation and commercial relevance. No feature wishlists.

### 4. Domain-specific deep dives

Answer every deep-dive question listed in the brief with the same rigor: evidence, alternatives, recommendation.

### 5. Strategic directions

Generate at least 5 possible product directions. Use the ambitions in the brief, plus directions you find. Always
include at least one direction that drops a core ambition and one that is AI- or agent-native.

Compare them in one table with these criteria, scored 1–5 with a one-line reason per score:

| Criterion               | Weight (default) |
|-------------------------|------------------|
| Market demand           | 3                |
| Differentiation         | 3                |
| Commercial potential    | 3                |
| Relevance in AI era     | 3                |
| Long-term defensibility | 2                |
| Fit with current assets | 2                |
| Technical complexity    | 2 (inverted)     |
| Adoption barriers       | 2 (inverted)     |
| Competitive pressure    | 1 (inverted)     |

Show the weighted total. State that scores are judgment calls and explain the 2–3 scores that decide the ranking.
Do not assume that combining directions is best.

### 6. Differentiation

Find capabilities that are difficult to build well, valuable to real users, poorly served today, and defensible.
Separate them from features competitors already have. Use a side-by-side capability matrix (product vs. top 3–6
competitors). Mark each cell as: has / partial / missing / unknown.

For defensibility, check which moats apply, if any: switching costs, network effects, proprietary data, scale
economics, brand/trust, regulatory position, embedded integrations. Say plainly if none apply.

### 7. Challenge the fundamental assumptions — Assumption map

Challenge these generic assumptions plus the domain-specific ones from the brief:

- The market needs another product in this category.
- Existing solutions are insufficient for a meaningful group of users.
- The product's core technical bet gives a real advantage users notice.
- The intended users will adopt it given switching costs.
- One product can serve all intended user types well.
- A solo developer or small team can compete with established vendors here.
- The category stays relevant as AI-generated software becomes common.
- The product's core approach keeps its value when AI agents can do the job directly.
- Agent protocols can become a meaningful distribution channel.

For each assumption, record in a table:

| Assumption | Importance (H/M/L) | Current evidence (strong/weak/none/contradicting) | What would need to be true |
Cheapest test to validate |

Highlight the assumptions that are **high importance + weak evidence**. These drive the roadmap.

### 8. Technical feasibility

Evaluate the current architecture against the top-ranked directions. Check support for, where relevant:

- Programmatic and AI-driven creation and modification of the product's artifacts.
- Stable, versioned public interfaces.
- Agent integration (MCP, MCP Apps, WebMCP).
- Secure execution, access control and multi-tenancy.
- Explainable traces and observability.
- Deterministic, reproducible behavior.
- Human and AI collaboration (review, diff, approval).

Name the few architectural investments that enable several directions at once. Do not recommend complexity or
integrations only because they are fashionable.

### 9. SWOT and TOWS

Build a SWOT **after** sections 1–8, from evidence collected there. Rules:

- Strengths and weaknesses are internal and must point to the code, assets or team reality.
- Opportunities and threats are external and must point to a source or a labeled hypothesis.
- 3–7 items per quadrant. No generic items ("good code quality", "competitive market").
- Treat AI both as an opportunity and as a threat; list it concretely in both if it applies.

Then convert the SWOT into actions with a TOWS matrix:

|                | Opportunities                               | Threats                                     |
|----------------|---------------------------------------------|---------------------------------------------|
| **Strengths**  | SO: use strengths to capture opportunities  | ST: use strengths to reduce threats         |
| **Weaknesses** | WO: fix weaknesses that block opportunities | WT: avoid areas where weakness meets threat |

Each TOWS cell has 1–3 concrete actions. These actions feed the roadmap. A SWOT without a TOWS is not complete.

### 10. Pre-mortem

Assume it is two years from now and the product failed. Write the 5 most likely reasons, ranked by likelihood. For
each: early warning signal and mitigation. Feed the result into the risks section.

## Expected deliverable

Write to `<prospect folder>/prospect-update-YYYYMM.md` (use the current year and month). If a document for the current
month exists, update it. If only older documents exist, start a new one from the latest, preserving valuable research
and noting what changed.

Maintain it as a long-term strategic document, not a marketing presentation. Structure:

1. **Executive assessment** — Honest verdict in one page or less.
2. **Current state** — What the product actually is; implemented vs. planned.
3. **Market landscape** — Segments, customer jobs, budgets, problems.
4. **Competitive analysis** — Alternatives, strengths, weaknesses, gaps; capability matrix.
5. **Unsolved problems** — What existing products handle poorly.
6. **AI-native landscape** — How AI apps, agents and protocols change the market.
7. **SWOT and TOWS** — Evidence-based SWOT and the resulting action matrix.
8. **Strategic opportunities** — Where the product could realistically win.
9. **Product directions** — Weighted comparison of alternative strategies.
10. **Domain-specific strategy** — Answers to the brief's deep-dive questions.
11. **AI and agent integration strategy** — MCP, MCP Apps, WebMCP, AI-native capabilities.
12. **Technical feasibility** — Architectural strengths, limits, required investments.
13. **Assumption map** — Assumptions, evidence, tests.
14. **Risks and pre-mortem** — Technical, commercial, adoption, AI disruption, competitive.
15. **Recommended positioning** — What the product should become and for whom.
16. **Strategic scenarios** — See below.
17. **Strategic roadmap** — Explore / build / validate / abandon, with kill criteria.
18. **Final answers** — Direct answers to the final questions.
19. **Open questions** — Most important unanswered questions.
20. **Progress** — Completed areas, remaining work, next step.
21. **Sources** — All external sources with access date.

## Assessment principles

- Brutally honest, but constructive.
- Evidence over intuition.
- Do not confuse technical novelty with market value.
- Do not recommend features because they are interesting to implement.
- A larger feature set is not automatically a better product.
- Account for adoption, migration and switching costs.
- State explicitly where the product is behind established competitors.
- Separate short-term opportunities from long-term ambitions.
- Do not invent customer demand, market statistics or competitor limitations.
- Cite sources for important market and competitor claims.
- Label assumptions and areas with insufficient evidence.
- Treat AI as both an opportunity and an existential threat.
- Do not assume today's AI capabilities or protocols stay unchanged.
- Separate demonstrated capabilities from speculation.
- Consider the reality of a solo developer or small team: time, focus, go-to-market capacity.

## Strategic scenarios

Describe at least three scenarios. Defaults (the brief may rename or redefine them):

1. **Conservative evolution** — A better version of an established product category, competing head-on with
   incumbents.
2. **Ambitious differentiation** — A new kind of product in the category, built on the product's most distinctive
   ideas.
3. **AI-native transformation** — Infrastructure and/or authoring environment designed for both humans and AI agents,
   integrated into agent ecosystems and AI-generated applications.

Add a fourth scenario if the investigation finds a more compelling direction (for example a narrow niche, an embedded
component, open-source core with paid services, or abandoning the product).

For each scenario: product vision, target customers, competitive positioning, required capabilities, architectural
implications, development investment, main risks, commercial potential, why it might succeed or fail, and **kill
criteria** (what evidence within 3–6 months should make me stop).

## Final questions

Answer directly, without hedging beyond what the evidence requires:

1. Starting today, knowing what you now know, would you build this product?
2. Is the product's core technical bet (from the brief) still worth the investment?
3. Would you build the same kind of product, a different kind, an AI-native product, or something fundamentally
   different?
4. What is the role of this product's approach in a world where AI agents can generate and run programs?
5. Could the product become an important component in the AI agent ecosystem?
6. What is the smallest product that could demonstrate real market demand?
7. What should I stop building, even if it is technically interesting?
8. What would you build first to maximize the probability of commercial success?
9. What evidence, in the next 3 months, would change your recommendation?

The conclusion must be able to drive real architectural and product decisions, even if it challenges the original
vision.

## Iterative execution and persistence

The investigation may exceed one context window or session. Work iteratively.

1. Start by reading the brief and the latest prospect document. Preserve valuable earlier research and conclusions.
2. Split the investigation into independent research areas (sections 1–10 above).
3. After finishing each area, update the relevant document sections immediately. Do not wait until the end.
4. Keep conclusions, evidence, sources, assumptions and open questions in the document.
5. Mark findings as **confirmed** or **preliminary**.
6. Maintain the Progress section: completed areas, remaining work, next recommended step.
7. Update sections incrementally. Do not rewrite the whole document each time.
8. After context loss or in a new session, read the document first and resume from the recorded progress.
9. Reassess earlier conclusions when new evidence contradicts them; record what changed and why.
10. Build the SWOT/TOWS, scenarios and final answers only after the evidence sections are at least preliminary.
11. Do not mark the investigation complete because one area is done.
12. End each session with all findings and progress saved to disk.

**The prospect document is the persistent source of truth, not the conversation.** Never keep important findings only
in conversation history.
