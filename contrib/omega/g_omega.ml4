(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)
(**************************************************************************)
(*                                                                        *)
(* Omega: a solver of quantifier-free problems in Presburger Arithmetic   *)
(*                                                                        *)
(* Pierre Cr�gut (CNET, Lannion, France)                                  *)
(*                                                                        *)
(**************************************************************************)

(*i camlp4deps: "parsing/grammar.cma" i*)

(* $Id: g_omega.ml4 7734 2005-12-26 14:06:51Z herbelin $ *)

open Coq_omega

TACTIC EXTEND omega
  [ "omega" ] -> [ omega_solver ]
END
