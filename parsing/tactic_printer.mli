(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: tactic_printer.mli 6113 2004-09-17 20:28:19Z barras $ i*)

(*i*)
open Pp
open Sign
open Evd
open Tacexpr
open Proof_type
(*i*)

(* These are the entry points for tactics, proof trees, ... *)

val print_proof : evar_map -> named_context -> proof_tree -> std_ppcmds
val pr_rule     : rule -> std_ppcmds
val pr_tactic   : tactic_expr -> std_ppcmds
val print_script :
  bool -> evar_map -> named_context -> proof_tree -> std_ppcmds
val print_treescript :
  bool -> evar_map -> named_context -> proof_tree -> std_ppcmds