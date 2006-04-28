
Definition iszero (n : nat) : bool :=
  match n with
  | O => true
  | _ => false
  end.

 Functional Scheme iszer_ind := Induction for iszero.
 
Lemma toto : forall n : nat, n = 0 -> iszero n = true.
intros x eg.
 functional induction iszero x; simpl in |- *.
trivial.
 subst x.
inversion H_eq_.
Qed.

(* We can even reuse the proof as a scheme: *)

 Functional Scheme toto_ind := Induction for iszero.




 
Definition ftest (n m : nat) : nat :=
  match n with
  | O => match m with
         | O => 0
         | _ => 1
         end
  | S p => 0
  end.

 Functional Scheme ftest_ind := Induction for ftest. 

Lemma test1 : forall n m : nat, ftest n m <= 2.
intros n m.
 functional induction ftest n m; auto.
Qed.


Lemma test11 : forall m : nat, ftest 0 m <= 2.
intros m.
 functional induction ftest 0 m.
auto. 
auto. 
Qed.


Definition lamfix (m : nat) :=
  fix trivfun (n : nat) : nat := match n with
                                 | O => m
                                 | S p => trivfun p
                                 end.

(* Parameter v1 v2 : nat. *)

Lemma lamfix_lem : forall v1 v2 : nat, lamfix v1 v2 = v1.
intros v1 v2.
 functional induction lamfix v1 v2.
trivial.
assumption.
Defined.



(* polymorphic function *)
Require Import List.

 Functional Scheme app_ind := Induction for app.

