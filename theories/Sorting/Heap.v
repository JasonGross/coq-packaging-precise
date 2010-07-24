(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2010     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id$ i*)

(** This file is deprecated, for a tree on list, use [Mergesort.v]. *)

(** A development of Treesort on Heap trees. It has an average
    complexity of O(n.log n) but of O(n²) in the worst case (e.g. if
    the list is already sorted) *)

(* G. Huet 1-9-95 uses Multiset *)

Require Import List Multiset PermutSetoid Relations Sorting.

Section defs.

  (** * Trees and heap trees *)

  (** ** Definition of trees over an ordered set *)

  Variable A : Type.
  Variable leA : relation A.
  Variable eqA : relation A.

  Let gtA (x y:A) := ~ leA x y.

  Hypothesis leA_dec : forall x y:A, {leA x y} + {leA y x}.
  Hypothesis eqA_dec : forall x y:A, {eqA x y} + {~ eqA x y}.
  Hypothesis leA_refl : forall x y:A, eqA x y -> leA x y.
  Hypothesis leA_trans : forall x y z:A, leA x y -> leA y z -> leA x z.
  Hypothesis leA_antisym : forall x y:A, leA x y -> leA y x -> eqA x y.

  Hint Resolve leA_refl.
  Hint Immediate eqA_dec leA_dec leA_antisym.

  Let emptyBag := EmptyBag A.
  Let singletonBag := SingletonBag _ eqA_dec.

  Inductive Tree :=
    | Tree_Leaf : Tree
    | Tree_Node : A -> Tree -> Tree -> Tree.

  (** [a] is lower than a Tree [T] if [T] is a Leaf
      or [T] is a Node holding [b>a] *)

  Definition leA_Tree (a:A) (t:Tree) :=
    match t with
      | Tree_Leaf => True
      | Tree_Node b T1 T2 => leA a b
    end.

  Lemma leA_Tree_Leaf : forall a:A, leA_Tree a Tree_Leaf.
  Proof.
    simpl in |- *; auto with datatypes.
  Qed.

  Lemma leA_Tree_Node :
    forall (a b:A) (G D:Tree), leA a b -> leA_Tree a (Tree_Node b G D).
  Proof.
    simpl in |- *; auto with datatypes.
  Qed.


  (** ** The heap property *)

  Inductive is_heap : Tree -> Prop :=
    | nil_is_heap : is_heap Tree_Leaf
    | node_is_heap :
      forall (a:A) (T1 T2:Tree),
        leA_Tree a T1 ->
        leA_Tree a T2 ->
        is_heap T1 -> is_heap T2 -> is_heap (Tree_Node a T1 T2).

  Lemma invert_heap :
    forall (a:A) (T1 T2:Tree),
      is_heap (Tree_Node a T1 T2) ->
      leA_Tree a T1 /\ leA_Tree a T2 /\ is_heap T1 /\ is_heap T2.
  Proof.
    intros; inversion H; auto with datatypes.
  Qed.

  (* This lemma ought to be generated automatically by the Inversion tools *)
  Lemma is_heap_rect :
    forall P:Tree -> Type,
      P Tree_Leaf ->
      (forall (a:A) (T1 T2:Tree),
	leA_Tree a T1 ->
	leA_Tree a T2 ->
	is_heap T1 -> P T1 -> is_heap T2 -> P T2 -> P (Tree_Node a T1 T2)) ->
      forall T:Tree, is_heap T -> P T.
  Proof.
    simple induction T; auto with datatypes.
    intros a G PG D PD PN.
    elim (invert_heap a G D); auto with datatypes.
    intros H1 H2; elim H2; intros H3 H4; elim H4; intros.
    apply X0; auto with datatypes.
  Qed.

  (* This lemma ought to be generated automatically by the Inversion tools *)
  Lemma is_heap_rec :
    forall P:Tree -> Set,
      P Tree_Leaf ->
      (forall (a:A) (T1 T2:Tree),
	leA_Tree a T1 ->
	leA_Tree a T2 ->
	is_heap T1 -> P T1 -> is_heap T2 -> P T2 -> P (Tree_Node a T1 T2)) ->
      forall T:Tree, is_heap T -> P T.
  Proof.
    simple induction T; auto with datatypes.
    intros a G PG D PD PN.
    elim (invert_heap a G D); auto with datatypes.
    intros H1 H2; elim H2; intros H3 H4; elim H4; intros.
    apply X; auto with datatypes.
  Qed.

  Lemma low_trans :
    forall (T:Tree) (a b:A), leA a b -> leA_Tree b T -> leA_Tree a T.
  Proof.
    simple induction T; auto with datatypes.
    intros; simpl in |- *; apply leA_trans with b; auto with datatypes.
  Qed.

  (** ** Merging two sorted lists *)

  Inductive merge_lem (l1 l2:list A) : Type :=
    merge_exist :
    forall l:list A,
      Sorted leA l ->
      meq (list_contents _ eqA_dec l)
      (munion (list_contents _ eqA_dec l1) (list_contents _ eqA_dec l2)) ->
      (forall a, HdRel leA a l1 -> HdRel leA a l2 -> HdRel leA a l) ->
      merge_lem l1 l2.

  Lemma merge :
    forall l1:list A, Sorted leA l1 ->
    forall l2:list A, Sorted leA l2 -> merge_lem l1 l2.
  Proof.
    simple induction 1; intros.
    apply merge_exist with l2; auto with datatypes.
    elim H2; intros.
    apply merge_exist with (a :: l); simpl in |- *; auto using cons_sort with datatypes.
    elim (leA_dec a a0); intros.

    (* 1 (leA a a0) *)
    cut (merge_lem l (a0 :: l0)); auto using cons_sort with datatypes.
    intros [l3 l3sorted l3contents Hrec].
    apply merge_exist with (a :: l3); simpl in |- *;
      auto using cons_sort, cons_leA with datatypes.
    apply meq_trans with
      (munion (singletonBag a)
	(munion (list_contents _ eqA_dec l)
          (list_contents _ eqA_dec (a0 :: l0)))).
    apply meq_right; trivial with datatypes.
    apply meq_sym; apply munion_ass.
    intros; apply cons_leA.
    apply (@HdRel_inv _ leA) with l; trivial with datatypes.

    (* 2 (leA a0 a) *)
    elim X0; simpl in |- *; intros.
    apply merge_exist with (a0 :: l3); simpl in |- *;
      auto using cons_sort, cons_leA with datatypes.
    apply meq_trans with
      (munion (singletonBag a0)
	(munion (munion (singletonBag a) (list_contents _ eqA_dec l))
          (list_contents _ eqA_dec l0))).
    apply meq_right; trivial with datatypes.
    apply munion_perm_left.
    intros; apply cons_leA; apply HdRel_inv with (l:=l0); trivial with datatypes.
  Qed.


  (** ** From trees to multisets *)

  (** contents of a tree as a multiset *)

  (** Nota Bene : In what follows the definition of SingletonBag
      in not used. Actually, we could just take as postulate:
      [Parameter SingletonBag : A->multiset].  *)

  Fixpoint contents (t:Tree) : multiset A :=
    match t with
      | Tree_Leaf => emptyBag
      | Tree_Node a t1 t2 =>
	munion (contents t1) (munion (contents t2) (singletonBag a))
    end.


  (** equivalence of two trees is equality of corresponding multisets *)
  Definition equiv_Tree (t1 t2:Tree) := meq (contents t1) (contents t2).



  (** * From lists to sorted lists *)

  (** ** Specification of heap insertion *)

  Inductive insert_spec (a:A) (T:Tree) : Type :=
    insert_exist :
    forall T1:Tree,
      is_heap T1 ->
      meq (contents T1) (munion (contents T) (singletonBag a)) ->
      (forall b:A, leA b a -> leA_Tree b T -> leA_Tree b T1) ->
      insert_spec a T.


  Lemma insert : forall T:Tree, is_heap T -> forall a:A, insert_spec a T.
  Proof.
    simple induction 1; intros.
    apply insert_exist with (Tree_Node a Tree_Leaf Tree_Leaf);
      auto using node_is_heap, nil_is_heap, leA_Tree_Leaf with datatypes.
    simpl in |- *; unfold meq, munion in |- *; auto using node_is_heap with datatypes.
    elim (leA_dec a a0); intros.
    elim (X a0); intros.
    apply insert_exist with (Tree_Node a T2 T0);
      auto using node_is_heap, nil_is_heap, leA_Tree_Leaf with datatypes.
    simpl in |- *; apply treesort_twist1; trivial with datatypes.
    elim (X a); intros T3 HeapT3 ConT3 LeA.
    apply insert_exist with (Tree_Node a0 T2 T3);
      auto using node_is_heap, nil_is_heap, leA_Tree_Leaf with datatypes.
    apply node_is_heap; auto using node_is_heap, nil_is_heap, leA_Tree_Leaf with datatypes.
    apply low_trans with a; auto with datatypes.
    apply LeA; auto with datatypes.
    apply low_trans with a; auto with datatypes.
    simpl in |- *; apply treesort_twist2; trivial with datatypes.
  Qed.


  (** ** Building a heap from a list *)

  Inductive build_heap (l:list A) : Type :=
    heap_exist :
    forall T:Tree,
      is_heap T ->
      meq (list_contents _ eqA_dec l) (contents T) -> build_heap l.

  Lemma list_to_heap : forall l:list A, build_heap l.
  Proof.
    simple induction l.
    apply (heap_exist nil Tree_Leaf); auto with datatypes.
    simpl in |- *; unfold meq in |- *; exact nil_is_heap.
    simple induction 1.
    intros T i m; elim (insert T i a).
    intros; apply heap_exist with T1; simpl in |- *; auto with datatypes.
    apply meq_trans with (munion (contents T) (singletonBag a)).
    apply meq_trans with (munion (singletonBag a) (contents T)).
    apply meq_right; trivial with datatypes.
    apply munion_comm.
    apply meq_sym; trivial with datatypes.
  Qed.


  (** ** Building the sorted list *)

  Inductive flat_spec (T:Tree) : Type :=
    flat_exist :
    forall l:list A,
      Sorted leA l ->
      (forall a:A, leA_Tree a T -> HdRel leA a l) ->
      meq (contents T) (list_contents _ eqA_dec l) -> flat_spec T.

  Lemma heap_to_list : forall T:Tree, is_heap T -> flat_spec T.
  Proof.
    intros T h; elim h; intros.
    apply flat_exist with (nil (A:=A)); auto with datatypes.
    elim X; intros l1 s1 i1 m1; elim X0; intros l2 s2 i2 m2.
    elim (merge _ s1 _ s2); intros.
    apply flat_exist with (a :: l); simpl in |- *; auto with datatypes.
    apply meq_trans with
      (munion (list_contents _ eqA_dec l1)
	(munion (list_contents _ eqA_dec l2) (singletonBag a))).
    apply meq_congr; auto with datatypes.
    apply meq_trans with
      (munion (singletonBag a)
	(munion (list_contents _ eqA_dec l1) (list_contents _ eqA_dec l2))).
    apply munion_rotate.
    apply meq_right; apply meq_sym; trivial with datatypes.
  Qed.


  (** * Specification of treesort *)

  Theorem treesort :
    forall l:list A,
    {m : list A | Sorted leA m & permutation _ eqA_dec l m}.
  Proof.
    intro l; unfold permutation in |- *.
    elim (list_to_heap l).
    intros.
    elim (heap_to_list T); auto with datatypes.
    intros.
    exists l0; auto with datatypes.
    apply meq_trans with (contents T); trivial with datatypes.
  Qed.

End defs.
