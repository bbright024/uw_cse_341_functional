(* Dan Grossman, CSE341, HW3 Provided Code *)

exception NoAnswer


fun only_lowercase (strs) =
    List.filter (fn st => Char.isLower(String.sub(st, 0))) strs

fun longest_string_1 (strs) =
    foldl (fn (accu, s1) => if String.size(s1) >= String.size(accu)
			     then s1
			     else accu)
	   "" strs

fun longest_string_2 (strs) =
    foldl (fn (accu, s1) => if String.size(s1) > String.size(accu)
			     then s1
			     else accu)
	   "" strs


fun longest_string_helper f =
    if f (5, 4) then foldl (fn (accu, s1) => if String.size(s1) >= String.size(accu) then s1
					    else accu) ""
    else foldl (fn (accu, s1) => if String.size(s1) > String.size(accu)
			     then s1
			     else accu) ""
    
val longest_string_3 = longest_string_helper (fn (x, y) => x > y)
val longest_string_4 = longest_string_helper (fn (x, y) => y >= x)			   
	
val longest_lowercase = longest_string_3 o only_lowercase

val caps_no_X_string = String.implode o List.filter (fn c => Char.compare(c, #"X") <> EQUAL)
		       o String.explode	o String.map (fn c => Char.toUpper(c))





						     
fun first_answer predicate xs =
    case xs of
	[] => raise NoAnswer
      | x::xs' => case predicate x of
		      SOME v => v
		   | _ => first_answer predicate xs'

fun all_answers predicate xs =
    let fun helper(x_list, accu) =
	    case x_list of
		[] => SOME accu
	      | x::x_list' => case predicate x of
				  NONE => NONE
				| SOME lst => helper(x_list', lst @ accu)
    in
	helper(xs, [])
    end






	
datatype pattern = WildcardP
                 | VariableP of string
                 | UnitP
                 | ConstantP of int
                 | ConstructorP of string * pattern
                 | TupleP of pattern list

datatype valu = Constant of int
              | Unit
              | Constructor of string * valu
              | Tuple of valu list

(* g curries 3 arguments, f1, f2 and p, where f1 and f2 are functions that
are called depending on what p evaluates to in the case expression.   
what g computes differs on the case of pattern p.  
  -p as a wildcard : g computes the function f1 with no arguments 
  -p as a variable : g computes function f2 with the variable 'x' as an arg 
  -p as a constructor : g finishes a partial application of itself with the pattern
                        in the constructor 
  -p as a tuple : g uses List.foldl to compute the result of g for every pattern in
              the list in the tuple, eventually returning an int value that represents
              the entire pattern list
overall, g returns an int value that varies depending on the functions passed in. *)
			      
fun g f1 f2 p =
    let 
        val r = g f1 f2 
    in
        case p of
            WildcardP         => f1 ()
          | VariableP x       => f2 x
          | ConstructorP(_,p) => r p
          | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
          | _                 => 0
    end


fun count_wildcards p = g (fn () => 1) (fn x => 0) p
      
fun count_wild_and_variable_lengths p = g (fn () => 1) (fn x => String.size(x)) p
					  
fun count_a_var (s, p) = g (fn () => 0) (fn x => if String.compare(x, s) = EQUAL then 1 else 0) p  

fun check_pat p =
    let
	fun h1 p =
	    case p of
		VariableP s => [s]
	      | ConstructorP(_,p) => h1 p 
	      | TupleP ps => List.foldl (fn (p1, accu) => h1 p1 @ accu) [] ps
	      | _ => []
	    
	fun h2 ss =
	    case ss of
		[] => false
	      | s1::ss' => List.exists (fn s2 => String.compare(s1, s2) = EQUAL) ss'
				       orelse h2 ss'
    in 
	not (h2 (h1 p))
    end


fun match (v, p) =
    case (v, p) of
	(_, WildcardP) => SOME []
      | (_, VariableP s) => SOME [(s, v)]
      | (Unit, UnitP) => SOME []
      | (Constant i, ConstantP ii) => if i = ii then SOME [] else NONE
      | (Constructor (s2, v2), ConstructorP (s1, p2)) => if s1 = s2 then match (v2, p2)
							 else NONE
      | (Tuple vs, TupleP ps) => if List.length(vs) = List.length(ps)
				 then all_answers
					  (fn vps => match vps )
					  (ListPair.zip(vs, ps))
				 else NONE
      | _ => NONE
		 

fun first_match (v, ps) =
    SOME (first_answer(fn p => match (v, p)) (ps))
    handle NoAnswer => NONE

    
(**** for the challenge problem only ****)

datatype typ = AnythingT
             | UnitT
             | IntT
             | TupleT of typ list
             | DatatypeT of string

(**** you can put all your code here ****)

