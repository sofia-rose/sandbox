Require Import Arith.
Require Import ZArith.
Require Import Bool.

Open Scope Z_scope.

Locate "_ * _".

Print Scope Z_scope.

Check 33%nat.

Check 0%nat.

Check O.

Open Scope nat_scope.

Check 33.

Check O.

Check 33%Z.

Check (-12)%Z.

Open Scope Z_scope.

Check (-12).

Check (33%nat).

Check true.

Check false.

Check plus.

Check Zplus.

Check negb.

Check orb.

Check negb.

Check (negb true).

Check (negb (negb true)).

Check (((ifb (negb false)) true) false).

Open Scope nat_scope.

Check (S (S (S O))).

Check (mult (mult 5 (minus 5 4)) 7).

Check (5*(5-4)*7).

Unset Printing Notations.
Set Printing Raw Literals.

Check 4.

Check (5*(5-4)*7).

Set Printing Notations.
Unset Printing Raw Literals.

Check (minus (S (S (S (S (S O))))) (S (S (S (S O))))).

Open Scope Z_scope.

Check (Z.opp (Z.mul 3 (Z.sub (-5) (-8)))).

Check ((-4)*(7-7)).

Open Scope nat_scope.

Check (Nat.add 3).

Check (Z.mul (-5)).

Check Z.abs_nat.

Check (5 + Z.abs_nat (5-19)).

Check fun a b c:Z => (b*b-4*a*c)%Z.

Check fun (f g :nat->nat)(n:nat) => g (f n).

Check (fun n (z:Z) f => (n + (Z.abs_nat (f z)))%nat).

Check (fun f (x:Z) => Z.abs_nat (f x x)).

Check (fun n _:nat => n).

Check (fun n p:nat => p).

Definition t1 := fun n:nat => let s:= Nat.add n (S n) in Nat.mul n (Nat.mul s s).

Parameter max_int : Z.

Open Scope Z_scope.

Definition min_int := 1-max_int.
Print min_int.

Definition cube0 := fun z:Z => z * z * z.

Definition cube1 (z:Z) : Z := z * z * z.

Definition cube2 z := z * z * z.

Print cube0.

Print cube1.

Print cube2.

Definition Z_thrice (f:Z->Z) (z:Z) := f (f (f z)).

Definition plus9 := Z_thrice (Z_thrice (fun z:Z => z+1)).

Definition add5 := fun a b c d e : Z => a + b + c + d + e .

Print add5.

Section binomial_def.
  Variables a b:Z.
  Definition binomial z:Z := a*z + b.
  Print binomial.
  Section trinomial_def.
    Variable c : Z.
    Definition trinomial z:Z := (binomial z) * z + c.
    Print trinomial.
  End trinomial_def.
  Print trinomial.
End binomial_def.

Print binomial.

Print trinomial.

Definition p1 : Z -> Z := binomial 5 (-3).

Definition p2 : Z -> Z := trinomial 1 0 (-1).

Definition p3 := trinomial 1 (-2) 1.

Print p1.

Print p2.

Print p3.

Section mab.
  Variables m a b: Z.
  Definition f := m * a * m.
  Definition g := m * (a + b).
  Print f.
  Print g.
End mab.
Print f.
Print g.

Section another_add5.
  Variables a b c d e: Z.
  Definition another_add5 := a + b + c + d + e.
End another_add5.
Print another_add5.

Section h_def.
  Variables a b:Z.
  Let s:Z := a + b.
  Let d:Z := a - b.
  Definition h : Z := s * s + d * d.
End h_def.
Print h.

Definition Zsqr (z:Z) : Z := z * z.

Definition my_fun (f:Z->Z) (z: Z) : Z := f (f z).

Eval cbv delta [my_fun Zsqr] in (my_fun Zsqr).

Eval cbv delta [my_fun] in (my_fun Zsqr).

Eval cbv beta delta [my_fun Zsqr] in (my_fun Zsqr).

Eval cbv beta delta [h] in (h 56 78).

Eval cbv beta zeta delta [h] in (h 56 78).

(* compute is a synonym for cbv iota beta zeta delta *)
Eval compute in (h 56 78).

Eval compute in (my_fun Zsqr 3).

Check Z.

Check ((Z -> Z) -> nat -> nat).

Check Set.

Check Type.

Definition Z_bin : Set := Z -> Z -> Z.

Check (fun z0 z1 : Z => let d := z0 - z1 in d * d).

Definition Zdist2 : Z_bin := fun z z0: Z => let d := z - z0 in d * d.

Print Zdist2.

Check (nat -> nat).

Check (nat -> nat : Type).

Section domain.
  Variables (D:Set) (op:D -> D -> D)(sym:D-> D)(e:D).
  Let diff : D -> D -> D := fun (x y:D) => op x (sym y).
  Print diff.
End domain.

Section realization.
  Variables (A B : Set).
  Let spec : Set := (((A -> B) -> B) -> B) -> A -> B.
  Let realization : spec := fun (f:((A -> B) -> B) -> B) a => f (fun g => g a).
  Print spec.
  Print realization.
End realization.

Definition nat_fun_to_Z_fun : Set := (nat -> nat) -> Z -> Z.

Definition absolute_fun : nat_fun_to_Z_fun := fun f z => Z.of_nat (f (Z.abs_nat z)).

Definition always_0 : nat_fun_to_Z_fun := fun _ _ => 0%Z.

Definition to_marignan : nat_fun_to_Z_fun := fun _ _ => 1515%Z.

Definition ignore_f : nat_fun_to_Z_fun := fun _ z => z.

Definition from_marignan : nat_fun_to_Z_fun := fun f _ => Z.of_nat (f 1515%nat).
