(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2010     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(* $Id: decl_interp.mli 13323 2010-07-24 15:57:30Z herbelin $ *)

open Tacinterp
open Decl_expr
open Mod_subst


val intern_proof_instr : glob_sign -> raw_proof_instr -> glob_proof_instr
val interp_proof_instr : Decl_mode.pm_info ->
  Evd.evar_map -> Environ.env -> glob_proof_instr -> proof_instr
