Require Import Coq.Setoids.Setoid.

Delimit Scope Num_scope with Num.

Module Type Num.
  Parameter Num : Set.

  Open Scope Num_scope.

  Parameter _0 : Num.
  Parameter _1 : Num.

  Parameter add : Num -> Num -> Num.
  Parameter add_inverse : Num -> Num.
  Parameter mult : Num -> Num -> Num.
  Parameter mult_inverse : Num -> Num.

  Parameter positive : Num -> Prop.
  Parameter negative : Num -> Prop.

  Notation "0" := _0 : Num_scope.
  Notation "1" := _1 : Num_scope.
  Infix "+" := add : Num_scope.
  Notation "- x" := (add_inverse x) : Num_scope.
  Infix "*" := mult : Num_scope.
  Notation "x ^ -1" := (mult_inverse x) : Num_scope.

  Check 0 : Num.
  Check 1 : Num.
  Check 1+1 : Num.
  Check 1*1 : Num.
  Check 0^-1 : Num.

  (* Associative law for addition *)
  Axiom P1 : forall (a b c : Num), a + (b + c) = (a + b) + c.
  (* Existence of an additive identity *)
  Axiom P2 : forall (a : Num), a + 0 = a.
  Axiom P2' : forall (a : Num), 0 + a = a.
  (* Excistence of an additive inverse *)
  Axiom P3 : forall (a : Num), a + (-a) = 0.
  Axiom P3' : forall (a : Num), (-a) + a = 0.
  (* Commutative law for additon *)
  Axiom P4 : forall (a b : Num), a + b = b + a.
  (* Associate law for multiplication *)
  Axiom P5 : forall (a b c : Num), a * (b * c) = (a * b) * c.
  (* Existence of multiplicative identity *)
  Axiom P6 : forall (a : Num), a * 1 = a.
  Axiom P6' : forall (a : Num), 1 * a = a.
  (* Existence of multiplicative inverses *)
  Axiom P7 : forall (a : Num), a <> 0 -> a * a^-1 = 1.
  Axiom P7' : forall (a : Num), a <> 0 -> a^-1 * a = 1.
  (* Commutative law for multiplication *)
  Axiom P8 : forall (a b : Num), a * b = b * a.
  (* Distributive law *)
  Axiom P9 : forall (a b c : Num), a * (b + c) = a * b + a * c.
  (* Tricohtomy law *)
  Axiom P10 : forall (a : Num),
    (a = 0 /\ ~(positive a) /\ ~(positive (-a))) \/
    (a <> 0 /\ (positive a) /\ ~(positive (-a))) \/
    (a <> 0 /\ ~(positive a) /\ (positive (-a))).
  (* Closure under addition *)
  Axiom P11 : forall (a b : Num), positive a -> positive b -> positive (a + b).
  (* Closure under multiplication *)
  Axiom P12 : forall (a b : Num), positive a -> positive b -> positive (a * b).

  Theorem mult_by_zero : forall (a : Num), a * 0 = 0.
  Proof.
    intro a.
    rewrite <- (P2 (a*0)).
    rewrite <- (P3 (a*0)) at 2.
    rewrite P1.
    rewrite <- P9.
    rewrite P2.
    rewrite <- (P3 (a*0)) at 3.
    reflexivity.
  Qed.


  Theorem add_both_sides : forall (a b c: Num), a + b = c -> a = c + (-b).
  Proof.
    intros a b c H.
    rewrite <- (P2 a).
    rewrite <- (P3 b).
    rewrite P1.
    rewrite H.
    reflexivity.
  Qed.

  Theorem add_both_sides' : forall (a b c: Num), a = c + (-b) -> a + b = c.
  Proof.
    intros a b c H.
    rewrite H.
    rewrite <- P1.
    rewrite P3'.
    rewrite P2.
    reflexivity.
  Qed.

  Theorem add_both_sides'' : forall (a b c : Num), a = b <-> a + c = b + c.
  Proof.
    intros a b c.
    split.
    - intros H. rewrite H. reflexivity.
    - intros H. rewrite -> (add_both_sides a c (b + c)). rewrite <- P1. rewrite P3. rewrite P2. reflexivity. assumption.
  Qed.

  Theorem mult_both_sides : forall (a b c: Num), c <> 0 -> a = b <-> a * c = b * c.
  Proof.
    intros a b c H0.
    split.
    - intro H1. rewrite H1. reflexivity.
    - intro H1. rewrite <- (P6 a). rewrite <- (P6 b). rewrite <- (P7 c). rewrite P5. rewrite H1. rewrite <- P5. reflexivity. assumption.
  Qed.

  Theorem dist_add_inverse : forall (a b : Num), -a * b = -(a * b).
  Proof.
    intros a b.
    rewrite (add_both_sides'' _ _ (a * b)).
    rewrite P3'.
    rewrite (P8 (-a) b).
    rewrite (P8 a b).
    rewrite <- P9.
    rewrite P3'.
    rewrite mult_by_zero.
    reflexivity.
  Qed.

  Theorem swap_add_inverse : forall (a b : Num), -a * b = a * -b.
  Proof.
    intros a b.
    rewrite dist_add_inverse.
    rewrite P8.
    rewrite <- dist_add_inverse.
    rewrite P8.
    reflexivity.
  Qed.

  Theorem add_inverse_to_one : forall (a : Num), -a = (- 1%Num) * a.
  Proof.
    intros a.
    rewrite <- (P6' (-a)).
    rewrite <- swap_add_inverse.
    reflexivity.
  Qed.

  Theorem neg_dist : forall (a : Num), -(a * 1) = (-a) * 1.
  Proof.
    intro a.
    rewrite add_inverse_to_one.
    rewrite P5.
    rewrite swap_add_inverse.
    rewrite <- P5.
    rewrite P6'.
    reflexivity.
  Qed.

  Theorem T0 : forall (a x : Num), a + x = a -> x = 0.
  Proof.
    intros a x.
    rewrite (add_both_sides'' (a + x) a (-a)).
    rewrite P3.
    rewrite P4.
    rewrite P1.
    rewrite (P4 (-a) a).
    rewrite P3.
    rewrite P2'.
    intro H.
    assumption.
  Qed.
