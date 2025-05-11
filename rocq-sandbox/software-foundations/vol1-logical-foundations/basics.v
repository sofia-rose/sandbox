Inductive day : Type :=
  | monday
  | tuesday
  | wednesday
  | thursday
  | friday
  | saturday
  | sunday.

Definition next_working_day (d:day) : day :=
  match d with
  | monday => tuesday
  | tuesday => wednesday
  | wednesday => thursday
  | thursday => friday
  | friday => monday
  | saturday => monday
  | sunday => monday
  end.

Compute (next_working_day friday).

Compute (next_working_day (next_working_day saturday)).

Example test_next_working_day : (next_working_day (next_working_day saturday)) = tuesday.
Proof.
  simpl.
  reflexivity.
Qed.

From Coq Require Export String.

Inductive bool : Type :=
  | true
  | false.

Definition negb (b:bool) : bool :=
  match b with
  | true => false
  | false => true
  end.

Definition andb (b1 : bool) (b2 : bool) : bool :=
  match b1 with
  | true => b2
  | false => false
  end.

Definition orb (b1 : bool) (b2 : bool) : bool :=
  match b1 with
  | true => true
  | false => b2
  end.

Example test_orb1: (orb true false) = true.
Proof. simpl. reflexivity. Qed.

Example test_orb2: (orb false false) = false.
Proof. simpl. reflexivity. Qed.

Example test_orb3: (orb false true) = true.
Proof. simpl. reflexivity. Qed.

Example test_orb4: (orb true true) = true.
Proof. simpl. reflexivity. Qed.

Notation "x && y" := (andb x y).
Notation "x || y" := (orb x y).

Example test_orb5: false || false || true = true.
Proof. simpl. reflexivity. Qed.

Definition negb' (b : bool) : bool :=
  if b then false else true.

Definition andb' (b1 : bool) (b2 : bool) : bool :=
  if b1 then b2 else false.

Definition orb' (b1 : bool) (b2: bool) : bool :=
  if b1 then true else b2.

Inductive bw: Type :=
  | bw_black
  | bw_white.

Definition invert (x : bw) : bw :=
  if x then bw_white else bw_black.

Compute (invert bw_black).

Compute (invert bw_white).

Definition nandb (b1:bool) (b2:bool) : bool :=
  match b1 with
  | false => true
  | true => negb b2
  end.

Example test_nandb1: (nandb true false) = true.
Proof. simpl. reflexivity. Qed.

Example test_nandb2: (nandb false false) = true.
Proof. simpl. reflexivity. Qed.

Example test_nandb3: (nandb false true) = true.
Proof. simpl. reflexivity. Qed.

Example test_nandb4: (nandb true true) = false.
Proof. simpl. reflexivity. Qed.

Definition andb3 (b1:bool) (b2:bool) (b3:bool) : bool :=
  match b1 with
  | false => false
  | true =>
      match b2 with
      | false => false
      | true => b3
      end
  end.

Example test_andb31: (andb3 true true true) = true.
Proof. simpl. reflexivity. Qed.

Example test_andb32: (andb3 false true true) = false.
Proof. simpl. reflexivity. Qed.

Example test_andb33: (andb3 true false true) = false.
Proof. simpl. reflexivity. Qed.

Example test_andb34: (andb3 true true false) = false.
Proof. simpl. reflexivity. Qed.

Check true.

Check true : bool.

Check (negb true) : bool.

Check negb : bool -> bool.

Inductive rgb : Type :=
  | red
  | green
  | blue.

Inductive color : Type :=
  | black
  | white
  | primary (p : rgb).

Definition monochrome (c : color) : bool :=
  match c with
  | black => true
  | white => true
  | primary p => false
  end.

Definition isread (c : color) : bool :=
  match c with
  | black => false
  | white => false
  | primary red => true
  | primary _ => false
  end.

Module Playground.
  Definition foo : rgb := blue.
End Playground.

Definition foo : bool := true.

Check Playground.foo : rgb.
Check foo : bool.

Module TuplePlayground.
  Inductive bit : Type :=
    | B1
    | B0.

  Inductive nybble : Type :=
    | bits (b1 b1 b2 b3 : bit).

  Check (bits B1 B0 B1 B0) : nybble.

  Definition all_zero (nb: nybble) : bool :=
    match nb with
    | (bits B0 B0 B0 B0) => true
    | _ => false
    end.

  Compute (all_zero (bits B1 B0 B1 B0)).
  Compute (all_zero (bits B0 B0 B0 B0)).
End TuplePlayground.

