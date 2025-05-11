Require Import Arith.

Parameters
  (prime_divisor : nat -> nat)
  (prime : nat -> Prop)
  (divides : nat -> nat -> Prop).

Open Scope nat_scope.

Check (prime (prime_divisor 220)).

Check (divides (prime_divisor 220) 220).

Check (divides 3).

Parameter binary_word : nat -> Set.


