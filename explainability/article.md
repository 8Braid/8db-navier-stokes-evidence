# The proof passed. Can you see why it works?

A proof checker can answer whether a conclusion follows from its formal premises. It cannot, by that fact alone, give a reader a reason they can hold in their head.

Stephen Wolfram explores that gap in [Who Can Understand the Proof?](https://writings.stephenwolfram.com/2025/01/who-can-understand-the-proof-a-window-on-formalized-mathematics/). His example is an automatically generated proof about the foundations of Boolean algebra. A correct sequence of deductions can remain difficult to understand even after its steps have been displayed or shortened.

Our work around OpenAI's released Navier-Stokes construction gave us a smaller place to start. We had replayed the authors' formal targets and separately developed a normalized covariance lemma. That lemma was already public, with Lean source and checking records. We have now added a worked explanation and an offline interactive companion.

The question we chose is modest: why can two positive contributions supply a particular target, even when their directions are slightly wrong?

## A piece of the proof you can draw

Imagine two available contributions, represented by the vectors (1,−1) and (1,1). We want positive weights that combine them into (1,s).

The first coordinate says the weights must add to one. The second says their difference must be s. The answer is therefore (1−s)/2 and (1+s)/2.

If s lies strictly between −1 and 1, both weights are positive. At an endpoint, one vanishes. Move beyond an endpoint and one must become negative.

That last change matters. In the intended construction the weights describe normalized squared amplitudes. A negative squared amplitude is not an available choice.

The next question is what happens when the two contribution vectors are perturbed. Our public lemma keeps the target a distance m from the endpoints and permits an error of at most m/4 in each matrix entry. It bounds the determinant and both Cramer numerators away from zero. The weights remain positive, and their combination reconstructs the target.

This is the idea a reader should retain: spare room around the target pays for uncertainty in the directions. The fraction one quarter is a sufficient allowance, not a claim of optimality.

## A failed bound is not a failed construction

The companion has four named examples. Two satisfy the sufficient condition. In a third, that condition fails but the weights are still positive. In the fourth, one weight is negative, and an exact argument rules out any nonnegative solution for those fixed columns and target.

We added Lean statements for the rational examples, including the final obstruction. The browser is an illustration, not a theorem prover. Readers can inspect the calculations, open the matching statements, and run the checks themselves.

The third example is as useful as the fourth. It shows why a system must distinguish “this certificate no longer applies” from “this mathematical possibility has been disproved.” An explanation that loses that distinction can be more misleading than a terse proof log.

## What this says about the larger problem

The local calculation relates to the covariance inversion used to realize stress in the forced Navier-Stokes construction. Turning it into a statement about the actual fields requires additional analytic estimates and geometric hypotheses. Those are listed beside the demonstration. Our replay of the authors' proof is not an independent derivation, and this companion does not explain every step of the singular construction.

For 8DB, this is a concrete product direction: keep the readable claim, its assumptions, its mathematical representation and its evidence connected as a researcher explores alternatives. The public companion works without the private database. It demonstrates the kind of presentation and scope discipline we want the larger system to support; it does not claim that the full evidence engine is included in this repository.

The next evaluation is about people. Can a reader predict the altered examples, reconstruct the small argument and find an omitted assumption more reliably with this companion? We have not run that study yet. A checked proof certifies the mathematics it states. Improved understanding needs its own evidence.

For now, the invitation is simple: [open the companion](README.md), change the target, and see which part of the reason survives.
