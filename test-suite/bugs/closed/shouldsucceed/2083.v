Require Import Program Arith.
Set Implicit Arguments.

Program Fixpoint check_n  (n : nat) (P : { i | i < n } -> bool) (p : nat)
  (H : forall (i : { i | i < n }), i < p -> P i = true)
  {measure (fun i => n - i) p} : 
  Exc (forall (p : { i | i < n}), P p = true) :=
  match le_lt_dec n p with
  | left _ => value _
  | right cmp => 
      if dec (P p) then
        check_n (S p) _
      else
        error
  end.

Require Import Omega.

Next Obligation.
  apply H. simpl. omega.
Defined.

Next Obligation. omega. Defined.
Next Obligation.
  case (le_lt_dec p i) ; intros. assert(i = p) by omega. subst.
  revert H0. clear_subset_proofs. auto.
  apply H. simpl. assumption. Defined.
