(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2011     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(* $Id: coq_tactics.ml 14641 2011-11-06 11:59:10Z herbelin $ *)

let tactics = [
  "Abstract";
  "Absurd";
  "Apply";
  "Apply ... with";
  "Assert";
  "Assumption";
  "Auto";
  "AutoRewrite";
  "Binding list";
  "Case";
  "Case ... with";
  "Cbv";
  "Change";
  "Change ... in";
  "Clear";
  "ClearBody";
  "Compare";
  "Compute";
  "Constructor";
  "Constructor ... with";
  "Contradiction";
  "Conversion tactics";
  "Cut";
  "CutRewrite";
  "Decide Equality";
  "Decompose";
  "Decompose Record";
  "Decompose Sum";
  "Dependent Inversion";
  "Dependent Inversion ... with";
  "Dependent Inversion_clear";
  "Dependent Inversion_clear ... with";
  "Dependent Rewrite ->";
  "Dependent Rewrite <-";
  "Derive Inversion";
  "Destruct";
  "Discriminate";
  "DiscrR";
  "Do";
  "Double Induction";
  "EApply";
  "EAuto";
  "Elim ... using";
  "Elim ... with";
  "ElimType";
  "Exact";
  "Exists";
  "Fail";
  "Field";
  "First";
  "Fold";
  "Fourier";
  "Generalize";
  "Generalize Dependent";
  "Print Hint";
  "Hnf";
  "Idtac";
  "Induction";
  "Info";
  "Injection";
  "Intro";
  "Intro ... after";
  "Intro after";
  "Intros";
  "Intros pattern";
  "Intros until";
  "Intuition";
  "Inversion";
  "Inversion ... in";
  "Inversion ... using";
  "Inversion ... using ... in";
  "Inversion_clear";
  "Inversion_clear ... in";
  "LApply";
  "Lazy";
  "Left";
  "LetTac";
  "Move";
  "NewDestruct";
  "NewInduction";
  "Omega";
  "Orelse";
  "Pattern";
  "Pose";
  "Prolog";
  "Quote";
  "Red";
  "Refine";
  "Reflexivity";
  "Rename";
  "Repeat";
  "Replace ... with";
  "Rewrite";
  "Rewrite ->";
  "Rewrite -> ... in";
  "Rewrite <-";
  "Rewrite <- ... in";
  "Rewrite ... in";
  "Right";
  "Ring";
  "Setoid_replace";
  "Setoid_rewrite";
  "Simpl";
  "Simple Inversion";
  "Simplify_eq";
  "Solve";
  "Split";
  "SplitAbsolu";
  "SplitRmult";
  "Subst";
  "Symmetry";
  "Tacticals";
  "Tauto";
  "Transitivity";
  "Trivial";
  "Try";
  "tactic macros";
  "Unfold";
  "Unfold ... in";
]
