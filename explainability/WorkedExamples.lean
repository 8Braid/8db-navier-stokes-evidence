import «8DB-OpenAI-Covariance-Lemma»
import Mathlib.Tactic.NormNum

/-!
Exact rational examples for the explanatory companion. These use the unchanged
public covariance definitions. They are finite-dimensional examples, not new
Navier-Stokes theorems. The browser drawing is not a proof checker.
-/
namespace EightDB.CandidateCovariance.Explanation
open EightDB.CandidateCovariance

theorem nominal_weights :
    numeratorPlus 0 0 (2/5) / determinant 0 0 0 0 = (3/10 : ℝ) ∧
    numeratorMinus 0 0 (2/5) / determinant 0 0 0 0 = (7/10 : ℝ) := by
  norm_num [numeratorPlus, numeratorMinus, determinant]

theorem perturbed_weights :
    numeratorPlus (-1/10) (-1/10) (3/5) /
      determinant (1/10) (-1/10) (1/10) (-1/10) = (1/5 : ℝ) ∧
    numeratorMinus (1/10) (1/10) (3/5) /
      determinant (1/10) (-1/10) (1/10) (-1/10) = (13/15 : ℝ) := by
  norm_num [numeratorPlus, numeratorMinus, determinant]

theorem outside_sufficient_box_but_positive :
    ¬ |(4/5 : ℝ)| ≤ 1-(2/5 : ℝ) ∧
    numeratorPlus 0 0 (4/5) / determinant 0 0 0 0 = (1/10 : ℝ) ∧
    numeratorMinus 0 0 (4/5) / determinant 0 0 0 0 = (9/10 : ℝ) := by
  norm_num [numeratorPlus, numeratorMinus, determinant]

theorem outside_fixed_cone_negative_weight :
    numeratorPlus 0 0 (6/5) / determinant 0 0 0 0 = (-1/10 : ℝ) ∧
    numeratorMinus 0 0 (6/5) / determinant 0 0 0 0 = (11/10 : ℝ) := by
  norm_num [numeratorPlus, numeratorMinus, determinant]

theorem outside_fixed_cone_no_nonnegative_solution (p q : ℝ)
    (hp : 0 ≤ p) (hfirst : p+q=1) : -p+q ≠ (6/5 : ℝ) := by
  linarith

end EightDB.CandidateCovariance.Explanation

#print axioms EightDB.CandidateCovariance.Explanation.nominal_weights
#print axioms EightDB.CandidateCovariance.Explanation.perturbed_weights
#print axioms EightDB.CandidateCovariance.Explanation.outside_sufficient_box_but_positive
#print axioms EightDB.CandidateCovariance.Explanation.outside_fixed_cone_negative_weight
#print axioms EightDB.CandidateCovariance.Explanation.outside_fixed_cone_no_nonnegative_solution
