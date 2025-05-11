Section Minimal_propositional_logic.
  Variables P Q R T : Prop.
  Theorem imp_trans : (P -> Q) -> (Q -> R) -> P -> R.
  Proof.
    intros H H' p.
    apply H'.
    apply H.
    assumption.
  Qed.
  Print imp_trans.

  Theorem imp_trans' : (P -> Q) -> (Q -> R) -> P -> R.
  Proof.
    auto.
  Qed.
  Print imp_trans'.

  Check Q.
  Check ((P -> Q) -> (Q -> R) -> P -> R).

  Section example_of_assumption.
    Hypothesis H : P -> Q -> R.
    Lemma L1: P -> Q -> R.
    Proof.
      assumption.
    Qed.
  End example_of_assumption.

  Theorem delta : (P -> P -> Q) -> P -> Q.
  Proof.
    exact (fun (H: P -> P -> Q) (p:P) => H p p).
  Qed.

  Theorem delta' : (P -> P -> Q) -> P -> Q.
  Proof (fun (H : P -> P -> Q) (p : P) => H p p).

  Theorem apply_example : (Q -> R -> T) -> (P -> Q) -> P -> R -> T.
  Proof.
    intros H H0 p.
    apply H.
    exact (H0 p).
  Qed.

  Theorem imp_dist : (P -> Q -> R) -> (P -> Q) -> (P -> R).
  Proof.
    intros H H' p.
    apply H.
    assumption.
    apply H'.
    assumption.
  Qed.

  Print imp_dist.

  Theorem K : P -> Q -> P.
  Proof.
    intros p q.
    assumption.
  Qed.

  Lemma id_P : P -> P.
  Proof.
    intros p.
    assumption.
  Qed.

  Print id_P.

  Lemma id_PP : (P -> P) -> (P -> P).
  Proof.
    intros H.
    assumption.
  Qed.

  Print id_PP.

  Lemma imp_trans'' : (P -> Q) -> (Q -> R) -> P -> R.
  Proof.
    intros H H0 p.
    apply H0.
    apply H.
    assumption.
  Qed.

  Lemma imp_perm : (P -> Q -> R) -> (Q -> P -> R).
  Proof.
    intros H q p.
    apply H.
    assumption.
    assumption.
  Qed.

  Lemma ignore_Q : (P -> R) -> P -> Q -> R.
  Proof.
    intros H p q.
    apply H.
    assumption.
  Qed.

  Lemma delta_imp : (P -> P -> Q) -> P -> Q.
  Proof.
    intros H p.
    apply H.
    assumption.
    assumption.
  Qed.

  Lemma delta_impR : (P -> Q) -> (P -> P -> Q).
  Proof.
    intros H p0 p1.
    apply H.
    assumption.
  Qed.

  Lemma diamond : (P -> Q) -> (P -> R) -> (Q -> R -> T) -> P -> T.
  Proof.
    intros H0 H1 H2 p.
    apply H2.
    apply H0.
    assumption.
    apply H1.
    assumption.
  Qed.

  Lemma weak_peirce : ((((P -> Q) -> P) -> P) -> Q) -> Q.
  Proof.
    intros H0.
    apply H0.
    intros H1.
    apply H1.
    intros p.
    apply H0.
    intros H2.
    assumption.
  Qed.

  Print weak_peirce.

  Section proof_of_triple_impl.
    Hypothesis H : ((P -> Q) -> Q) -> Q.
    Hypothesis p : P.

    Lemma Rem : (P -> Q) -> Q.
    Proof (fun H0: P -> Q => H0 p).

    Theorem triple_impl : Q.
    Proof (H Rem).
  End proof_of_triple_impl.

  Print triple_impl.

  Print Rem.

  Theorem then_example : P -> Q -> (P -> Q -> R) -> R.
  Proof.
    intros p q H.
    apply H; assumption.
  Qed.

  Theorem triple_impl_one_shot : (((P -> Q) -> Q) -> Q) -> P -> Q.
  Proof.
    intros H p; apply H; intro H0; apply H0; assumption.
  Qed.

  Theorem compose_example : (P -> Q -> R) -> (P -> Q) -> (P -> R).
  Proof.
    intros H H' p.
    apply H; [assumption | apply H'; assumption].
  Qed.

  Lemma L3 : (P -> Q) -> (P -> R) -> (P -> Q -> R -> T) -> P -> T.
  Proof.
    intros H H0 H1 p.
    apply H1; [idtac | apply H | apply H0]; assumption.
  Qed.

  Theorem then_fail_example : (P -> Q) -> (P -> Q).
  Proof.
    intro X; apply X; fail.
  Qed.

  Theorem try_example : (P -> Q -> R -> T) -> (P -> Q) -> (P -> R -> T).
  Proof.
    intros H H' p r.
    apply H; try assumption.
    apply H'; assumption.
  Qed.

  Lemma id_P' : P -> P.
  Proof.
    intros p; assumption.
  Qed.

  Lemma id_PP' : (P -> P) -> (P -> P).
  Proof.
    intros H; assumption.
  Qed.

  Lemma imp_trans3 : (P -> Q) -> (Q -> R) -> P -> R.
  Proof.
    intros H0 H1 p; apply H1; apply H0; assumption.
  Qed.

  Lemma imp_perm' : (P -> Q -> R) -> (Q -> P -> R).
  Proof.
    intros H q p; apply H; [assumption | assumption].
  Qed.

  Lemma ignore_Q' : (P -> R) -> P -> Q -> R.
  Proof.
    intros H p q; apply H; assumption.
  Qed.

  Lemma delta_imp' : (P -> P -> Q) -> P -> Q.
  Proof.
    intros H p; apply H; assumption.
  Qed.

  Lemma detla_impR' : (P -> Q) -> (P -> P -> Q).
  Proof.
    intros H p0 p1; apply H; assumption.
  Qed.

  Lemma diamond' : (P -> Q) -> (P -> R) -> (Q -> R -> T) -> P -> T.
  Proof.
    intros H0 H1 H2 p; apply H2; [apply H0 | apply H1]; assumption.
  Qed.

  Lemma weak_peirce' : ((((P -> Q) -> P) -> P) -> Q) -> Q.
  Proof.
    intros H0; apply H0; intros H1; apply H1; intros p; apply H0; intros H2; assumption.
  Qed.

  Theorem imp_dist' : (P -> Q -> R) -> (P -> Q) -> (P -> R).
  Proof.
    intros.
    apply H.
    assumption.
    apply H0.
    assumption.
  Qed.

  (* TODO: Exercise 3.4 on page 67. Proof it using coq itself? *)

  Section section_for_cut_example.
    Hypotheses  (H : P -> Q)
                (H0 : Q -> R)
                (H1 : (P -> R) -> T -> Q)
                (H2 : (P -> R) -> T).

    Theorem cut_example : Q.
    Proof.
      cut (P -> R).
      intro H3.
      apply H1; [assumption | apply H2; assumption].
      intro; apply H0; apply H; assumption.
    Qed.

    Print cut_example.

    Theorem nocut_example : Q.
    Proof.
      apply H1.
      intro p.
      apply H0.
      apply H.
      assumption.
      apply H2.
      intro p.
      apply H0.
      apply H.
      assumption.
    Qed.

    Print nocut_example.

    Theorem cut_example' : Q.
    Proof.
      cut (P -> R).
      intro f.
      apply H1.
      assumption.
      apply H2.
      assumption.
      intro p.
      apply H0.
      apply H.
      assumption.
    Qed.

    Print cut_example'.
  End section_for_cut_example.

  Theorem triple_impl2 : (((P -> Q) -> Q) -> Q) -> P -> Q.
  Proof.
    auto.
  Qed.

  (* TODO: Exercise 3.6 *)

End Minimal_propositional_logic.

Print imp_dist.

Section using_imp_dist.
  Variables (P1 P2 P3 : Prop).
  Check (imp_dist P1 P2 P3).
  Check (imp_dist (P1 -> P2) (P2 -> P3) (P3 -> P1)).
End using_imp_dist.