Lemma appnil : forall (A : Set) (l l' : list A), l' = nil -> l = l ++ l'.
intros A l l'.
 functional induction app A l l';  intuition.
 rewrite <- H1; trivial.
Qed.





Require Export Arith.


Fixpoint trivfun (n : nat) : nat :=
  match n with
  | O => 0
  | S m => trivfun m
  end.


(* essaie de parametre variables non locaux:*) 

Parameter varessai : nat.

Lemma first_try : trivfun varessai = 0.
 functional induction trivfun varessai.
trivial.
simpl in |- *.
assumption.
Defined.
 

 Functional Scheme triv_ind := Induction for trivfun.

Lemma bisrepetita : forall n' : nat, trivfun n' = 0.
intros n'.
 functional induction trivfun n'.
trivial.
simpl in |- *.
assumption.
Qed.







Fixpoint iseven (n : nat) : bool :=
  match n with
  | O => true
  | S (S m) => iseven m
  | _ => false
  end.
 
Fixpoint funex (n : nat) : nat :=
  match iseven n with
  | true => n
  | false => match n with
             | O => 0
             | S r => funex r
             end
  end.
 
Fixpoint nat_equal_bool (n m : nat) {struct n} : bool :=
  match n with
  | O => match m with
         | O => true
         | _ => false
         end
  | S p => match m with
           | O => false
           | S q => nat_equal_bool p q
           end
  end.


Require Export Div2.
 
Lemma div2_inf : forall n : nat, div2 n <= n.
intros n.
 functional induction div2 n.
auto.
auto.

apply le_S.
apply le_n_S.
exact H.
Qed.

(* reuse this lemma as a scheme:*)

 Functional Scheme div2_ind := Induction for div2_inf.

Fixpoint nested_lam (n : nat) : nat -> nat :=
  match n with
  | O => fun m : nat => 0
  | S n' => fun m : nat => m + nested_lam n' m
  end.

 Functional Scheme nested_lam_ind := Induction for nested_lam.

Lemma nest : forall n m : nat, nested_lam n m = n * m.
intros n m.
 functional induction nested_lam n m; auto.
Qed.

Lemma nest2 : forall n m : nat, nested_lam n m = n * m.
intros n m. pattern n, m in |- *. 
apply nested_lam_ind; simpl in |- *; intros; auto.
Qed.

 
Fixpoint essai (x : nat) (p : nat * nat) {struct x} : nat :=
  let (n, m) := p in
  match n with
  | O => 0
  | S q => match x with
           | O => 1
           | S r => S (essai r (q, m))
           end
  end.
 
Lemma essai_essai :
 forall (x : nat) (p : nat * nat), let (n, m) := p in 0 < n -> 0 < essai x p.
intros x p.
 functional induction essai x p; intros.
inversion H.
simpl in |- *; try abstract auto with arith.
simpl in |- *; try abstract auto with arith.
Qed.

 
Fixpoint plus_x_not_five'' (n m : nat) {struct n} : nat :=
  let x := nat_equal_bool m 5 in
  let y := 0 in
  match n with
  | O => y
  | S q =>
      let recapp := plus_x_not_five'' q m in
      match x with
      | true => S recapp
      | false => S recapp
      end
  end.
 
Lemma notplusfive'' : forall x y : nat, y = 5 -> plus_x_not_five'' x y = x.
intros a b.
unfold plus_x_not_five'' in |- *.
 functional induction plus_x_not_five'' a b; intros hyp; simpl in |- *; auto.
Qed.
 
Lemma iseq_eq : forall n m : nat, n = m -> nat_equal_bool n m = true.
intros n m.
unfold nat_equal_bool in |- *.
 functional induction nat_equal_bool n m; simpl in |- *; intros hyp; auto.
inversion hyp.
inversion hyp.
Qed.
 
Lemma iseq_eq' : forall n m : nat, nat_equal_bool n m = true -> n = m.
intros n m.
unfold nat_equal_bool in |- *.
 functional induction nat_equal_bool n m; simpl in |- *; intros eg; auto.
inversion eg.
inversion eg.
Qed.
 
 
Inductive istrue : bool -> Prop :=
    istrue0 : istrue true.
 
Lemma inf_x_plusxy' : forall x y : nat, x <= x + y.
intros n m.
 functional induction plus n m; intros.
auto with arith.
auto with arith.
Qed.

 
Lemma inf_x_plusxy'' : forall x : nat, x <= x + 0.
intros n.
unfold plus in |- *.
 functional induction plus n 0; intros.
auto with arith.
apply le_n_S.
assumption.
Qed.
 
Lemma inf_x_plusxy''' : forall x : nat, x <= 0 + x.
intros n.
 functional induction plus 0 n; intros; auto with arith.
Qed.

Fixpoint mod2 (n : nat) : nat :=
  match n with
  | O => 0
  | S (S m) => S (mod2 m)
  | _ => 0
  end.
 
Lemma princ_mod2 : forall n : nat, mod2 n <= n.
intros n.
 functional induction mod2 n; simpl in |- *; auto with arith.
Qed.
 
Definition isfour (n : nat) : bool :=
  match n with
  | S (S (S (S O))) => true
  | _ => false
  end.
 
Definition isononeorfour (n : nat) : bool :=
  match n with
  | S O => true
  | S (S (S (S O))) => true
  | _ => false
  end.
 
Lemma toto'' : forall n : nat, istrue (isfour n) -> istrue (isononeorfour n).
intros n.
 functional induction isononeorfour n; intros istr; simpl in |- *;
 inversion istr.
apply istrue0.
Qed.
 
Lemma toto' : forall n m : nat, n = 4 -> istrue (isononeorfour n).
intros n.
 functional induction isononeorfour n; intros m istr; inversion istr.
apply istrue0.
Qed.
 
Definition ftest4 (n m : nat) : nat :=
  match n with
  | O => match m with
         | O => 0
         | S q => 1
         end
  | S p => match m with
           | O => 0
           | S r => 1
           end
  end.
 
Lemma test4 : forall n m : nat, ftest n m <= 2.
intros n m.
 functional induction ftest n m; auto with arith.
Qed.
 
Lemma test4' : forall n m : nat, ftest4 (S n) m <= 2.
intros n m.
 functional induction ftest4 (S n) m.
auto with arith.
auto with arith.
Qed.
 
Definition ftest44 (x : nat * nat) (n m : nat) : nat :=
  let (p, q) := x in
  match n with
  | O => match m with
         | O => 0
         | S q => 1
         end
  | S p => match m with
           | O => 0
           | S r => 1
           end
  end.
 
Lemma test44 :
 forall (pq : nat * nat) (n m o r s : nat), ftest44 pq n (S m) <= 2.
intros pq n m o r s.
 functional induction ftest44 pq n (S m).
auto with arith.
auto with arith.
auto with arith.
auto with arith.
Qed.
 
Fixpoint ftest2 (n m : nat) {struct n} : nat :=
  match n with
  | O => match m with
         | O => 0
         | S q => 0
         end
  | S p => ftest2 p m
  end.
 
Lemma test2 : forall n m : nat, ftest2 n m <= 2.
intros n m.
 functional induction ftest2 n m; simpl in |- *; intros; auto.
Qed.
 
Fixpoint ftest3 (n m : nat) {struct n} : nat :=
  match n with
  | O => 0
  | S p => match m with
           | O => ftest3 p 0
           | S r => 0
           end
  end.
 
Lemma test3 : forall n m : nat, ftest3 n m <= 2.
intros n m.
 functional induction ftest3 n m.
intros.
auto.
intros.
auto.
intros.
simpl in |- *.
auto.
Qed.
 
Fixpoint ftest5 (n m : nat) {struct n} : nat :=
  match n with
  | O => 0
  | S p => match m with
           | O => ftest5 p 0
           | S r => ftest5 p r
           end
  end.
 
Lemma test5 : forall n m : nat, ftest5 n m <= 2.
intros n m.
 functional induction ftest5 n m.
intros.
auto.
intros.
auto.
intros.
simpl in |- *.
auto.
Qed.
 
Definition ftest7 (n : nat) : nat :=
  match ftest5 n 0 with
  | O => 0
  | S r => 0
  end.
 
Lemma essai7 :
 forall (Hrec : forall n : nat, ftest5 n 0 = 0 -> ftest7 n <= 2)
   (Hrec0 : forall n r : nat, ftest5 n 0 = S r -> ftest7 n <= 2) 
   (n : nat), ftest7 n <= 2.
intros hyp1 hyp2 n.
unfold ftest7 in |- *.
 functional induction ftest7 n; auto.
Qed.
 
Fixpoint ftest6 (n m : nat) {struct n} : nat :=
  match n with
  | O => 0
  | S p => match ftest5 p 0 with
           | O => ftest6 p 0
           | S r => ftest6 p r
           end
  end.

 
Lemma princ6 :
 (forall n m : nat, n = 0 -> ftest6 0 m <= 2) ->
 (forall n m p : nat,
  ftest6 p 0 <= 2 -> ftest5 p 0 = 0 -> n = S p -> ftest6 (S p) m <= 2) ->
 (forall n m p r : nat,
  ftest6 p r <= 2 -> ftest5 p 0 = S r -> n = S p -> ftest6 (S p) m <= 2) ->
 forall x y : nat, ftest6 x y <= 2.
intros hyp1 hyp2 hyp3 n m.
generalize hyp1 hyp2 hyp3.
clear hyp1 hyp2 hyp3.
 functional induction ftest6 n m; auto.
Qed.
 
Lemma essai6 : forall n m : nat, ftest6 n m <= 2.
intros n m.
unfold ftest6 in |- *.
 functional induction ftest6 n m; simpl in |- *; auto.
Qed.













