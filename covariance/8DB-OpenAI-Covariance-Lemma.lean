import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

/-!
Our independent normalized covariance lemma, over arbitrary real parameters.

The matrix is C = [[1+a,1+b],[-1+c,1+d]], with target (1,s).
Its physical interpretation requires an orthonormal (N,K) frame, positive
physical row scales and column weights, and the stated normalized error box.
This file does not establish those analytic/source-membership hypotheses,
the manuscript's selected profiles, pulse estimates, or flat-edge extension.
It is not a proof of the original Navier--Stokes construction.
-/

namespace EightDB.CandidateCovariance

def determinant (a b c d : ℝ) : ℝ := (1+a)*(1+d)-(1+b)*(-1+c)
def numeratorPlus (b d s : ℝ) : ℝ := 1+d-(1+b)*s
def numeratorMinus (a c s : ℝ) : ℝ := 1-c+(1+a)*s
def numeratorLower (m ρ : ℝ) : ℝ := m-ρ*(2-m)
def determinantLower (ρ : ℝ) : ℝ := 2-4*ρ-2*ρ^2
def determinantUpper (ρ : ℝ) : ℝ := 2+4*ρ+2*ρ^2

private theorem product_bounds {x y r q : ℝ}
    (hx : |x| ≤ r) (hy : |y| ≤ q) : -(r*q) ≤ x*y ∧ x*y ≤ r*q := by
  have hr : 0 ≤ r := (abs_nonneg x).trans hx
  have h : |x*y| ≤ r*q := by
    rw [abs_mul]
    exact mul_le_mul hx hy (abs_nonneg y) hr
  exact abs_le.mp h

/-- Both determinant bounds hold throughout the complete four-entry box. -/
theorem determinant_bounds {a b c d ρ : ℝ}
    (ha : |a| ≤ ρ) (hb : |b| ≤ ρ) (hc : |c| ≤ ρ) (hd : |d| ≤ ρ) :
    determinantLower ρ ≤ determinant a b c d ∧
      determinant a b c d ≤ determinantUpper ρ := by
  obtain ⟨hal, hau⟩ := abs_le.mp ha
  obtain ⟨hbl, hbu⟩ := abs_le.mp hb
  obtain ⟨hcl, hcu⟩ := abs_le.mp hc
  obtain ⟨hdl, hdu⟩ := abs_le.mp hd
  obtain ⟨hadl, hadu⟩ := product_bounds ha hd
  obtain ⟨hbcl, hbcu⟩ := product_bounds hb hc
  constructor <;> dsimp [determinantLower, determinantUpper, determinant] <;> nlinarith

/-- The slope interval stays inside both perturbed Cramer half-planes. -/
theorem numerator_bounds {a b c d s m ρ : ℝ}
    (ha : |a| ≤ ρ) (hb : |b| ≤ ρ) (hc : |c| ≤ ρ) (hd : |d| ≤ ρ)
    (hs : |s| ≤ 1-m) :
    numeratorLower m ρ ≤ numeratorPlus b d s ∧
      numeratorLower m ρ ≤ numeratorMinus a c s := by
  obtain ⟨hcl, hcu⟩ := abs_le.mp hc
  obtain ⟨hdl, hdu⟩ := abs_le.mp hd
  obtain ⟨hsl, hsu⟩ := abs_le.mp hs
  obtain ⟨hbslo, hbshi⟩ := product_bounds hb hs
  obtain ⟨haslo, hashi⟩ := product_bounds ha hs
  constructor <;> dsimp [numeratorLower, numeratorPlus, numeratorMinus] <;> nlinarith

/-- Strict robust margins imply positive normalized squared-amplitude weights. -/
theorem positive_weights {a b c d s m ρ : ℝ}
    (ha : |a| ≤ ρ) (hb : |b| ≤ ρ) (hc : |c| ≤ ρ) (hd : |d| ≤ ρ)
    (hs : |s| ≤ 1-m) (hμ : 0 < numeratorLower m ρ)
    (hD : 0 < determinantLower ρ) :
    0 < determinant a b c d ∧
      0 < numeratorPlus b d s / determinant a b c d ∧
      0 < numeratorMinus a c s / determinant a b c d := by
  have hdet := determinant_bounds ha hb hc hd
  have hnum := numerator_bounds ha hb hc hd hs
  have hpos : 0 < determinant a b c d := hD.trans_le hdet.1
  exact ⟨hpos, div_pos (hμ.trans_le hnum.1) hpos,
    div_pos (hμ.trans_le hnum.2) hpos⟩