Module NatPlayground.
  Inductive nat : Type :=
    | O
    | S (n : nat).

  Inductive otherNat : Type :=
    | stop
    | tick (foo : otherNat).

  Definition pred (n : nat) : nat :=
    match n with
    | O => O
    | S n' => n'
    end.

End NatPlayground.

Check (S (S (S (S O)))).

Definition minustwo (n : nat) : nat :=
  match n with
  | O => O
  | S O => O
  | S (S n') => n'
  end.

Compute (minustwo 4).

Check S : nat -> nat.
Check pred : nat -> nat.
Check minustwo : nat -> nat.

Fixpoint even (n : nat) : bool :=
  match n with
  | O => true
  | S O => false
  | S (S n') => even n'
  end.

Definition odd (n : nat) : bool := negb (even n).

Example test_odd1 : odd 1 = true.
Proof. simpl. reflexivity. Qed.
Example test_odd2 : odd 2 = false.
Proof. simpl. reflexivity. Qed.

Module NatPlayground2.
  Fixpoint plus (n : nat) (m : nat) : nat :=
    match n with
    | O => m
    | S n' => plus n' (S m)
    end.

  Compute (plus 3 2).

  Fixpoint helper (n m acc : nat) : nat :=
    match n with
    | O => acc
    | S n' => helper n' m (plus m acc)
    end.

  Definition mult (n m : nat) : nat := helper n m O.

  Example test_mult1 : (mult 3 3) = 9.
  Proof. simpl. reflexivity. Qed.

  Fixpoint minus (n m : nat) : nat :=
    match n, m with
    | O , _ => O
    | S _, O => n
    | S n', S m' => minus n' m'
    end.

End NatPlayground2.

Fixpoint exp (base power : nat) : nat :=
  match power with
  | O => S O
  | S p => mult base (exp base p)
  end.

Fixpoint factorial (n : nat) : nat :=
  match n with
  | O => 1
  | S n' => mult n (factorial n')
  end.

Example test_factorial1 : (factorial 3) = 6.
Proof. simpl. reflexivity. Qed.

Example test_factorial2 : (factorial 5) = (mult 10 12).
Proof. simpl. reflexivity. Qed.

Check ((0 + 1) + 1) : nat.

Fixpoint eqb (n m : nat) : bool :=
  match n, m with
  | O, O => true
  | S n', S m' => eqb n' m'
  | _, _ => false
  end.

Fixpoint leb (n m : nat) : bool :=
  match n with
  | O => true
  | S n' =>
      match m with
      | O => false
      | S m' => leb n' m'
      end
  end.

Example test_leb1: leb 2 2 = true.
Proof. simpl. reflexivity. Qed.
Example test_leb2: leb 2 4 = true.
Proof. simpl. reflexivity. Qed.
Example test_leb3: leb 4 2 = false.
Proof. simpl. reflexivity. Qed.

Notation "x =? y" := (eqb x y) (at level 70) : nat_scope.
Notation "x <=? y" := (leb x y) (at level 70) : nat_scope.

Example test_leb3': (4 <=? 2) = false.
Proof. simpl. reflexivity. Qed.

Definition ltb (n m : nat) : bool := negb (leb m n).

Notation "x <? y" := (ltb x y) (at level 70) : nat_scope.

Example test_ltb1: (ltb 2 2) = false.
Proof. simpl. reflexivity. Qed.

Example test_ltb2: (ltb 2 4) = true.
Proof. simpl. reflexivity. Qed.

Example test_ltb3: (ltb 4 2) = false.
Proof. simpl. reflexivity. Qed.

Theorem plus_0_n : forall n : nat , 0 + n = n.
Proof.
  intros n.
  simpl.
  reflexivity.
Qed.

Theorem plus_0_n'' : forall n : nat, 0 + n = n.
Proof. intros m. reflexivity. Qed.

Theorem plus_1_l : forall n : nat, 1 + n = S n.
Proof. intros n. reflexivity. Qed.

Theorem mult_0_l : forall n : nat, 0 * n = 0.
Proof. intros n. reflexivity. Qed.

Theorem plus_id_example: forall n m : nat, n = m -> n + n = m + m.
Proof.
  intros n m H.
  rewrite <- H.
  reflexivity.
Qed.

Theorem plus_id_exercise : forall n m o : nat,
  n = m ->  m = o -> n + m = m + o.
Proof.
  intros n m o H0 H1.
  rewrite -> H0.
  rewrite -> H1.
  reflexivity.
Qed.

Check mult_n_O.
Check mult_n_Sm.

Theorem mult_n_0_m_0 : forall p q : nat, (p * 0) + (q * 0) = 0.
Proof.
  intros p q.
  rewrite <- mult_n_O.
  rewrite <- mult_n_O.
  reflexivity.
Qed.

Theorem mul_n_1 : forall p : nat, p * 1 = p.
Proof.
  intros p.
  rewrite <- mult_n_Sm.
  rewrite <- mult_n_O.
  reflexivity.
Qed.

Theorem plus_1_neq_0_firsttry : forall n : nat, (n + 1) =? 0 = false.
Proof.
  intros n.
  simpl.
Abort.

Theorem plus_1_neq_0 : forall n : nat, (n + 1) =? 0 = false.
Proof.
  intros n.
  destruct n as [| n' ] eqn : E.
  - reflexivity.
  - reflexivity.
Qed.

Theorem negb_involutive : forall b : bool, negb (negb b) = b.
Proof.
  intros b.
  destruct b eqn:E.
  - reflexivity.
  - reflexivity.
Qed.

Theorem andb_commutative : forall b c, andb b c = andb c b.
Proof.
  intros b c. destruct b eqn:Eb.
  - destruct c eqn:Ec.
    + reflexivity.
    + reflexivity.
  - destruct c eqn:Ec.
    + reflexivity.
    + reflexivity.
Qed.

Theorem andb_commutative' : forall b c, andb b c = andb c b.
Proof.
  intros b c. destruct b eqn:Eb.
  { destruct c eqn:Ec.
    { reflexivity. }
    { reflexivity. } }
  { destruct c eqn:Ec.
    { reflexivity. }
    { reflexivity. } }
Qed.

Theorem andb3_exchange : forall b c d, andb (andb b c) d = andb (andb b d ) c.
Proof.
  intros b c d. destruct b eqn:Eb.
  - destruct c eqn:Ec.
    { destruct d eqn:Ed.
      - reflexivity.
      - reflexivity. }
    { destruct d eqn:Ed.
      - reflexivity.
      - reflexivity. }
  - destruct c eqn:Ec.
    { destruct d eqn:Ed.
      - reflexivity.
      - reflexivity. }
    { destruct d eqn:Ed.
      - reflexivity.
      - reflexivity. }
Qed.

Theorem andb_true_elim2 : forall b c : bool, andb b c = true -> c = true.
Proof.
  intros b c. destruct b eqn:Eb.
  - destruct c eqn:Ec.
    + intro H. reflexivity.
    + intro H. rewrite <- H. reflexivity.
  - destruct c eqn:Ec.
    + intro H. reflexivity.
    + intro H. rewrite <- H. reflexivity.
Qed.

Theorem plus_1_neq_0' : forall n : nat, (n + 1) =? 0 = false.
Proof.
  intros [|n].
  - reflexivity.
  - reflexivity.
Qed.

Theorem andb_commutative'' : forall b c, andb b c = andb c b.
Proof.
  intros [] [].
  - reflexivity.
  - reflexivity.
  - reflexivity.
  - reflexivity.
Qed.

Theorem zero_nbeq_plus_1 : forall n : nat, 0 =? (n + 1) = false.
Proof.
  intros [].
  - reflexivity.
  - reflexivity.
Qed.

Theorem zero_nbeq_plus_1' : forall n : nat, 0 =? (n + 1) = false.
Proof.
exact (fun n : nat => match n with
        | 0 => eq_refl
        | S _ => eq_refl end).
Qed.



Print zero_nbeq_plus_1.
Print zero_nbeq_plus_1'.
Print eq_refl.
Print eqb.

(*
Error: Coq cannot guess decreasing argument of fix.

Fixpoint gcd (a : nat) (b : nat) : nat :=
  if a =? b then a else if a <? b then gcd a (b - a) else gcd (a - b) b.
*)

Theorem identity_fn_applied_twice : forall (f : bool -> bool), (forall (x : bool), f x = x) -> forall (b :bool), f (f b) = b.
Proof.
  intros f H.
  intros [].
  - rewrite -> H. rewrite -> H. reflexivity.
  - rewrite -> H. rewrite -> H. reflexivity.
Qed.

Theorem negb_fn_applied_twice : forall (f : bool -> bool), (forall (x : bool), f x = negb x) -> forall (b :bool), f (f b) = b.
Proof.
  intros f H.
  intros [].
  - rewrite -> H. rewrite -> H. reflexivity.
  - rewrite -> H. rewrite -> H. reflexivity.
Qed.

Lemma orb_true : forall (b : bool), true || b = true.
Proof.
  intros [].
  - reflexivity.
  - reflexivity.
Qed.

Lemma andb_false : forall (b : bool), false && b = false.
Proof.
  intros [].
  - reflexivity.
  - reflexivity.
Qed.

Theorem andb_eq_orb : forall (b c : bool), (andb b c = orb b c) -> b = c.
Proof.
  intros b c.
  destruct b eqn:eB.
  - rewrite -> orb_true. destruct c eqn:eC.
    + reflexivity.
    + intro H. rewrite <- H. reflexivity.
  - rewrite -> andb_false. destruct c eqn:eC.
    + intro H. rewrite -> H. reflexivity.
    + reflexivity.
Qed.

Module LateDays.
  Inductive letter : Type :=
    | A | B | C | D | F.

  Inductive modifier : Type :=
    | Plus | Natural | Minus.

  Inductive grade : Type :=
    Grade (l:letter) (m:modifier).

  Inductive comparison : Type :=
    | Eq
    | Lt
    | Gt.

  Definition letter_comparison (l1 l2 : letter) : comparison :=
    match l1, l2 with
    | A, A => Eq
    | A, _ => Gt
    | B, A => Lt
    | B, B => Eq
    | B, _ => Gt
    | C, (A | B) => Lt
    | C, C => Eq
    | C, _ => Gt
    | D, (A | B | C) => Lt
    | D, D => Eq
    | D, _ => Gt
    | F, (A | B | C | D) => Lt
    | F, F => Eq
    end.

  Compute letter_comparison B A.

  Compute letter_comparison D D.

  Compute letter_comparison B F.

  Theorem letter_comparison_Eq : forall l, letter_comparison l l = Eq.
  Proof.
    intros [].
    - reflexivity.
    - reflexivity.
    - reflexivity.
    - reflexivity.
    - reflexivity.
  Qed.

  Definition modifier_comparison (m1 m2 : modifier) : comparison :=
    match m1, m2 with
    | Plus, Plus => Eq
    | Plus, _ => Gt
    | Natural, Plus => Lt
    | Natural, Natural => Eq
    | Natural, _ => Gt
    | Minus, (Plus | Natural) => Lt
    | Minus, Minus => Eq
    end.

  Definition grade_comparison (g1 g2 : grade) : comparison :=
   match g1, g2 with
   | (Grade  l1 m1), (Grade l2 m2) =>
       match (letter_comparison l1 l2) with
       | Lt => Lt
       | Eq => (modifier_comparison m1 m2)
       | Gt => Gt
       end
   end.

  Example test_grade_comparison1 :
    (grade_comparison (Grade A Minus) (Grade B Plus)) = Gt.
  Proof.
    simpl. reflexivity.
  Qed.


  Example test_grade_comparison2 :
    (grade_comparison (Grade A Minus) (Grade A Plus)) = Lt.
  Proof.
    simpl. reflexivity.
  Qed.

  Example test_grade_comparison3 :
    (grade_comparison (Grade F Plus) (Grade F Plus)) = Eq.
  Proof.
    simpl. reflexivity.
  Qed.

  Example test_grade_comparison4 :
    (grade_comparison (Grade B Minus) (Grade C Plus)) = Gt.
  Proof.
    simpl. reflexivity.
  Qed.

  Definition lower_letter (l : letter) : letter :=
    match l with
    | A => B
    | B => C
    | C => D
    | D => F
    | F => F
    end.

  Theorem lower_letter_F_is_F : lower_letter F = F.
  Proof.
    simpl. reflexivity.
  Qed.

  Theorem lower_letter_lowers :
    forall (l : letter),
      letter_comparison F l = Lt ->
      letter_comparison (lower_letter l) l = Lt.
  Proof.
    intros l.
    destruct l eqn:eL.
    - reflexivity.
    - reflexivity.
    - reflexivity.
    - reflexivity.
    - intro H. rewrite <- H. simpl. reflexivity.
  Qed.

  Definition lower_grade (g : grade) : grade :=
   match g with
   | (Grade l Plus) => (Grade l Natural)
   | (Grade l Natural) => (Grade l Minus)
   | (Grade l Minus) =>
       match l with
       | F => (Grade F Minus)
       | _ => (Grade (lower_letter l) Plus)
       end
   end.

  Example lower_grade_A_Plus :
    lower_grade (Grade A Plus) = (Grade A Natural).
  Proof.
    simpl. reflexivity.
  Qed.

  Example lower_grade_A_Natural :
    lower_grade (Grade A Natural) = (Grade A Minus).
  Proof.
    simpl. reflexivity.
  Qed.

  Example lower_grade_A_Minus :
    lower_grade (Grade A Minus) = (Grade B Plus).
  Proof.
    simpl. reflexivity.
  Qed.

  Example lower_grade_B_Plus :
    lower_grade (Grade B Plus) = (Grade B Natural).
  Proof.
    simpl. reflexivity.
  Qed.

  Example lower_grade_F_Natural :
    lower_grade (Grade F Natural) = (Grade F Minus).
  Proof.
    simpl. reflexivity.
  Qed.

  Example lower_grade_twice :
    lower_grade (lower_grade (Grade B Minus)) = (Grade C Natural).
  Proof.
    simpl. reflexivity.
  Qed.

  Example lower_grade_thrice :
    lower_grade (lower_grade (lower_grade (Grade B Minus))) = (Grade C Minus).
  Proof.
    simpl. reflexivity.
  Qed.

  Theorem lower_grade_F_Minus : lower_grade (Grade F Minus) = (Grade F Minus).
  Proof.
    simpl. reflexivity.
  Qed.

  Theorem lower_grade_lowers :
    forall (g : grade),
    grade_comparison (Grade F Minus) g = Lt ->
    grade_comparison (lower_grade g) g = Lt.
  Proof.
    intros g H.
    destruct g eqn:eG.
    - destruct m eqn:mG.
      + simpl. rewrite -> letter_comparison_Eq. reflexivity.
      + simpl. rewrite -> letter_comparison_Eq. reflexivity.
      + destruct l eqn:lG.
        * reflexivity.
        * reflexivity.
        * reflexivity.
        * reflexivity.
        * rewrite -> lower_grade_F_Minus. rewrite <- H. reflexivity.
  Qed.

  Definition apply_late_policy (late_days : nat) (g : grade) : grade :=
    if late_days <? 9 then g
    else if late_days <? 17 then lower_grade g
    else if late_days <? 21 then lower_grade (lower_grade g)
    else lower_grade (lower_grade (lower_grade g)).

  Theorem apply_late_policy_unfold :
    forall (late_days : nat) (g : grade),
      (apply_late_policy late_days g)
      =
      (if late_days <? 9 then g else
        if late_days <? 17 then lower_grade g
        else if late_days <? 21 then lower_grade (lower_grade g)
          else lower_grade (lower_grade (lower_grade g))).
  Proof.
    intros. reflexivity.
  Qed.

  Theorem no_penalty_for_mostly_n_time :
    forall (late_days : nat) (g : grade),
      (late_days <? 9 = true) ->
      apply_late_policy late_days g = g.
  Proof.
    intros late_days g H.
    rewrite -> apply_late_policy_unfold.
    rewrite -> H.
    reflexivity.
  Qed.

  Theorem grade_lowered_once :
    forall (late_days : nat) (g : grade),
      (late_days <? 9 = false) ->
      (late_days <? 17 = true) ->
      (apply_late_policy late_days g) = (lower_grade g).
Proof.
  intros late_days g H0 H1.
  rewrite -> apply_late_policy_unfold.
  rewrite -> H0.
  rewrite -> H1.
  reflexivity.
Qed.

End LateDays.

Inductive bin : Type :=
  | Z
  | B0 (n : bin)
  | B1 (n : bin).

Fixpoint incr (m:bin) : bin :=
  match m with
  | Z => B1 Z
  | B0 n => B1 n
  | B1 n => B0 (incr n)
  end.

Fixpoint bin_to_nat (m:bin) : nat :=
  match m with
  | Z => 0
  | (B0 n) => 2 * (bin_to_nat n)
  | (B1 n) => 2 * (bin_to_nat n) + 1
  end.

Example test_bin_incr1 : (incr (B1 Z)) = B0 (B1 Z).
Proof.
 simpl. reflexivity.
Qed.

Example test_bin_incr2 : (incr (B0 (B1 Z))) = B1 (B1 Z).
Proof.
  simpl. reflexivity.
Qed.

Example test_bin_incr3 : (incr (B1 (B1 Z))) = B0 (B0 (B1 Z)).
Proof.
  simpl. reflexivity.
Qed.

Example test_bin_incr4 : bin_to_nat (B0 (B1 Z)) = 2.
Proof.
  simpl. reflexivity.
Qed.

Example test_bin_incr5 : bin_to_nat (incr (B1 Z)) = 1 + bin_to_nat(B1 Z).
Proof.
  simpl. reflexivity.
Qed.

Example test_bin_incr6 : bin_to_nat (incr (incr (B1 Z))) = 2 + bin_to_nat (B1 Z).
Proof.
  simpl. reflexivity.
Qed.
