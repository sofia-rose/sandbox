From Stdlib Require Import Arith.

Parameters
  (prime_divisor : nat -> nat)
  (prime : nat -> Prop)
  (divides : nat -> nat -> Prop).

Open Scope nat_scope.

Check (prime (prime_divisor 220)).

Check (divides (prime_divisor 220) 220).

Check (divides 3).

Parameter binary_word : nat -> Set.

Definition short : Set := binary_word 32.

Definition long : Set := binary_word 64.

Check (not (divides 3 81)).

Check (let d := prime_divisor 220 in prime d /\ divides d 220).

From Stdlib Require Import List.

Parameters
  (decomp : nat -> list nat)
  (decomp2: nat -> nat * nat).

Check (decomp 220).

Check (decomp2 284).

Parameter prime_divisor_correct : forall n:nat, 2 <= n -> let d:= prime_divisor n in prime d /\ divides d n.

Check prime_divisor_correct.

Check cons.

Check pair.

Check (forall A B:Set, A -> B -> A * B).

Check fst.

Check le_n.

Check le_S.

Check (le_n 36).

Definition le_36_37 := le_S 36 36 (le_n 36).

Check le_36_37.

Definition le_36_38 := le_S 36 37 le_36_37.

Check le_36_38.

Check (le_S _ _ (le_S _ _ (le_n 36))).

Check (prime_divisor_correct 220).

From Stdlib Require Import Nat.

Check iter.

Definition iterate := fun (A: Set) (f: A -> A) (n: nat) (x: A) => iter n f x.

Check (iterate nat).

Check (iterate _ (mult 2)).

Check (iterate _ (mult 2) 10).

Check (iterate _ (mult 2) 10 1).

Eval compute in (iterate _ (mult 2) 10 1).

From Stdlib Require Import ZArith.

(* Check (iterate Z (Zmult 2) 5 36). *)

Parameter binary_word_concat : forall n m : nat, binary_word n  -> binary_word m -> binary_word (n + m).


Check (binary_word_concat 32).

Check (binary_word_concat 32 32).

Definition twice : forall A:Set, (A -> A) -> A -> A := fun A f a => f (f a).

Check (twice Z).

Check (twice Z (fun z => (z * z)%Z)).

Check (twice _ S 56).

Check (twice (nat -> nat) (fun f x => f (f x)) (mult 3)).

Eval compute in
    (twice (nat -> nat) (fun f x => f (f x)) (mult 3) 1).

Definition binary_word_duplicate (n:nat) (w: binary_word n) : binary_word (n + n)
  := binary_word_concat _ _ w w.

Theorem le_i_SSi : forall i:nat, i <= S (S i).
Proof (fun i:nat => le_S _ _(le_S _ _ (le_n i))).

Definition compose : forall A B C : Set, (A -> B) -> (B -> C) -> A -> C
  := fun A B C f g x => g (f x).

Print compose.

Check (fun (A : Set) (f : Z -> A) => compose _ _ _ Z_of_nat f).

Check (compose _ _ _ Z.abs_nat (plus 78) 45%Z).

Check (le_i_SSi 1515).

Check (le_S _ _ (le_i_SSi 1515)).

Check (iterate _ (fun x => x) 23).

Definition compose' {A B C} (f : A -> B) (g : B -> C) (x : A) := g (f x).

