--import MyProject

import hyperstabilityES.lemmas.clumps_connected_induction
 --import hyperstabilityES.lemmas.SimpleGraph
set_option linter.unusedVariables false

open Classical
open Finset
open scoped BigOperators

namespace SimpleGraph


 set_option maxHeartbeats 600000

universe u
variable {V : Type u} {G : SimpleGraph V}
variable   [Fintype V]--[FinV: Fintype V]
variable  [DecidableRel G.Adj] --[DecG: DecidableRel G.Adj]
variable [Fintype (Sym2 V)]-- [FinV2: Fintype (Sym2 V)]
variable {p m κ pr h: ℕ}
variable {κPositive: κ >0}
variable {pPositive: p >0}
variable {mPositive: m >0}
variable {hPositive: h >0}
variable {prPositive: pr >0}
variable (iSub:Inhabited (Subgraph G))



lemma induction_clump_add_Hi_and_I_cut_dense_easier
{K1 K2: Clump G p m κ pr h}
--{HFam: Finset (Subgraph G)}
{q μ t k:ℕ }
{I: Set V}
(ht: t>0)
(μbiggerthanp: μ ≥ κ)
(hk1biggerthank: K1.k ≤  k)
(hk2biggerthank: K2.k ≤  k)
(hI: I⊆ BSetPlusM K1∩ BSetPlusM K2)
(Iorder: μ *I.toFinset.card≥ m)
(Iorderupperbound: 4*pr*I.toFinset.card≤ m)
(HFam: Finset (Subgraph G))
(hHisize: HFam.card=t)
(hHi: HFam⊆  K1.H∪ K2.H)
(qDef: q ≥  (κ^(7*t*Nat.factorial (100*k)))*μ^(4*t*t*k))
(pLarge: p≥ 20)
(mggpr: m≥ gg1 pr)
(prggp: pr ≥ gg2 p)
(hggp: h ≥ pr)
(κggh: κ ≥ gg1 h)
(mggμ: m≥ μ )

:
cut_dense G ((K1.Gr.induce (I∪ K1.C.verts)⊔ K2.Gr.induce (I∪ K2.C.verts))⊔ (sSup HFam: Subgraph G)) q:= by

apply induction_clump_add_Hi_and_I_cut_dense
exact κPositive
exact pPositive
repeat assumption
let t':ℕ :=t-1
have ht': t=t'+1:=by
  exact (Nat.sub_eq_iff_eq_add ht).mp rfl
