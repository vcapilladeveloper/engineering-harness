# Coroutines & Flow — Decision Rules

Not a coroutines tutorial — prefer Kotlin's own official documentation for
how structured concurrency, `Flow`, and dispatchers work. This is about
which concurrency decisions in *this* codebase need human sign-off versus
which are safe for the agent to make locally, per the Cognitive Ownership
Rule (`portable-plugin/COGNITIVE_ENGINEERING.md`).

## Architectural (stop and ask)
- Introducing a new `CoroutineScope` outside the standard
  ViewModel/lifecycle-scoped ones the project already uses.
- Changing which `Dispatcher` a piece of shared logic runs on, if that logic
  is used by more than one caller — it can change behavior for callers that
  didn't ask for it.
- Choosing between `StateFlow`, `SharedFlow`, and a plain suspend function
  for exposing state from a new component — a real design decision, not a
  mechanical one.
- Anything that changes cancellation or error-propagation behavior across a
  module boundary.

## Local (implement freely within an approved plan)
- Using `suspend` functions and structured concurrency (`coroutineScope`,
  `async`/`await`) inside a function body whose scope was already decided
  in the Technical Plan.
- Collecting an existing `Flow` inside a `ViewModel`'s already-established
  scope.
- Straightforward `launch { }` for fire-and-forget work whose cancellation
  behavior isn't user-visible or architecturally significant.

If it's ambiguous which bucket a decision falls into, treat it as
architectural — a coroutine leak or a wrong dispatcher is a harder bug to
track down than the cost of a short question.