Check (compose' Z.abs_nat (plus 78)).

Definition le_S' {n m} := le_S n m.

Check le_S'.

Check (le_S' (le_i_SSi 1515)).

Definition thrice {A : Set} (f : A -> A) := compose' f (compose' f f).

Print thrice.

Eval cbv beta delta in (thrice thrice S 0).

Definition short_concat : short -> short -> long
  := binary_word_concat 32 32.

Section A_declared.
  Variables (A : Set) (P Q : A -> Prop) (R : A -> A -> Prop).

  Theorem all_perm : (forall a b : A, R a b) -> forall a b : A, R b a.
  Proof (fun f a b => f b a).

  Theorem all_imp_dist :
    (forall a : A, P a -> Q a) -> (forall a : A, P a) -> (forall a : A, Q a).
  Proof (fun f g x => f x (g x)).

  Theorem all_delta : (forall a b : A, R a b) -> (forall a : A, R a a).
  Proof (fun f a => f a a).
End A_declared.

Check (nat -> Set).

Check (forall n : nat, 0 < n -> nat).

Definition my_plus : nat -> nat -> nat := iterate nat S.

Definition my_mult (n p : nat) : nat :=
  iterate nat (my_plus n) p 0.

Definition my_expor (x n : nat) : nat := iterate nat (my_mult x) n 1.

Definition ackermann (n : nat) : nat -> nat :=
  iterate (nat -> nat)
          (fun (f : nat -> nat) (p : nat) => iterate nat f (S p) 1)
          n
          S.

Check (forall A : Set, A -> A).

Definition id (A : Set) (x : A) := x.

Check (forall A B : Set, (A -> A -> B) -> A -> B).

Definition diag (A B : Set) (f : A -> A -> B) (x : A) := f x x.

Check (forall A B C : Set, (A -> B -> C) -> B -> A -> C).

Definition permute (A B C : Set) (f : A -> B -> C) (b : B) (a : A) := f a b.

Check (forall A : Set, (nat -> A) -> Z -> A).

Definition f_nat_Z (A : Set) (f : nat -> A) (z : Z) := f (Z.abs_nat z).

Check (forall P : Prop, P -> P).

Check (fun (P : Prop) (p : P) => p).

Check (forall (A : Type) (P : A -> A -> Prop), (forall x y : A, P x y) -> forall x y : A, P  y x).

Theorem all_perm' : forall (A : Type) (P : A -> A -> Prop), (forall x y : A, P x y) -> forall x y : A, P  y x.
Proof (fun A P p x y => p y x).

Check (
  forall (A : Type) (P Q R S : A -> Prop)
  ,  (forall a : A, Q a -> R a -> S a)
  -> (forall b : A, P b -> Q b)
  -> (forall c : A, P c -> R c -> S c)
    ).


Theorem resolution :
  forall (A : Type) (P Q R S : A -> Prop)
  ,  (forall a : A, Q a -> R a -> S a)
  -> (forall b : A, P b -> Q b)
  -> (forall c : A, P c -> R c -> S c)
  .
  Proof (fun A P Q R S f g c pc rc => f c (g c pc) rc).

Check False_ind.
Check False_rec.
Check False_rect.

(* Check (not (true = 1)). *)

Check refl_equal.

Theorem ThirtySix : 9 * 4 = 6 * 6.
Proof (refl_equal 36).

Check eq_ind.

Check eq_rec.

Check eq_rect.

Definition eq_sym (A : Type) (x y : A) (h : x = y) : y = x :=
  eq_ind x (fun z => z = x) (refl_equal x) y h.

Check (eq_sym _ _ _ ThirtySix).

Definition not (P : Prop) : Prop := P -> False.

Check conj.

Check or_introl.

Check or_intror.

Check and_ind.

Theorem conj3 : forall P Q R : Prop, P -> Q -> R -> P /\ Q /\ R.
Proof (fun P Q R p q r => conj p (conj q r)).

Theorem disj4_3 : forall P Q R S : Prop, R -> P \/ Q \/  R \/ S.
Proof (fun P Q R S r => or_intror _ (or_intror _ (or_introl _ r))).

Definition proj1' : forall A B : Prop, A /\ B -> A :=
  fun (A B : Prop) (H : A /\ B) => and_ind (fun (H0 : A) (_ : B) => H0) H.

Check (ex (fun z:Z => (z * z <=37 /\ 37 < (z + 1) * (z + 1))%Z)).

Check ex_intro.

Check ex_ind.

Check list.

(* In the book, these do not work, but newer versions of Rocq allow lists of Prop *)
Check (cons (3 <= 6)%Z nil).

Check (list Prop).

(*
Check (cons 655 (cons (-273)%Z nil)).
 *)

Check (cons 655%Z (cons (-273)%Z nil)).