rw[ht'] at hHisize
rw[ht'] at qDef
repeat assumption
have h1: t-1+1=t:=by
  exact Nat.sub_add_cancel ht
rw[h1]
exact qDef



lemma induction_clump_add_Hi_and_I_cut_dense_simplernumbers
{K1 K2: Clump G p m κ pr h}
--{HFam: Finset (Subgraph G)}
(q k k':ℕ )
{I: Set V}
(hk'_g_k: k'>k)
--(μbiggerthanp: μ ≥ κ)
(hk1biggerthank: K1.k ≤  k)
(hk2biggerthank: K2.k ≤  k)
(hI: I⊆ BSetPlusM K1∩ BSetPlusM K2)
(Iorder: (κ^(10*Nat.factorial (100*k))) *I.toFinset.card≥  m)
(Iorderupperbound: 4*pr*I.toFinset.card≤ m)
(HFam: Finset (Subgraph G))
--(hHisize: HFam.card= k')
(hHi: HFam⊆  K1.H∪ K2.H)
(qDef: q ≥  (κ^(Nat.factorial (100*k'))))
(hk'_le_2k: HFam.card≤  2*k)
(pLarge: p≥ 20)
(mggpr: m≥ gg1 pr)
(prggp: pr ≥ gg2 p)
(hggp: h ≥ pr)
(κggh: κ ≥ gg1 h)
(mggκ :m≥ gg2 κ )
(κggk: gg1 κ≥ k )
(HFamNonempty: HFam.Nonempty)
--(mggμ: m≥ μ )
:
cut_dense G ((K1.Gr.induce (I∪ K1.C.verts)⊔ K2.Gr.induce (I∪ K2.C.verts))⊔ (sSup HFam: Subgraph G)) q
:= by

let μ:ℕ :=(κ^(10*Nat.factorial (100*k)))
have μbiggerthanp: μ ≥ κ:= by
  dsimp[μ ]
  calc
  (κ^(10*Nat.factorial (100*k)))≥ κ^1:= by
    gcongr
    assumption
    refine Left.one_le_mul ?h.ha ?h.hb
    simp
    refine Nat.one_le_iff_ne_zero.mpr ?h.hb.a
    exact Nat.factorial_ne_zero (100 * k)

  _= κ :=by
    ring_nf




have Iorder: μ *I.toFinset.card≥  m:= by
  exact Iorder



let t:ℕ :=HFam.card
--have ht0: t=k+1:=by
--  exact rfl
have ht: t>0:= by
  dsimp[t]
  exact card_pos.mpr HFamNonempty
  --exact Nat.zero_lt_of_lt hk'_g_k
--rw[ht0.symm] at hHisize

have kPos:  k≥ 1:=by
  calc
    k≥ K1.k:= by
      assumption
    _≥ 1:= by
      apply Nat.one_le_of_lt
      exact K1.Nonemptyness

have qDefNew: q ≥  (κ^(7*t*Nat.factorial (100*k)))*μ^(4*t*t*k):=by
  calc
  q ≥  (κ^(Nat.factorial (100*k'))):=by
    exact qDef
  _≥ (κ^(Nat.factorial (100*(k+1)))):=by
    gcongr
    exact κPositive
    exact hk'_g_k
  _≥ (κ^(7*t*Nat.factorial (100*k)))*μ^(4*t*t*k):=by
    dsimp[μ ]
    simp
    rw [←Nat.pow_mul]
    rw[←Nat.pow_add]
    gcongr
    assumption
    calc
      7 * t * (100 * k).factorial + 10 * (100 * k).factorial * (4 * t * t * k)
      ≤7 * (2*k) * (100 * k).factorial + 10 * (100 * k).factorial * (4 * (2*k) * (2*k) * k)
      :=by
        gcongr
        --
      _≤ (100*1)*(100*k)*(100 * k).factorial+(100*1) * (100 * k).factorial * ((100*1) * (100*k) * (100*k) * (100*k)):=by
        gcongr
        repeat simp
        calc
          k=1*k:= by ring_nf
          _≤100*k:= by
            gcongr;simp
        --

      _≤ (100*k)*(100*k)*(100 * k).factorial+(100*k) * (100 * k).factorial * ((100*k) * (100*k) * (100*k) * (100*k)):=by
        gcongr

      _=(100*k)^2*(100 * k).factorial+(100*k)^5*(100 * k).factorial:= by
        ring_nf

      _≤(100*k)^5*(100 * k).factorial+(100*k)^5*(100 * k).factorial:= by
        gcongr
        refine Right.one_le_mul ?bc.bc.ha.ha kPos
        repeat simp
        --

      _=2*(100*k)^5*(100 * k).factorial:=by
        ring_nf
      _≤(100*1)*(100*k)^5*(100 * k).factorial:=by
        gcongr
        simp
      _≤(100*k)*(100*k)^5*(100 * k).factorial:=by
        gcongr


      _= (100 * k).factorial*(100*k)^6:=by
        ring_nf
      _≤(100 * k).factorial*(100*k+1)^6:=by
        gcongr
        calc
        100*k=100*k+0:=by ring_nf
        _≤ _:=by gcongr; simp--
      _≤ (100 * k+6).factorial:=by
        exact Nat.factorial_mul_pow_le_factorial


      _≤ (100*k+100).factorial:=by
        gcongr
        simp
      _= (100 * (k + 1)).factorial:=by
          ring_nf

apply induction_clump_add_Hi_and_I_cut_dense_easier
assumption
assumption
assumption
assumption
assumption
assumption
exact ht
repeat assumption

exact rfl
repeat assumption
dsimp[μ]

calc
  κ ^ (10 * (100 * k).factorial)
  /-≤κ ^ (10 * (100 * (gg1 k)).factorial):= by
    gcongr
    assumption
    have h1:       gg1 k ≥ gg1 k:= by exact Nat.le_refl (gg1 k)
    apply gg1_ge
    assumption
    exact kPos-/
    --
  ≤ κ ^ (10 * (100 * (gg1 κ) ).factorial):= by
    gcongr
    repeat assumption
    --
  _≤ m:= by
    apply gg2_4
    repeat assumption



lemma HOrdermfamily_union
(H1 H2 H: Finset (Subgraph G))
(m:ℕ)
(hH1: HOrder_ge_m_Family H1 m)
(hH2: HOrder_ge_m_Family H2 m)
(hH: H=H1∪ H2)
: HOrder_ge_m_Family H m:= by
unfold HOrder_ge_m_Family
intro A hA
rw[hH] at hA
by_cases   h1:(A∈ H1)
apply  hH1 A h1
have h2: A∈ H2:= by
   exact mem_of_union_elim_left H1 H2 A hA h1
apply  hH2 A h2


lemma Hcutdensefamily_union
(H1 H2 H: Finset (Subgraph G))
(p:ℕ)
(hH1: HCut_Dense_Family H1 p)
(hH2: HCut_Dense_Family H2 p)
(hH: H=H1∪ H2)
: HCut_Dense_Family H p:= by
unfold HCut_Dense_Family
intro A hA
rw[hH] at hA
by_cases   h1:(A∈ H1)
apply  hH1 A h1
have h2: A∈ H2:= by
   exact mem_of_union_elim_left H1 H2 A hA h1
apply  hH2 A h2

lemma Horderlem_union
(H1 H2 H: Finset (Subgraph G))
(h m:ℕ)
(hH1: HOrder_le_hm_Family H1 m h)
(hH2: HOrder_le_hm_Family H2 m h)
(hH: H=H1∪ H2)
: HOrder_le_hm_Family H m h := by
unfold HOrder_le_hm_Family
intro A hA
rw[hH] at hA
by_cases   h1:(A∈ H1)
apply  hH1 A h1
have h2: A∈ H2:= by
   exact mem_of_union_elim_left H1 H2 A hA h1
apply  hH2 A h2


lemma HFamilyContainedInGraph_union
(H1 H2 H: Finset (Subgraph G))
(Gr1 Gr2 : Subgraph G)
(hH1: FamilyContained_in_Graph H1 Gr1)
(hH2: FamilyContained_in_Graph H2 Gr2)
(hH: H=H1∪ H2)
: FamilyContained_in_Graph H (Gr1⊔ Gr2) := by
unfold FamilyContained_in_Graph
intro A hA
rw[hH] at hA
by_cases   h1:(A∈ H1)
have ha:A≤ Gr1:=by
  apply  hH1 A h1
apply le_sup_of_le_left
exact ha
have h2: A∈ H2:= by
   exact mem_of_union_elim_left H1 H2 A hA h1
have ha:A≤ Gr2:=by
  exact hH2 A h2
apply le_sup_of_le_right
exact ha


lemma M_Graphs_in_H_union
(H1 H2 H M: Finset (Subgraph G))
(hH1: Mgraphs_in_H M H1)
(hH: H=H1∪ H2)
: Mgraphs_in_H M H := by
unfold Mgraphs_in_H
intro A hA
rw[hH]
have h1: ∃ B ∈ H1  , A ≤ B:= by exact hH1 A hA
rcases h1 with ⟨B, hB, hAB⟩
use B
constructor
exact mem_union_left H2 hB
exact hAB


lemma clump_H_nonempty
{K1: Clump G p m κ pr h}
:
K1.H.Nonempty:= by
have h1: K1.M.Nonempty:= by
  exact clump_M_nonempty
rcases h1 with ⟨M, hM⟩
have h2:_:=by
  exact K1.M_graphs_in_H M hM
rcases h2 with ⟨Hi, hHi, hMi⟩
use Hi


lemma clump_joining_1
{K1 K2: Clump G p m κ pr h}
--{HFam: Finset (Subgraph G)}
{q k:ℕ }
{I: Set V}
--(μbiggerthanp: μ ≥ κ)
(hk1biggerthank: K1.k =  k)
(hk2biggerthank: K2.k ≤  k)
(hedge_disjoint: HEdge_Disjoint (K1.H ∪ K2.H))
(hI: I⊆ BSetPlusM K1∩ BSetPlusM K2)
(Iorder: (κ^(10*Nat.factorial (100*k))) *I.toFinset.card≥  m)
(Iorderupperbound: 4*pr*I.toFinset.card≤ m)
(qDef: q ≥  (κ^(Nat.factorial (100*k+4))))
(pLarge: p≥ 20)
(mggpr: m≥ gg1 pr)
(prggp: pr ≥ gg2 p)
(hggp: h ≥ pr)
(κggh: κ ≥ gg1 h)
(mggκ :m≥ gg2 κ )
(κggk: gg1 κ≥ k )
:
∃ (K: Clump G p m κ pr h),
(K.Gr=K1.Gr⊔ K2.Gr)∧
(K.H=K1.H∪ K2.H)∧
(K.k≥ k)∧
(K.k≤ K1.k+K2.k):=by

#check maximal_k_existence

let H: Finset (Subgraph G):= K1.H ∪ K2.H
have HCutDense : HCut_Dense_Family H p:= by
  apply Hcutdensefamily_union
  exact K1.H_Cut_Dense
  exact K2.H_Cut_Dense
  exact rfl

have HOrder_m_family : HOrder_ge_m_Family H m:= by
  apply  HOrdermfamily_union
  exact K1.H_Order
  exact K2.H_Order
  exact rfl

have HOrder_le_hm_family : HOrder_le_hm_Family H m h:= by
  apply  Horderlem_union
  exact K1.H_Order_Upper_Bound
  exact K2.H_Order_Upper_Bound
  exact rfl


have HContained_in_Gr : FamilyContained_in_Graph H (K1.Gr⊔ K2.Gr):= by
  apply  HFamilyContainedInGraph_union
  exact K1.H_In_K
  exact K2.H_In_K
  exact rfl

have M1Graphs_in_H : Mgraphs_in_H K1.M H:= by
  apply  M_Graphs_in_H_union
  exact K1.M_graphs_in_H
  exact rfl

have HpartitionGr: sSup H= K1.Gr⊔ K2.Gr:= by
  --dsimp[H]
  have h1: (sSup K1.H: Subgraph G)=K1.Gr:= by
    exact K1.H_Partition_K
  have h2: (sSup K2.H: Subgraph G)=K2.Gr:= by
    exact K2.H_Partition_K
  have h3:sSup H =(sSup K1.H: Subgraph G)⊔ (sSup K2.H: Subgraph G):= by
    dsimp[H]
    simp
    exact sSup_union
  rw[h3, h2, h1]






have HEdgeDisjoint : HEdge_Disjoint H := by
  exact hedge_disjoint


have HNonempty : H.Nonempty:= by
  have h1: K1.H.Nonempty:= by
    exact clump_H_nonempty
  dsimp[H]
  exact Nonempty.inl h1



have hkEx: ∃ k,
    (∃ M, M.card = k ∧ MVertex_Disjoint M ∧ MNear_Regular M m  pr ∧ Mgraphs_in_H M H) ∧
      (¬∃ M, M.card > k  ∧ MVertex_Disjoint M ∧ MNear_Regular M m  pr ∧ Mgraphs_in_H M H) ∧
        k ≥ 1 ∧ k ≤ (sSup ↑H: Subgraph G).verts.toFinset.card / (m / pr) + 1:=by
  apply maximal_k_existence
  repeat assumption
  have h1:pr≥ gg1 (p*2):= by
    apply gg2_5
    repeat assumption
  exact h1
  repeat assumption
  --m / pr > 0
  refine Nat.div_pos ?hpm.hba prPositive
  apply gg1_ge
  repeat assumption




rcases hkEx with ⟨ k', ⟨ hk'1, hk'2⟩ ⟩

rcases hk'1 with ⟨M, hMcard, hMVD, hMNR, hMgraphs_in_H⟩

have k'_ge_k: k' ≥ k:= by
  by_contra contr
  have h1: k' < k:= by
    exact Nat.gt_of_not_le contr
  have h2: ∃ M, M.card > k'  ∧ MVertex_Disjoint M ∧ MNear_Regular M m  pr ∧ Mgraphs_in_H M H:=by
    use K1.M
    constructor
    calc
      K1.M.card=K1.k:=by
        exact K1.M_Size
      _=k:= by
        exact hk1biggerthank
      _>k':= by
        exact h1
    constructor
    exact K1.M_Vertex_Disjoint
    constructor
    exact K1.M_Near_Regular
    exact M1Graphs_in_H
  exact hk'2.1 h2


have k'_le_2k: k' ≤  K1.k+K2.k:= by
  let M1: Finset (Subgraph G):= Finset.filter (fun A => (∃ Hi∈ K1.H, A≤ Hi)) M
  let M2: Finset (Subgraph G):= Finset.filter (fun A => (∃ Hi∈ K2.H, A≤ Hi)) M
  have hM1M2: M=M1∪ M2:= by
    ext A
    constructor
    intro hA
    by_cases h1: ∃ Hi∈ K1.H, A≤ Hi
    --rcases h1 with ⟨Hi, hHi, hAHi⟩
    have h2: A∈ M1:=by
      refine mem_filter.mpr ?_
      exact ⟨ hA, h1⟩
    exact mem_union_left M2 h2
    have h3: ∃ Hi∈ K1.H∪ K2.H, A≤ Hi:= by exact hMgraphs_in_H A hA
    have h4: ∃ Hi∈ K2.H, A≤ Hi:= by
      rcases h3 with ⟨Hi, hHi, hAHi⟩
      by_cases h5: Hi∈ K1.H
      have h10:∃ Hi ∈ K1.H, A ≤ Hi:= by
        use Hi
      exact (h1 h10).elim
      have h11: Hi ∈ K2.H:= by
        exact mem_of_union_elim_left K1.H K2.H Hi hHi h5
      use Hi
    have h2: A∈ M2:=by
      refine mem_filter.mpr ?_
      exact ⟨ hA, h4⟩
    exact mem_union_right M1 h2

    intro hA
    by_cases h1: A∈ M1
    exact mem_of_mem_filter A h1
    have h2:A∈ M2:=by
      exact mem_of_union_elim_left M1 M2 A hA h1
    exact mem_of_mem_filter A h2
  have hcard: M.card≤ M1.card+M2.card:= by
    rw[hM1M2]
    exact card_union_le M1 M2
  rw[hMcard] at hcard
  have hM1card: M1.card≤ K1.k:= by
    by_contra contr
    simp at contr
    have hex: (∃ (M': Finset (Subgraph G)), M'.card > K1.k ∧ (MVertex_Disjoint M')∧ (MNear_Regular M' m pr)∧ (Mgraphs_in_H M' K1.H)):= by
      use M1
      constructor
      exact contr
      constructor
      intro A B hA hB hAB
      apply hMVD A B
      rw[hM1M2]
      exact mem_union_left M2 hA
      exact mem_of_mem_filter B hB
      exact hAB
      constructor
      intro A hA
      apply hMNR A
      rw[hM1M2]
      exact mem_union_left M2 hA
      dsimp[M1]
      unfold Mgraphs_in_H
      simp
    have hcont: ¬ (∃ (M': Finset (Subgraph G)), M'.card > K1.k ∧ (MVertex_Disjoint M')∧ (MNear_Regular M' m pr)∧ (Mgraphs_in_H M' K1.H)):= by
      exact K1.k_Maximal
    exact hcont hex


  have hM1card: M2.card≤ K2.k:= by
    by_contra contr
    simp at contr
    have hex: (∃ (M': Finset (Subgraph G)), M'.card > K2.k ∧ (MVertex_Disjoint M')∧ (MNear_Regular M' m pr)∧ (Mgraphs_in_H M' K2.H)):= by
      use M2
      constructor
      exact contr
      constructor
      intro A B hA hB hAB
      apply hMVD A B
      rw[hM1M2]
      exact mem_union_right M1 hA
      exact mem_of_mem_filter B hB
      exact hAB
      constructor
      intro A hA
      apply hMNR A
      rw[hM1M2]
      exact mem_union_right M1 hA
      dsimp[M2]
      unfold Mgraphs_in_H
      simp
    have hcont: ¬ (∃ (M': Finset (Subgraph G)), M'.card > K2.k ∧ (MVertex_Disjoint M')∧ (MNear_Regular M' m pr)∧ (Mgraphs_in_H M' K2.H)):= by
      exact K2.k_Maximal
    exact hcont hex

  calc
    k'≤ M1.card + M2.card:= by exact hcard
    _≤ M1.card  + K2.k:= by
      gcongr
    _≤ K1.k + K2.k:= by
      gcongr



let HM: Finset (Subgraph G):= Finset.image (f_cont H) M

#check  Finset.exists_ne_map_eq_of_card_lt_of_maps_to

have M_in_HM:Mgraphs_in_H M HM:=by
  apply M_subgraph_f_cont_M
  exact hMgraphs_in_H

have HM_subset_H: HM⊆ H:= by
  apply f_cont_M_in_H
  exact hMgraphs_in_H

have MHsize: HM.card≤ 2*k:=by
  calc
  HM.card≤ M.card:= by
    exact card_image_le
  _≤ K1.k+K2.k:= by
    rw[hMcard]
    exact k'_le_2k
  _≤ k+k:= by
    gcongr
    exact Nat.le_of_eq hk1biggerthank
  _=2*k:=by
    ring_nf

have MHsize2: HM.card≤ k':=by
  calc
  HM.card≤ M.card:= by
    exact card_image_le
  _=k':= by
    exact hMcard

have kpos: k >0:= by
  rw[hk1biggerthank.symm]
  exact K1.Nonemptyness



by_cases case1: k'=k
---------case k'=k:----------------------
rw[case1] at hk'2
--let X: Clump G p m κ pr h:=⟨L, k,  H, M, C, HEdgeDisj, hM.2.1, HCutDense, HOrderm,HOrder_le_hm , HinK, HPartitionK, hM.2.2.1, CinK, MinC, hM.1, CCut_dense, COrder, hM.2.2.2, hk.2.1, hkpos⟩
have hK1C_in_Gr: K1.C ≤ K1.Gr ⊔ K2.Gr:=by
  calc
  K1.C ≤ K1.Gr:= by
    exact K1.C_In_K
  _≤ K1.Gr ⊔ K2.Gr:= by
    exact SemilatticeSup.le_sup_left K1.Gr K2.Gr
have M1_card_k:K1.M.card = k:=by
  calc
  K1.M.card=K1.k:= by
    exact K1.M_Size
  _=k:= by
    exact hk1biggerthank
have CutDense_k:G.cut_dense K1.C (κ ^ (100 * k).factorial) :=by
  rw[hk1biggerthank.symm]
  exact K1.C_Cut_Dense
have C1verts: K1.C.verts.toFinset.card ≤ m * h * 4 ^ k:=by
  calc
  K1.C.verts.toFinset.card ≤ m * h * 4 ^ K1.k:= by
    exact K1.C_Order
  _= m * h * 4 ^ k:= by
    rw[hk1biggerthank.symm]
let X: Clump G p m κ pr h:=⟨(K1.Gr⊔ K2.Gr), k,  H, K1.M, K1.C, HEdgeDisjoint, K1.M_Vertex_Disjoint, HCutDense, HOrder_m_family, HOrder_le_hm_family , HContained_in_Gr, HpartitionGr, K1.M_Near_Regular, hK1C_in_Gr, K1.M_In_C, M1_card_k, CutDense_k, C1verts, M1Graphs_in_H, hk'2.1, kpos⟩
use X

constructor
exact rfl
constructor
exact rfl
constructor
exact Nat.le_refl k
exact Nat.le.intro (congrFun (congrArg HAdd.hAdd (id hk1biggerthank.symm)) K2.k)

---------case k'>k:----------------------
have k'_g_k:k'>k:= by
  exact Nat.lt_of_le_of_ne k'_ge_k fun a ↦ case1 (id a.symm)

have k'pos: k' >0:= by
  exact Nat.zero_lt_of_lt k'_g_k

--let C:Subgraph G:= K1.C⊔ K2.C⊔ (sSup HM: Subgraph G)
--have hC:C= K1.C⊔ K2.C⊔ (sSup HM: Subgraph G):=by exact rfl

let C:Subgraph G:= K1.Gr.induce (I∪ K1.C.verts)⊔ K2.Gr.induce (I∪ K2.C.verts)⊔ (sSup HM: Subgraph G)
--have hC:C= K1.C⊔ K2.C⊔ (sSup HM: Subgraph G):=by exact rfl


have hCsize:C.verts.toFinset.card ≤ m*h*4^(k'):= by
  calc
  C.verts.toFinset.card=(K1.Gr.induce (I∪ K1.C.verts)⊔ K2.Gr.induce (I∪ K2.C.verts)⊔ (sSup HM: Subgraph G)).verts.toFinset.card:=by
    exact rfl
  _=((K1.Gr.induce (I∪ K1.C.verts)⊔ K2.Gr.induce (I∪ K2.C.verts)).verts ∪  (sSup HM: Subgraph G).verts).toFinset.card:=by
    congr
  _=((K1.Gr.induce (I∪ K1.C.verts)).verts ∪  (K2.Gr.induce (I∪ K2.C.verts)).verts ∪  (sSup HM: Subgraph G).verts).toFinset.card:=by
    congr
  _=((I∪ K1.C.verts) ∪  (I∪ K2.C.verts) ∪  (sSup HM: Subgraph G).verts).toFinset.card:=by
    have h1: (K1.Gr.induce (I∪ K1.C.verts)).verts= (I∪ K1.C.verts):= by
      exact rfl
    have h2: (K2.Gr.induce (I∪ K2.C.verts)).verts= (I∪ K2.C.verts):= by
      exact rfl
    simp_rw[h1, h2]
  _=((I∪ K1.C.verts∪   K2.C.verts) ∪  (sSup HM: Subgraph G).verts).toFinset.card:=by
    simp_rw[ union_three_set_idem I K1.C.verts K2.C.verts]


  --_=((I∪ K1.C.verts∪  K2.C.verts).toFinset ∪  (sSup HM: Subgraph G).verts.toFinset).card:= by
  --  congr;exact Set.toFinset_union (K1.C.verts ∪ K2.C.verts) (sSup ↑HM: Subgraph G).verts
  --_=((I∪ K1.C.verts.toFinset) ∪  K2.C.verts.toFinset ∪  (sSup HM: Subgraph G).verts.toFinset).card:= by
  --  congr; exact Set.toFinset_union K1.C.verts K2.C.verts
  _=(I.toFinset ∪ K1.C.verts.toFinset ∪  K2.C.verts.toFinset ∪  (sSup HM: Subgraph G).verts.toFinset).card:= by
    simp--congr; exact Set.toFinset_union I K1.C.verts
  _≤I.toFinset.card+K1.C.verts.toFinset.card+  K2.C.verts.toFinset.card +  (sSup HM: Subgraph G).verts.toFinset.card:=by
    apply card_union_4;
  _≤ m*h+m*h*4^(K1.k)+m*h*4^(K2.k)+m*h*(2*k):=by
    gcongr
    -- I.toFinset.card ≤ m
    calc
      I.toFinset.card
      =1*I.toFinset.card:=by
        ring_nf
      _≤
      4 * pr * I.toFinset.card:=by
        gcongr
        rw [@Nat.succ_le_iff]
        apply mul_pos
        simp
        assumption

      _≤ m:= by
        exact Iorderupperbound
      _= m*1:= by
        ring_nf
      _≤ m*h:= by
        gcongr
        assumption

    exact K1.C_Order
    exact K2.C_Order
    calc
      (sSup ↑HM:Subgraph G).verts.toFinset.card
      =(⋃Hi∈ HM, Hi.verts).toFinset.card:=by
        have hsSup:(sSup ↑HM:Subgraph G).verts=(⋃Hi∈ HM, Hi.verts):=by
          exact rfl
        simp_rw[hsSup]
      _≤ HM.card*(h*m):=by
        apply biunion_max_bound2 (h*m) (HM.card)
        exact card_le_card fun ⦃a⦄ a ↦ a
        intro Hi hHi
        apply HOrder_le_hm_family
        exact HM_subset_H hHi
      _=m*h*HM.card:=by
        ring_nf
      _≤ m*h*(2*k):=by
        gcongr
  _=m*h*(1+4^(K1.k)+4^(K2.k)+2*k):=by
    ring_nf
  _≤ m*h*(1+4^(k)+4^(k)+2*k):=by
    gcongr;exact NeZero.one_le;exact Nat.le_of_eq hk1biggerthank;exact NeZero.one_le;
  _≤ m*h*(4^(k+1)):=by
    gcongr
    --4 ^ k + 4 ^ k + 2 * k ≤ 4 ^ (k + 1)
    calc
      4 ^ (k + 1)=4*4 ^ (k):= by
        exact Nat.pow_succ'
      _=4 ^ (k)+4 ^ (k)+4 ^ (k)+4 ^ (k):=by
        ring_nf
      _≥
        1 + 4 ^ k + 4 ^ k + 2 * k:= by
        gcongr
        exact Nat.one_le_pow' k 3
        calc
          4^k=(2*2)^k:=by ring_nf
          _=2^k*2^k:= by
            exact Nat.mul_pow 2 2 k
          _≥2^1*k:= by
            gcongr
            exact NeZero.one_le
            exact kpos
            exact bernoulli_inequality k
            --
          _=2*k:= by ring_nf

        --

  _≤ m*h*4^(k'):= by
    gcongr
    exact NeZero.one_le
    exact k'_g_k

have k1_l_k: K1.k≤ k:= by
  calc
  K1.k≤ K1.k:= by exact Nat.le_refl K1.k
  _=k:= by
    exact hk1biggerthank

have C_cut_dense: cut_dense G C (κ^(Nat.factorial (100*k'))):=by
  let μ: ℕ :=κ ^ (10 * (100 * k).factorial)
  have μbiggerthanp: μ ≥ κ:= by
    dsimp [μ]
    refine Nat.le_self_pow ?hn κ
    refine Nat.mul_ne_zero_iff.mpr ?hn.a
    simp
    exact Nat.factorial_ne_zero (100 * k)
  apply induction_clump_add_Hi_and_I_cut_dense_simplernumbers  iSub (κ^(Nat.factorial (100*k'))) k (M.card)
  rw[hMcard]; exact k'_g_k
  repeat assumption;
  rw[hMcard]; exact MHsize
  repeat assumption;
  rw [@image_nonempty]
  rw [← @card_pos]
  rw[hMcard]
  exact k'pos
  repeat assumption
  /-exact μbiggerthanp
  --repeat assumption;
  --K1.k ≤ k
  exact k1_l_k
  exact hk2biggerthank
  exact hI
  exact Iorder
  exact Iorderupperbound
  exact HM_subset_H
  gcongr;  exact κPositive;
  rw[hMcard];
  exact MHsize
  repeat assumption;-/


have C_in_Gr: C≤ K1.Gr⊔ K2.Gr:=by
  dsimp [C]
  refine
    SemilatticeSup.sup_le (K1.Gr.induce (I ∪ K1.C.verts) ⊔ K2.Gr.induce (I ∪ K2.C.verts)) (sSup ↑HM: Subgraph G)
      (K1.Gr ⊔ K2.Gr) ?_ ?_
  refine
    SemilatticeSup.sup_le (K1.Gr.induce (I ∪ K1.C.verts)) (K2.Gr.induce (I ∪ K2.C.verts))
      (K1.Gr ⊔ K2.Gr) ?_ ?_
  have h1: I ∪ K1.C.verts⊆ K1.Gr.verts:= by
    apply Set.union_subset
    calc
      I⊆ BSetPlusM K1∩  BSetPlusM K2:= by
        exact hI
      _⊆ BSetPlusM K1:=by
        exact Set.inter_subset_left (BSetPlusM K1) (BSetPlusM K2)
      _⊆ K1.Gr.verts:= by
        exact BSetPlusM_subgraph_Kgr
    have h2: K1.C≤  K1.Gr:= by
      exact K1.C_In_K
    apply subgraphs_vertex_sets_subsets G;
    exact K1.C_In_K
  have h2: K1.Gr=K1.Gr.induce (K1.Gr.verts):= by
    exact Subgraph.induce_self_verts.symm
  calc
    K1.Gr.induce (I ∪ K1.C.verts) ≤ K1.Gr.induce (K1.Gr.verts):= by
      apply Subgraph.induce_mono_right
      exact h1
    _≤K1.Gr.induce (K1.Gr.verts) ⊔ K2.Gr:=by
      exact SemilatticeSup.le_sup_left (K1.Gr.induce K1.Gr.verts) K2.Gr
    _=K1.Gr ⊔ K2.Gr:= by
      exact congrFun (congrArg Sup.sup (id h2.symm)) K2.Gr

  have h1: I ∪ K2.C.verts⊆ K2.Gr.verts:= by
    apply Set.union_subset
    calc
      I⊆ BSetPlusM K1∩  BSetPlusM K2:= by
        exact hI
      _⊆ BSetPlusM K2:=by
        exact Set.inter_subset_right (BSetPlusM K1) (BSetPlusM K2)
      _⊆ K2.Gr.verts:= by
        exact BSetPlusM_subgraph_Kgr
    have h2: K2.C≤  K2.Gr:= by
      exact K2.C_In_K
    apply subgraphs_vertex_sets_subsets G;
    exact K2.C_In_K
  have h2: K2.Gr=K2.Gr.induce (K2.Gr.verts):= by
    exact Subgraph.induce_self_verts.symm
  calc
    K2.Gr.induce (I ∪ K2.C.verts) ≤ K2.Gr.induce (K2.Gr.verts):= by
      apply Subgraph.induce_mono_right
      exact h1
    _≤K1.Gr⊔ K2.Gr.induce (K2.Gr.verts) :=by
      exact le_sup_right'
    _=K1.Gr ⊔ K2.Gr:= by
      exact congrArg (Sup.sup K1.Gr) (id h2.symm)

  exact
    CompleteSemilatticeSup.sSup_le (↑HM) (K1.Gr ⊔ K2.Gr) fun b a ↦
      HContained_in_Gr b (HM_subset_H a)


have M_in_C: FamilyContained_in_Graph M C:=by
  intro Mi hMi
  unfold Mgraphs_in_H at M_in_HM
  have h1: ∃ B ∈ HM, Mi ≤ B:= by
    exact M_in_HM Mi hMi
  rcases h1 with ⟨B, hB⟩
  have hB1: B ∈ HM:= by
    exact hB.1
  calc
    Mi≤ B:= by exact hB.2
    _≤ (sSup ↑HM: Subgraph G ):= by
      exact CompleteLattice.le_sSup (↑HM) B hB1-- CompleteLattice.le_sSup (↑HM) B hB1
    _≤ C:=by
      exact le_sup_right'

--simp only [--Subgraph.verts_sup,
--Subgraph.induce_verts,
--Subgraph.verts_sSup,
--Set.toFinset_card,
--Fintype.card_ofFinset,
--Set.toFinset_union, union_assoc, mem_coe
--] at hCsize
#check K1.C_Order

have hCSize2: (@Set.toFinset V C.verts (Subtype.fintype fun x ↦ x ∈ C.verts) : Finset V).card≤ m * h * 4 ^ k':= by
  dsimp [C]
  simp
  simp at hCsize
  exact hCsize
let X: Clump G p m κ pr h:=⟨(K1.Gr⊔ K2.Gr), k',  H, M, C, HEdgeDisjoint, hMVD, HCutDense, HOrder_m_family, HOrder_le_hm_family , HContained_in_Gr, HpartitionGr, hMNR, C_in_Gr, M_in_C, hMcard, C_cut_dense, hCSize2, hMgraphs_in_H, hk'2.1, k'pos⟩

use X
