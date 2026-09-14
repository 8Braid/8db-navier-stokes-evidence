# A checked normalized covariance margin

This attachment contains an independent Lean proof of a sufficient algebraic condition for positive covariance weights. It concerns arbitrary real parameters throughout a stated box, not a finite numerical sample. The proof file is unchanged from the previously checked version.

For the normalized matrix and target

```text
C = [[1+a, 1+b], [-1+c, 1+d]],     target = (1,s),
```

assume `0 < m < 1`, `|a|, |b|, |c|, |d| <= m/4`, and `|s| <= 1-m`. The file proves that the determinant is positive and both Cramer weights are positive. Its quantitative ingredients are:

```text
rho = m/4
mu = m - rho*(2-m) >= m/2 > 0
det(C) >= 2 - 4*rho - 2*rho^2 >= 7/8 > 0
Nplus  = 1+d - (1+b)*s >= mu
Nminus = 1-c + (1+a)*s >= mu
wplus = Nplus/det(C),    wminus = Nminus/det(C)
C * (wplus,wminus) = (1,s).
```

The general lemmas also allow another radius `rho` when both lower margins remain strictly positive. Each weight then has the positive lower bound `mu/(2+4*rho+2*rho^2)`.

The `m/4` error allowance and `7/8` determinant gap apply to this normalized algebraic problem. They are not measured improvements to the full Navier-Stokes construction or to a previously published loop experiment. This file does not claim an optimal allowance or determinant bound.

## Relation to the public source

The motivating formulas are Proposition 7.5, printed pages 82 and 83, especially equations (7.24) and (7.28), in the [public manuscript](https://cdn.openai.com/pdf/32d9f210-8b73-45e0-91bc-82a30aef8a9a/navier-stokes.pdf). The inspected PDF has SHA-256 `0e779481c4da40bd28d1e642e1d8ca57447d129610df28dfa5a11e9af8ae228f`.

The public formalization was inspected at commit [`f9e8bc5b38b6e212696e8a30e3e91517af887bbd`](https://github.com/openai/NavierStokesAndEuler/tree/f9e8bc5b38b6e212696e8a30e3e91517af887bbd). Relevant source modules include [Covariance.lean](https://github.com/openai/NavierStokesAndEuler/blob/f9e8bc5b38b6e212696e8a30e3e91517af887bbd/NavierStokes/Covariance.lean), [PulseCovariance.lean](https://github.com/openai/NavierStokesAndEuler/blob/f9e8bc5b38b6e212696e8a30e3e91517af887bbd/NavierStokes/PulseCovariance.lean), and [PrimaryCovarianceBounds.lean](https://github.com/openai/NavierStokesAndEuler/blob/f9e8bc5b38b6e212696e8a30e3e91517af887bbd/NavierStokes/PrimaryCovarianceBounds.lean). Those references explain the source connection; this attachment does not import those modules.

To apply the normalized lemma to physical columns, write `Q = [N K]` for the ordered orthonormal frame and require positive scales `Ac`, `u`, `hplus`, and `hminus`. The normalization is

```text
C = diag(-1/Ac, 1/u) * transpose(Q) * H * diag(1/hplus, 1/hminus).
```

Here `H` is a nonsymmetric physical flux matrix. With the source frame orientation, `det(H) = -Ac*u*hplus*hminus*det(C)`. Thus positive normalized determinant corresponds to negative physical determinant, not positive definiteness of `H`.

For a nonzero target, set `p = -TN/Ac > 0` and `s = (TK/u)/p`. The physical squared-amplitude weights are `p*wplus/hplus` and `p*wminus/hminus`. A source vector-error bound `|e_sigma| <= E` implies the normalized entry box only after establishing `E <= rho*min(Ac,u)`.

The actual source profiles, uniform analytic error estimates, positive column masses, frame hypotheses, and target-cone inclusion remain separate obligations. At a zero target, the weights are zero; smooth extension of their square roots needs separate flatness estimates. The lemma alone proves neither those analytic premises nor a full PDE theorem. It makes no claim about database admission or a Rust implementation.

## Check the proof

Install Git and [elan](https://github.com/leanprover/elan), then run the following commands in a Bash-compatible shell from the extracted attachment directory. The checkout and its lockfile select Lean `4.34.0-rc2` and Mathlib commit `85e3a25e006c35636f0e53b0e9296caca2685bc0`. The Mathlib cache download supplies compiled imports; this recipe does not request a build of the Navier-Stokes theorem.

```bash
set -eu
git clone --no-checkout https://github.com/openai/NavierStokesAndEuler.git replay-environment
git -C replay-environment checkout --detach f9e8bc5b38b6e212696e8a30e3e91517af887bbd
cd replay-environment
export LEAN_NUM_THREADS=1
lake exe cache get
test "$(tr -d '\r\n' < lean-toolchain)" = "leanprover/lean4:v4.34.0-rc2"
test "$(git -C .lake/packages/mathlib rev-parse HEAD)" = "85e3a25e006c35636f0e53b0e9296caca2685bc0"
lake env lean --version
lake env lean ../8DB-OpenAI-Covariance-Lemma.lean
```

In PowerShell, use `$env:LEAN_NUM_THREADS = '1'` for the environment assignment and inspect `$LASTEXITCODE` immediately after the final command. The expected successful exit code is `0`. The file prints seven axiom reports, each listing exactly `propext`, `Classical.choice`, and `Quot.sound`.

The attached `public-check.log` is the actual output of one fresh compilation of the copied public proof in the existing pinned Windows environment, with `LEAN_NUM_THREADS=1`. `verification.json` records its exit code, tool version, pins, timestamps, and hashes. The fresh environment download recipe above was not separately run as part of this packaging check. `original-check.log` preserves the earlier check output unchanged. These checks use the Lean compiler/kernel; this attachment does not contain a Comparator or Nanoda run.

`manifest.json` identifies every payload file by size and SHA-256. `SHA256SUMS` additionally covers the manifest. Neither a matching hash nor a successful build establishes the unproved analytic premises stated above.

This package adds no blanket license grant. Third-party software and source material remain subject to their respective terms.
