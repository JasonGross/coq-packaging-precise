(* Cases with let-in in constructors types *)

Inductive t : Set :=
    k : let x := t in x -> x.

Print t_rect.
