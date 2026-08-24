# Multiplatform Coroutines — Decision Rules

Not a coroutines tutorial — prefer Kotlin's own official documentation for
how structured concurrency and dispatchers work, and JetBrains' KMP docs for
platform threading specifics. This is about which concurrency decisions in
*this* codebase need human sign-off versus which are safe for the agent to
make locally, per the Cognitive Ownership Rule
(`portable-plugin/COGNITIVE_ENGINEERING.md`).

## Architectural (stop and ask)
- Introducing a new shared `CoroutineScope` in `commonMain`, or changing
  how an existing one is managed across platforms.
- Choosing a dispatcher strategy that behaves differently per platform
  (e.g. `Dispatchers.Default` vs a platform-specific dispatcher via
  `expect`/`actual`) — this is exactly the kind of platform-specific
  concurrency decision that belongs in a Technical Plan, not inline.
- Exposing new shared state via `StateFlow`/`SharedFlow` from `commonMain`
  that multiple platform UIs will consume.
- Anything that changes cancellation or error-propagation behavior across
  the `commonMain`/platform boundary.

## Local (implement freely within an approved plan)
- Using `suspend` functions and structured concurrency inside a
  `commonMain` function whose scope was already decided in the Technical
  Plan.
- Collecting an existing shared `Flow` from platform-specific UI code
  (Compose, SwiftUI via the generated framework) using each platform's
  normal collection mechanism.

If it's ambiguous which bucket a decision falls into, treat it as
architectural — a dispatcher mismatch between platforms is a much harder
bug to track down than the cost of a short question.
