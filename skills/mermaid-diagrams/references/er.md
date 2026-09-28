# ER Diagram

The persistence data model: tables, columns, and the relations between them.

- Entity and attribute names are the real table and column names.
- Mark keys with `PK` and `FK`. Label every relation with its meaning.

```mermaid
erDiagram
    SCENARIO ||--o{ RISK_SCORE : produces
    SCENARIO {
        uuid id PK
        string name
    }
    RISK_SCORE {
        uuid id PK
        uuid scenario_id FK
        double value
    }
```
