# Navier-Stokes covariance proof companion

**New: [understand the covariance argument](explainability/README.md).** The companion includes an offline interactive diagram, four contrasting cases, five additional Lean-checked statements, and a map from the explanation to the original proof. [Read the article: The proof passed. Can you see why it works?](explainability/article.md) The examples distinguish failure of a sufficient bound from an exact obstruction for fixed columns. This explains one component, not the complete Navier-Stokes construction.

A small, runnable Lean proof accompanying the [companion article](https://8braid.com/journal/openai-navier-stokes-proof-meets-a-new-kind-of-database).

The work has three separate scopes:

1. **Upstream proof checks.** The article describes checks of the [public Navier-Stokes formalization](https://github.com/openai/NavierStokesAndEuler/tree/f9e8bc5b38b6e212696e8a30e3e91517af887bbd). Those checks concern the upstream development. A [sanitized historical replay receipt](formal-replay/receipt.json) records the Windows and Linux outcomes, exact source and runtime identities, and the hashes of the sealed original records. It is a summary, not a full upstream replay kit. The separate compilation receipt in `covariance/` concerns the standalone lemma below.
2. **A runnable covariance lemma.** [The Lean source](covariance/8DB-OpenAI-Covariance-Lemma.lean) proves a sufficient normalized error margin for positive inverse weights, over arbitrary real parameters. The [actual compilation receipt](covariance/verification.json), [seven printed axiom reports](covariance/public-check.log), and [earlier check output](covariance/original-check.log) are included.
3. **A native evidence experiment.** The article separately describes representing and checking evidence in a database. The database engine is not included here, so this repository does not reproduce that native experiment.

For

```text
C = [[1+a, 1+b], [-1+c, 1+d]],    target = (1,s),
```

the lemma assumes `0 < m < 1`, entry errors `|a|, |b|, |c|, |d| <= m/4`, and `|s| <= 1-m`. It proves `det(C) >= 7/8 > 0`, positive Cramer weights, and exact target reconstruction. More general determinant, numerator, and quantitative weight bounds are also proved.

This is conditional normalized algebra. Applying it to the manuscript's actual fields requires separate analytic error estimates, positive physical scales and column masses, an orthonormal frame, and target-cone inclusion. Smooth extension at a zero-target edge requires additional flatness estimates. The attachment does not establish those premises or a full PDE theorem, and it does not certify a numerical improvement to the separate loop work.

The source connection is Proposition 7.5, printed pages 82 and 83 of the [public manuscript](https://cdn.openai.com/pdf/32d9f210-8b73-45e0-91bc-82a30aef8a9a/navier-stokes.pdf). The [manifest](covariance/manifest.json) records source pins and file hashes; [the covariance checksum list](covariance/SHA256SUMS) also covers the manifest.

## Check the attachment hashes

From the repository root in a Bash-compatible shell, run:

```bash
sha256sum --check SHA256SUMS
(cd covariance && tr -d '\r' < SHA256SUMS | sha256sum --check -)
```

The seven files in `covariance/` are byte-identical to the public proof attachment, including its manifest. Its checksum list retains its original CRLF line endings; the command normalizes only the list passed to the checker. The root checksum list additionally covers this README and the sanitized formal replay receipt. Matching hashes verify the recorded bytes; they do not replace a mathematical check. Git attributes preserve those bytes across platforms.

The receipt records successful Windows library, axiom and fresh Lean-kernel checks, and successful Linux Comparator, Nanoda and default-kernel checks. Preparing this companion verified the sealed archive and its manifest but did not rerun those checks. The complete transcripts, original source bundle and runtime binaries are not included here.

## Replay with the pinned environment

The public proof was compiled unchanged with Lean `4.34.0-rc2`, Mathlib `85e3a25e006c35636f0e53b0e9296caca2685bc0`, and one Lean worker. The recorded exit code is **0**. All seven axiom reports list exactly `propext`, `Classical.choice`, and `Quot.sound`.

From this repository's root, use an existing upstream checkout with its dependencies and compiled Mathlib imports already available. Set `UPSTREAM_ENV` to that checkout, then run in Bash:

```bash
set -eu
COVARIANCE_PROOF="$(pwd)/covariance/8DB-OpenAI-Covariance-Lemma.lean"
cd "$UPSTREAM_ENV"
test "$(git rev-parse HEAD)" = "f9e8bc5b38b6e212696e8a30e3e91517af887bbd"
test "$(tr -d '\r\n' < lean-toolchain)" = "leanprover/lean4:v4.34.0-rc2"
test "$(git -C .lake/packages/mathlib rev-parse HEAD)" = "85e3a25e006c35636f0e53b0e9296caca2685bc0"
LEAN_NUM_THREADS=1 lake env lean "$COVARIANCE_PROOF"
```

For an environment download recipe, see [the covariance attachment instructions](covariance/README.md), running those instructions from `covariance/`. This command checks the standalone proof with the Lean compiler/kernel. It does not run Comparator, Nanoda, or the database engine. The log contains the actual Windows compilation output; the receipt omits local machine paths.

No blanket license grant is added here. Third-party software and source material remain subject to their respective terms.
