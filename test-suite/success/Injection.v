(* Check the behaviour of Injection *)

(* Check that Injection tries Intro until *)

Lemma l1 : forall x : nat, S x = S (S x) -> False.
 injection 1.
apply n_Sn.
Qed.

Lemma l2 : forall (x : nat) (H : S x = S (S x)), H = H -> False.
 injection H.
intros.
apply (n_Sn x H0).
Qed.

(* Check that no tuple needs to be built *)
Lemma l3 :
 forall x y : nat,
 existS (fun n : nat => {n = n} + {n = n}) x (left _ (refl_equal x)) =
 existS (fun n : nat => {n = n} + {n = n}) y (left _ (refl_equal y)) -> 
 x = y.
intros x y H.
 injection H.
exact (fun H => H).
Qed.

(* Check that a tuple is built (actually the same as the initial one) *)
Lemma l4 :
 forall p1 p2 : {0 = 0} + {0 = 0},
 existS (fun n : nat => {n = n} + {n = n}) 0 p1 =
 existS (fun n : nat => {n = n} + {n = n}) 0 p2 ->
 existS (fun n : nat => {n = n} + {n = n}) 0 p1 =
 existS (fun n : nat => {n = n} + {n = n}) 0 p2.
intros.
 injection H.
exact (fun H => H).
Qed.

