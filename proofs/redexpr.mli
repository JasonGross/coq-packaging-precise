(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: redexpr.mli 7639 2005-12-02 10:01:15Z gregoire $ i*)

open Names
open Term
open Closure
open Rawterm
open Reductionops


type red_expr = (constr, evaluable_global_reference) red_expr_gen

val reduction_of_red_expr : red_expr -> reduction_function * cast_kind
(* [true] if we should use the vm to verify the reduction *)

val declare_red_expr : string -> reduction_function -> unit

(* Opaque and Transparent commands. *)
val set_opaque_const      : constant -> unit
val set_transparent_const : constant -> unit

val set_opaque_var      : identifier -> unit
val set_transparent_var : identifier -> unit



(* call by value normalisation function using the virtual machine *)
val cbv_vm : reduction_function
