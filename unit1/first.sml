(* comment - first program hellooooo *)

val x = 34
(* static env happens before running - goes through like
 c preprocessor.  concerned with typechecking. 
everything must typecheck properly before running. *)
(* static env: x: int  *)
(* dynamic environment: x --> 34 *)

val y = 17
(* static env: x : int, y : int *)
(* dynamic env: x --> 34, y --> 17 *)

val z = (x + y) + (y + 2)
(* stat env: x : int, y : int, z : int *)
(* dyn env: x-->34, y-->17, z-->70 *)

val q = z + 1
(* dyn env: x-->34, y-->17, z-->70, q->71 *)

val abs_of_z = if z < 0 then 0 - z else z
(* between if and then must have type bool  *)

val abs_of_z_simpler = abs(z)

(* Every expressions has: 
     - syntax
     - type-checking rules: produces a type or fails
     - evaluation rules: used on things that type check
          - produces a value*)

(* variable = simplest expression
    - syntax : letters, digits, _  
    - type-checking: look up type in current stat env
    - eval - look up in curr dyn env
          - must be in dyn env cuz it got to this point*)

(* addition
  - syntax - e1 + e2 where e1 and e2 are expressions
  - type check - e1 and e2 must have type int as result
           of their expression
  - eval - make an int *)

(* values:
        all vals are expressions, but not all expr 
        are vals *)

(* conditional:
    - syntax - if e1 then e2 else e3
    - type check - e1 = bool
                e2 and e3 any type but must have 
                same type t, which becomes type of 
                entire expression.

    - eval rules = first eval e1 to a bool
           - then evaluate e2 or e3 depending.*)

(* less than:
    - syntax - e1 < e2 
    - type check: e1 = e2 = t, result is a bool
        fail if not equal types
    - eval - first evaluate e1 and e2, then if 
       e1 is less than e2 result is true else false
*)
			  
			  
