(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2011     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(* $Id: Rpow_def.v 14641 2011-11-06 11:59:10Z herbelin $ *)

Require Import Rdefinitions.

Fixpoint pow (r:R) (n:nat) : R :=
  match n with
    | O => R1
    | S n => Rmult r (pow r n)
  end.
