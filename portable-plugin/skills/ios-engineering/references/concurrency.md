# Swift Concurrency — Decision Rules

Not a Swift Concurrency tutorial — prefer Apple's own documentation for how
actors, `Sendable`, and structured concurrency work. This is about which
concurrency decisions in *this* codebase need human sign-off versus which
are safe for the agent to make locally, per the Cognitive Ownership Rule
(`portable-plugin/COGNITIVE_ENGINEERING.md`).

## Architectural (stop and ask)
- Introducing a new actor, or changing what an existing actor isolates.
- Changing a type's `Sendable` conformance in a way that changes its public
  contract (e.g. making a previously-`Sendable` type non-`Sendable`, or vice
  versa where callers rely on the guarantee).
- Choosing between actor isolation, a serial queue, and a lock for a new
  piece of shared mutable state — this is a design decision with real
  trade-offs, not a mechanical choice.
- Anything that changes where work runs relative to the main actor in a way
  that's user-visible (e.g. moving work that updates UI off the main actor).

## Local (implement freely within an approved plan)
- Adding `async`/`await` to a function whose isolation was already decided
  in the Technical Plan.
- Using structured concurrency (`async let`, task groups) inside a function
  body when the plan already specifies the target actor/isolation.
- Straightforward `Task { }` usage for fire-and-forget work whose isolation
  and cancellation behavior isn't user-visible or architecturally
  significant.

If it's ambiguous which bucket a decision falls into, treat it as
architectural — the cost of a short question is much lower than the cost of
a concurrency bug that's hard to reproduce.
