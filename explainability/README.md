# Why two positive contributions are enough

This is a worked explanation of the [covariance lemma already in this repository](../covariance/8DB-OpenAI-Covariance-Lemma.lean). It adds a picture, exact examples, and a map from the explanation to the checked statements. It does not replace the proof.

Open [index.html](index.html) in a browser after cloning or downloading this repository. It runs offline with no account, database, TKM service or network dependency. The drawing uses floating-point arithmetic and labels its calculations accordingly. The all-parameter guarantee comes from the existing Lean lemma. Five additional [Lean statements](WorkedExamples.lean) check the displayed rational examples and one exact obstruction.

## First remove the perturbations

Suppose two available contributions point in directions

\[
c_+=(1,-1),\qquad c_-=(1,1).
\]

We want their sum to equal \((1,s)\), using positive weights. Writing the weights as \(p,q\) gives two simple equations:

\[
p+q=1,\qquad -p+q=s.
\]

Therefore

\[
p=(1-s)/2,\qquad q=(1+s)/2.
\]

When \(-1<s<1\), both are positive. At either endpoint one is zero. Beyond an endpoint one is negative, so this fixed pair cannot produce the target with nonnegative weights. This is the cone geometry behind the calculation. The column labels follow the existing Lean file; the subscript on a column does not denote the sign of its second coordinate.

Positive weights matter in the intended application because they represent normalized squared amplitudes. A negative answer to the linear equations cannot be used as a real squared amplitude. The precise connection to the physical construction still requires the hypotheses listed below.

## Now allow errors in both columns

The checked lemma uses

\[
C=\begin{pmatrix}1+a&1+b\\-1+c&1+d\end{pmatrix}.
\]

Cramer's rule gives the unique weights when the determinant is nonzero. Define

\[
D=\det C,\quad n_+=1+d-(1+b)s,\quad n_-=1-c+(1+a)s.
\]

Then \(p=n_+/D\) and \(q=n_-/D\). Understanding the proof amounts to understanding why these three quantities stay positive.

Keep the target away from the endpoints by \(m\), so \(|s|\leq1-m\), with \(0<m<1\). If each entry error is at most \(\rho\), the proof bounds

\[
n_\pm\geq m-\rho(2-m),\qquad D\geq2-4\rho-2\rho^2.
\]

Taking \(\rho=m/4\) keeps both numerators at least \(m/2>0\), and the determinant at least \(7/8>0\). The target's spare room pays for the column errors. This is a sufficient bound, not a claim that one quarter is optimal.

## Four cases readers can inspect

| Case | Parameters | Exact weights | Meaning |
|---|---|---|---|
| Nominal | \(m=2/5,s=2/5\), no entry errors | \(3/10,7/10\) | The sufficient theorem applies. |
| Perturbed | \(m=2/5,s=3/5\), \((a,b,c,d)=(1,-1,1,-1)/10\) | \(1/5,13/15\) | The theorem still applies at the permitted error boundary. |
| Outside the sufficient box | \(m=2/5,s=4/5\), no entry errors | \(1/10,9/10\) | The selected sufficient condition fails, but the weights remain positive. |
| Outside this fixed cone | \(m=2/5,s=6/5\), no entry errors | \(-1/10,11/10\) | No nonnegative weights solve the fixed two-column equations. |

The third case is essential. A failed sufficient bound is not a counterexample. The fourth is an actual obstruction for the stated columns and target. It does not disprove the full PDE construction or all alternative pulse choices.

## From explanation to evidence

| Explanatory step | Checked declaration in the original lemma |
|---|---|
| Columns remain independent | `determinant_bounds` |
| Target stays on the positive side of both boundaries | `numerator_bounds` |
| Positive numerators and determinant give positive weights | `positive_weights` |
| Weights reconstruct the target | `cramer_reconstruction` |
| Choosing an error budget of \(m/4\) is sufficient | `quarter_margin`, `quarter_margin_positive_weights` |

The definitions and assumptions are part of the explanation. The five new declarations in `WorkedExamples.lean` check individual examples; they do not upgrade a sampled plot into a uniform theorem.

## Connection to Navier-Stokes

This normalized calculation concerns the covariance inversion in Proposition 7.5 of the [released manuscript](https://cdn.openai.com/pdf/32d9f210-8b73-45e0-91bc-82a30aef8a9a/navier-stokes.pdf), printed pages 82–83. Applying it to the constructed fields requires an orthonormal frame, positive physical row scales and column masses, the analytic entry-error bounds, and target-cone inclusion. Smooth extension at a zero-target edge requires additional flatness estimates. The public algebraic lemma does not establish those premises.

The full released theorem concerns a chosen smooth external force. Our historical replay is a replay of the authors' proof, not an independent derivation. This companion explains one reusable algebraic component, not the entire singular field.

## Replay

Use the pinned upstream environment described in the [repository README](../README.md). With its compiled Mathlib available, run `replay.sh` from this directory, setting `UPSTREAM_ENV` to the upstream checkout. The script compiles the unchanged covariance source into a temporary directory, then checks `WorkedExamples.lean` against it. The included `check.log` is our archived run; the script writes new results to stdout. `REPLAY.md` records the scope, source hashes and an output-capture command. This command does not run Comparator or nanoda.

An explanation is useful if a reader can predict a changed case, identify the relevant assumption, and find the supporting proof. We have not yet measured whether this companion improves reader comprehension. That is a separate evaluation, not a property conferred by a proof checker.