/-- The same bounds give a positive quantitative lower bound for each weight. -/
theorem quantitative_weights {a b c d s m ρ : ℝ}
    (ha : |a| ≤ ρ) (hb : |b| ≤ ρ) (hc : |c| ≤ ρ) (hd : |d| ≤ ρ)
    (hs : |s| ≤ 1-m) (hμ : 0 < numeratorLower m ρ)
    (hD : 0 < determinantLower ρ) :
    0 < numeratorLower m ρ / determinantUpper ρ ∧
      numeratorLower m ρ / determinantUpper ρ ≤
        numeratorPlus b d s / determinant a b c d ∧
      numeratorLower m ρ / determinantUpper ρ ≤
        numeratorMinus a c s / determinant a b c d := by
  have hdet := determinant_bounds ha hb hc hd
  have hnum := numerator_bounds ha hb hc hd hs
  have hpos : 0 < determinant a b c d := hD.trans_le hdet.1
  have hupper : 0 < determinantUpper ρ := hpos.trans_le hdet.2
  have lower {n : ℝ} (hn : numeratorLower m ρ ≤ n) :
      numeratorLower m ρ / determinantUpper ρ ≤ n / determinant a b c d := by
    apply (div_le_div_iff₀ hupper hpos).2
    exact (mul_le_mul_of_nonneg_left hdet.2 hμ.le).trans
      (mul_le_mul_of_nonneg_right hn hupper.le)
  exact ⟨div_pos hμ hupper, lower hnum.1, lower hnum.2⟩

/-- These weights reconstruct the normalized target (1,s), with fixed column order. -/
theorem cramer_reconstruction (a b c d s : ℝ) (hD : determinant a b c d ≠ 0) :
    (1+a)*(numeratorPlus b d s / determinant a b c d) +
        (1+b)*(numeratorMinus a c s / determinant a b c d) = 1 ∧
      (-1+c)*(numeratorPlus b d s / determinant a b c d) +
        (1+d)*(numeratorMinus a c s / determinant a b c d) = s := by
  constructor <;> field_simp [hD] <;>
    dsimp [numeratorPlus, numeratorMinus, determinant] <;> ring

/-- Choosing rho=m/4 closes the two robust margins for every 0<m<1. -/
theorem quarter_margin {m : ℝ} (hm : 0 < m) (hm1 : m < 1) :
    0 < m/4 ∧ m/2 ≤ numeratorLower m (m/4) ∧
      (7/8 : ℝ) ≤ determinantLower (m/4) ∧
      0 < numeratorLower m (m/4) ∧ 0 < determinantLower (m/4) := by
  have hμ : m/2 ≤ numeratorLower m (m/4) := by
    dsimp [numeratorLower]
    nlinarith [sq_nonneg m]
  have hprod : 0 ≤ (1-m)*(1+m) := mul_nonneg (by linarith) (by linarith)
  have hD : (7/8 : ℝ) ≤ determinantLower (m/4) := by
    dsimp [determinantLower]
    nlinarith
  exact ⟨by linarith, hμ, hD, by linarith, by linarith⟩

/-- The quarter-margin specialization, still conditional on the entry/slope box. -/
theorem quarter_margin_positive_weights {a b c d s m : ℝ}
    (hm : 0 < m) (hm1 : m < 1)
    (ha : |a| ≤ m/4) (hb : |b| ≤ m/4)
    (hc : |c| ≤ m/4) (hd : |d| ≤ m/4) (hs : |s| ≤ 1-m) :
    0 < determinant a b c d ∧
      0 < numeratorPlus b d s / determinant a b c d ∧
      0 < numeratorMinus a c s / determinant a b c d := by
  obtain ⟨_, _, _, hμ, hD⟩ := quarter_margin hm hm1
  exact positive_weights ha hb hc hd hs hμ hD

end EightDB.CandidateCovariance

#print axioms EightDB.CandidateCovariance.determinant_bounds
#print axioms EightDB.CandidateCovariance.numerator_bounds
#print axioms EightDB.CandidateCovariance.positive_weights
#print axioms EightDB.CandidateCovariance.quantitative_weights
#print axioms EightDB.CandidateCovariance.cramer_reconstruction
#print axioms EightDB.CandidateCovariance.quarter_margin
#print axioms EightDB.CandidateCovariance.quarter_margin_positive_weights
