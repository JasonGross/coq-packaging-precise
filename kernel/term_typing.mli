(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: term_typing.mli 6245 2004-10-20 13:50:08Z barras $ i*)

(*i*)
open Names
open Term
open Univ
open Declarations
open Inductive
open Environ
open Entries
open Typeops
(*i*)

val translate_local_def : env -> constr * types option -> 
  constr * types * Univ.constraints

val translate_local_assum : env -> types ->
  types * Univ.constraints
 
val translate_constant : env -> constant -> constant_entry -> constant_body

val translate_mind : 
  env -> mutual_inductive_entry -> mutual_inductive_body

val translate_recipe : 
  env -> constant -> Cooking.recipe -> constant_body
