# KMP/CMP Architecture Conventions

Project-specific conventions on top of `.ai/ARCHITECTURE.md` — not a
Kotlin Multiplatform tutorial. For general KMP/Compose Multiplatform
guidance, prefer JetBrains' own official documentation over anything
written here; this file only covers what's specific to how this harness
expects the project to be organized.

## commonMain-first
Default all new logic to `commonMain`. Something moves to a platform
source set (`androidMain`, `iosMain`, `desktopMain`) only when a specific
platform API forces it — not because it "might" need to differ later.
Speculative `expect`/`actual` splits are exactly the abstraction this
harness's principles warn against.

## expect/actual as a decision point
An `expect`/`actual` split is architectural, not mechanical:
- State the platform reason in the Technical Plan (an API only available on
  one target, not "just in case").
- If it establishes a new abstraction other code will follow (e.g. a
  platform-agnostic storage interface), write an ADR — this is a boundary
  other contributors will build on.
- A trivial `expect fun`/`actual fun` for something like a platform name
  string doesn't need an ADR; a new `expect class` defining a shared
  contract usually does.

## Source-set dependency direction
Platform source sets (`androidMain`, `iosMain`, `desktopMain`) depend on
`commonMain`, never the reverse. If `commonMain` needs something a
platform source set defines, that's the sign the `expect`/`actual`
boundary is in the wrong place.

## When this becomes an ADR
Same bar as the generic `technical-design/SKILL.md`: a new target, a new
`expect`/`actual` abstraction, or a changed source-set dependency is an
ADR. A new file inside an existing source set's existing package structure
isn't.
