# Explanation replay record

15 September 2026. This record concerns the covariance component and its worked examples, not a new replay of the complete Navier-Stokes proof.

## Formal checks

Executed `replay.sh` against a built Linux checkout of the released upstream source:

- Source commit: `f9e8bc5b38b6e212696e8a30e3e91517af887bbd`.
- Lean: `4.34.0-rc2`.
- Mathlib: `85e3a25e006c35636f0e53b0e9296caca2685bc0`.
- Workers: one.
- Exit code: zero.
- The unchanged covariance source was compiled to a fresh temporary object, then imported by `WorkedExamples.lean`.
- All seven original named declarations and all five new named declarations reported only `propext`, `Classical.choice`, and `Quot.sound`.

The full stdout of the captured run is [check.log](check.log). This is a local project replay, not an unaffiliated replication. It uses Lean; it does not run Comparator, nanoda, the private 8DB engine, or TKM.

## Exact source identities

| File | SHA256 |
|---|---|
| `../covariance/8DB-OpenAI-Covariance-Lemma.lean` | `1a654b9f6c0f92a71f990b4af482f48e6cb1dead960fb3c350944188ac1e5c87` |
| `WorkedExamples.lean` | `f4a17f9719c02605bf8bb7af1e77d8f24c34e791e7c1633afe052b5cffa71ad4` |
| `replay.sh` | `3ec6f53886f186a1ab056c0210879c250af3c0362c965a6cb09eff08c50dc464` |
| `check.log` | `f7e8cae65b3479f2b543f0bde894356011ed0ce83646152a13a969a0a79bd6e3` |

Root `SHA256SUMS` also covers the presentation and article. Hashes identify files; they are not mathematical evidence by themselves.

## Presentation checks

Headless Chrome exercised all four presets and checked their displayed statuses and weights against the exact examples. A slider change removed the named-preset qualification. Layout checks covered 320, 360, 736 and 1024 pixel widths. No page-level horizontal overflow or JavaScript errors were found. The final narrow and wide layouts were also visually inspected.

These are interface checks. Floating-point display values are not outward enclosures or an independent proof checker. No reader-comprehension study has been conducted.

## Rerun and capture a new log

`replay.sh` writes to stdout. The included `check.log` is the archived publication run. To capture your own run without overwriting it:

```bash
set -o pipefail
UPSTREAM_ENV=/path/to/pinned/upstream bash replay.sh 2>&1 | tee local-replay.log
```

The script's exact source and environment guards must pass. Its temporary compilation directory is removed when it exits.
