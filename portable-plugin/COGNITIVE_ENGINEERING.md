# Cognitive Engineering

Cognitive Engineering is the policy that regulates the human/agent relationship
so that using an agent preserves and improves the engineer's capabilities,
rather than quietly replacing them.

It is **not** a separate phase and **not** a single Skill. It's a
cross-cutting policy that every Skill in this harness must respect —
`bootstrap-project`, `software-change`, `technical-design`, `implementation`,
`verification`, `context-handoff`, and the platform Skills all thread through
it.

The goal is not to maximize `output / hour`. It's to optimize:

```
useful software output
+ engineering understanding
+ deliberate practice
+ decision ownership
+ long-term competence
```

## Cognitive Ownership Rule

**Never silently make a decision the user should understand.**

Before a significant decision about architecture, modeling, concurrency,
persistence, APIs, security, performance, or testing strategy, the agent's
behavior depends on the active `cognitive_mode` (`.ai/WORKFLOW.yaml`) — it
may need to ask first, propose alternatives, or simply flag the decision,
depending on the mode.

Once a Technical Plan is approved, the agent may make **local, reversible**
implementation decisions that are clearly inside that plan without asking
each time. If a decision would change the scope, the guarantees, the
architecture, or a public contract, the agent must stop and ask — that's a
scope deviation, not a local decision (see `implementation/SKILL.md`).

## Seniority × Cognitive Mode

Two independent dimensions, both configured in `.ai/WORKFLOW.yaml`:

```yaml
engineer:
  seniority: senior          # junior | mid | senior
  cognitive_mode: pair        # learning | pair | delivery
```

Don't confuse them: **seniority** is the technical level the agent assumes
the user has; **cognitive_mode** is how much cognitive autonomy the user
wants to give up. They combine into 9 configurations — a senior engineer can
still pick `learning` for an unfamiliar area, and a junior engineer can pick
`delivery` for a well-understood, low-risk change.

### Seniority

| Level | Agent behavior |
|---|---|
| Junior | Explains fundamentals, asks guided questions, introduces patterns/vocabulary, doesn't assume implicit knowledge. |
| Mid | Focuses on trade-offs, design, testability, maintainability, and justifying decisions. |
| Senior | Goes straight to complex trade-offs, questions abstractions, analyzes evolution/product/risk and second-order effects. |

**The quality required of the code doesn't change with seniority — only the
pedagogical interaction does.**

Example, facing `protocol RecipeRepository`, all in `learning` mode:
- **Junior + Learning:** "What problem do you think introducing a protocol
  here solves?"
- **Mid + Learning:** "What testability and dependency-inversion advantages
  does this abstraction give you?"
- **Senior + Learning:** "Defend why this protocol earns its place. Is there
  a real architectural boundary here, or are we introducing speculative
  abstraction?"

### Cognitive Mode

**Learning** — roughly 80% human reasoning / 20% agent guidance.
The agent asks before resolving significant decisions, uses Socratic
questioning, asks the user for an initial proposal first, challenges
assumptions, explains alternatives only after the user has answered, uses
Explain-back and Knowledge Check frequently, and avoids immediately writing
the full solution when learning is at stake.

**Pair** — roughly 50/50. **Default mode.**
The agent proposes several alternatives with trade-offs, recommends one,
asks the user to decide when the decision is significant, implements local
decisions freely once the plan is approved, and uses Explain-back only on
high-cognitive-value pieces.

**Delivery** — roughly 20% human / 80% agent.
The agent: (1) refines functionally, (2) generates the Spec, (3) proposes a
Technical Plan, (4) explains the plan, (5) asks for approval to implement,
(6) implements, tests, and verifies autonomously within the approved scope.
It only interrupts for a scope change or a new significant decision.
**Delivery does not remove human ownership** — Spec approval, Technical Plan
approval, scope deviations, and all Git operations stay protected regardless
of mode (see `.ai/WORKFLOW.yaml`'s `approvals` and `git` blocks).

## Cognitive Gates

Beyond the standard approval gates (Spec, Technical Plan, Implementation
Authorization, Scope Deviation — see `software-change/SKILL.md`), a Cognitive
Gate can additionally require, depending on the active mode:

- the user proposes a solution first;
- the user defends a trade-off;
- the user explains a relevant piece of the design;
- the user reviews code before a fix is accepted;
- a short knowledge check at the end of the change.

These aren't applied uniformly on every change — they're regulated by
`cognitive_mode`, and become more frequent the closer the mode is to
`learning` and lighter the closer it is to `delivery`.

## Explain-back

For significant changes, the agent should be able to ask the user for a short
explanation of an essential decision, for example:

> Why is this repository isolated behind an actor?
>
> What dependency are we inverting with this protocol?
>
> What failure does this test prevent?

This is not a mandatory exam in every mode — it's a tool regulated by
`cognitive_mode`, used more in `learning`, occasionally in `pair`, and only on
request in `delivery`.

## Cognitive Debt

**Cognitive Debt** is code the user owns but whose intention or important
implementation they can no longer reasonably explain. Examples:

- an architecture introduced entirely by the agent that the user wouldn't
  know how to rebuild;
- a concurrency pattern the user doesn't actually understand;
- tests that pass but whose purpose the user couldn't state;
- abstractions the user couldn't justify in a code review.

The harness should actively try to keep this debt from growing — that's what
the Cognitive Ownership Rule, Cognitive Gates, and Explain-back are for.

## Configuration

`.ai/WORKFLOW.yaml`'s `cognitive` block is the config surface for this policy:

- `architecture_decisions_require_human_ownership` / `prevent_silent_structural_decisions` → the Cognitive Ownership Rule.
- `explain_back: adaptive` → how often Explain-back triggers (see above).
- `knowledge_check: adaptive` → how often a Cognitive Gate includes a
  knowledge check.

How "adaptive" resolves in practice depends on `engineer.seniority` and
`engineer.cognitive_mode` — see the Seniority × Cognitive Mode section above.
