# When a proof's assumptions change, what still holds?

**An interactive, Lean-checked example from Navier-Stokes research, built by 8Braid.**

A bound can fail while the result it was meant to guarantee still holds. Our public proof companion lets you explore that difference, see a case where the equations really do rule out the target, and inspect the formal statements behind both outcomes.

**[Open the interactive example](https://8braid.github.io/8db-navier-stokes-evidence/explainability/)** · [Read the explanation](explainability/article.md) · [Inspect the proof](covariance/8DB-OpenAI-Covariance-Lemma.lean)

![Three exact cases: the guarantee applies; the bound fails but positive weights survive; the fixed equations have an obstruction.](explainability/three-cases.svg)

The example explains one algebraic component of OpenAI's smoothly forced Navier-Stokes construction. It pairs a standalone Lean lemma with four worked cases, five additional checked statements, and recorded verification evidence. The mathematical scope and replay requirements are [documented separately](VERIFICATION.md).

## Try a change and follow the evidence

Start with **“Bound fails, weights work.”** Two contributions still combine positively to reach the target, even though the selected sufficient guarantee no longer covers it. Then choose **“Negative weight.”** For those fixed inputs, an exact proof rules out every nonnegative solution.

| Outcome | What the example establishes | Why the distinction matters |
|---|---|---|
| The guarantee applies | The stated assumptions ensure positive weights and exact reconstruction. | You can use the theorem within its domain. |
| The guarantee stops applying | A named example still has positive weights, checked directly. | Losing one argument does not refute the result. |
| The fixed equations have an obstruction | A named example admits no nonnegative solution. | Those inputs must change for the construction to work. |

The browser illustrates the calculation with floating-point values. Lean supplies the general theorem and the exact named examples. Moving the slider does not run a proof checker.

**Offline option:** [download the repository](https://github.com/8Braid/8db-navier-stokes-evidence/archive/refs/heads/main.zip), unzip it and open `explainability/index.html`. The interactive calculation runs locally without an account or a private 8DB service. Source links open GitHub.

## Who can use this?

- **Researchers and technical reviewers:** follow a claim from its assumptions to its formal statement and checking record. Start with the [explanation-to-proof map](explainability/README.md#from-explanation-to-evidence).
- **Developers of mathematical AI:** use the exact examples to test whether an agent distinguishes an unsupported inference from a counterexample. These are small test fixtures; they are not a benchmark of general mathematical ability.
- **Readers curious about AI-assisted mathematics:** explore the picture first. The explanation starts with two linear equations, so you can understand the mechanism without first learning fluid dynamics or Lean.

## Why 8Braid is doing this

Research changes. An estimate improves, a premise is withdrawn, or an AI proposes a different construction. The useful question is then: **which conclusions still have a complete, valid argument?**

Our database, [8DB](https://8braid.com/), is being developed to keep claims, their joint premises, derivations and checking evidence connected as that work evolves. The aim is to make a result's support inspectable and reusable, and to make the effect of a changed premise explicit.

This repository publishes a small worked example of that discipline. You can inspect the mathematical evidence and its explanation here. The private database engine and its native evidence experiment have a separate implementation and are not reproduced by this companion. [The project article](https://8braid.com/journal/openai-navier-stokes-proof-meets-a-new-kind-of-database) describes that wider work.

For a research team, the potential benefit is less repeated checking and fewer unsupported conclusions as a project changes. That is a value proposition to test with users, not a measured productivity result from this example.

## How this connects to Navier-Stokes

The lemma concerns covariance inversion in Proposition 7.5 of the [released manuscript](https://cdn.openai.com/pdf/32d9f210-8b73-45e0-91bc-82a30aef8a9a/navier-stokes.pdf), printed pages 82–83. Positive weights matter because they represent normalized squared amplitudes in the intended construction.

Applying this algebra to the actual fluid fields requires additional analytic and geometric premises. The lemma establishes the normalized algebra; the full PDE argument remains separate. The repository also preserves a historical summary of our checks of the authors' released formalization. [See the exact scope, assumptions and receipts](VERIFICATION.md).

## Inspect or extend the work

| Your next step | Start here |
|---|---|
| Understand the argument | [Short article](explainability/article.md) and [worked examples](explainability/README.md) |
| Reproduce the formal checks | [Pinned environment and replay instructions](VERIFICATION.md#replay-with-the-pinned-environment), then [example replay](explainability/REPLAY.md) |
| Check the recorded file identities | [Checksum instructions](VERIFICATION.md#check-the-attachment-hashes) |
| See what an extension must demonstrate | [Research and usability roadmap](ROADMAP.md) |

**Bring one changed-assumption example from your work.** [Open an issue](https://github.com/8Braid/8db-navier-stokes-evidence/issues/new?template=changed-assumption.md) with the original claim, the assumption you would change, and the result you want to distinguish. A small public example is enough to start; please keep unpublished or confidential material private. The goal is to identify a useful next case for an inspectable proof companion.

Third-party sources retain their respective terms. This repository currently adds no blanket license grant; see [verification and reuse information](VERIFICATION.md).
