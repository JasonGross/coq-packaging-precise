(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(* $Id: Fourier.v 5920 2004-07-16 20:01:26Z herbelin $ *)

(* "Fourier's method to solve linear inequations/equations systems.".*)

Declare ML Module "quote".
Declare ML Module "ring".
Declare ML Module "fourier".
Declare ML Module "fourierR".
Declare ML Module "field".

Require Export Fourier_util.
Require Export Field.
Require Export DiscrR.

Ltac fourier := abstract (fourierz; field; discrR).

Ltac fourier_eq := apply Rge_antisym; fourier.
