(* CSE 341, HW2 Provided Code *)

(* main datatype definition we will use throughout the assignment *)
datatype json =
         Num of real (* real is what SML calls floating point numbers *)
       | String of string
       | False
       | True
       | Null
       | Array of json list
       | Object of (string * json) list

(* some examples of values of type json *)
val json_pi    = Num 3.14159
val json_hello = String "hello"
val json_false = False
val json_array = Array [Num 1.0, String "world", Null]
val json_obj   = Object [("foo", json_pi), ("bar", json_array), ("ok", True)]

(* some provided one-liners that use the standard library and/or some features
   we have not learned yet. (Only) the challenge problem will need more
   standard-library functions. *)

(* dedup : string list -> string list -- it removes duplicates *)
fun dedup xs = ListMergeSort.uniqueSort String.compare xs

(* strcmp : string * string -> order compares strings alphabetically
   where datatype order = LESS | EQUAL | GREATER *)
val strcmp = String.compare                                        
                        
(* convert an int to a real *)
val int_to_real = Real.fromInt

(* absolute value of a real *)
val real_abs = Real.abs

(* convert a real to a string *)
val real_to_string = Real.toString

(* return true if a real is negative : real -> bool *)
val real_is_negative = Real.signBit

(* We now load 3 files with police data represented as values of type json.
   Each file binds one variable: small_incident_reports (10 reports), 
   medium_incident_reports (100 reports), and large_incident_reports 
   (1000 reports) respectively.

   However, the large file is commented out for now because it will take 
   about 15 seconds to load, which is too long while you are debugging
   earlier problems.  In string format, we have ~10000 records -- if you
   do the challenge problem, you will be able to read in all 10000 quickly --
   it's the "trick" of giving you large SML values that is slow.
*)

(* Make SML print a little less while we load a bunch of data. *)
       ; (* this semicolon is important -- it ends the previous binding *)
Control.Print.printDepth := 3;
Control.Print.printLength := 3;

use "parsed_small_police.sml";
use "parsed_medium_police.sml";

(* uncomment when you are ready to do the problems needing the large report*)
(* 
use "parsed_large_police.sml"; 

val large_incident_reports_list =
    case large_incident_reports of
        Array js => js
      | _ => raise (Fail "expected large_incident_reports to be an array")

 *)
(* Now make SML print more again so that we can see what we're working with. *)
; Control.Print.printDepth := 20;
Control.Print.printLength := 20;

(**** PUT PROBLEMS 1-8 HERE ****)

fun make_silly_json (i : int) =
    let
	fun helper(accu) =
	    case accu of
		0 => Object [("n", Num 1.0), ("b", True)] :: []
	      | 1 => Object [("n", Num 1.0), ("b", True)] :: []
	      | _ => Object [("n", Num (int_to_real(accu))), ("b", True)] :: helper(accu - 1)
    in
	Array (helper(i))
    end

fun assoc (k, xs) =
    case xs of
	[] => NONE
      | (k1, v1)::d => if k1 = k
		       then SOME v1
		       else assoc(k, d)
				 
fun dot (j, f) =
    case j of
	Object jj => assoc(f, jj)
      | _ => NONE

fun one_fields (jsony) =
    let fun aux(lst, acc) =
	    case lst of
		[] => acc
	      | (s1, j1)::xs => aux(xs, s1::acc)
    in
	case jsony of
	    Object j => aux(j, [])
	  | _ => []
    end

fun no_repeats (xs) = length(xs) = length(dedup(xs))

fun recursive_no_field_repeats jsony =
    let fun array_proc(jlist) =
	    case jlist of
		[] => true
	      | js1::jl => recursive_no_field_repeats(js1) andalso array_proc(jl)
	
	fun obj_proc(jobj) =
	    case jobj of
		[] => true
	      | (s1, jobj)::xs => recursive_no_field_repeats(jobj) andalso obj_proc(xs)
    in
	case jsony of
	    Array jli => array_proc(jli)
	  | Object j  => no_repeats(one_fields(jsony)) andalso obj_proc(j)
	  | _ => true
    end 

fun count_occurrences (strl, ex) =
    let fun helper (cur_str, cur_count, ltl, accu) =
	    case ltl of
		[] => (cur_str, cur_count)::accu
	      | next_str::ltl' => case strcmp(cur_str, next_str) of
				      EQUAL => helper(next_str, cur_count+1, ltl', accu)
				    | GREATER => raise ex
				    | LESS => helper(next_str, 1, ltl', (cur_str, cur_count)::accu)
    in
	case strl of
	    [] => []
	 | str1::strl' => helper(str1, 1, strl', [])
    end

fun string_values_for_field (str, jlist) =
    case jlist of
	[] => []
      | jobj::jlist' => case dot(jobj, str) of
			    NONE => string_values_for_field(str, jlist')
			  | SOME v => case v of
					  String s => s::string_values_for_field(str, jlist')
					| _ => string_values_for_field(str, jlist')
(* 
(* histogram and historgram_for_field are provided, but they use your 
   count_occurrences and string_values_for_field, so uncomment them 
   after doing earlier problems *)

(* histogram_for_field takes a field name f and a list of objects js and 
   returns counts for how often a string is the contents of f in js. *)

exception SortIsBroken

fun histogram (xs : string list) : (string * int) list =
  let
    fun compare_strings (s1 : string, s2 : string) : bool = s1 > s2

    val sorted_xs = ListMergeSort.sort compare_strings xs
    val counts = count_occurrences (sorted_xs,SortIsBroken)

    fun compare_counts ((s1 : string, n1 : int), (s2 : string, n2 : int)) : bool =
      n1 < n2 orelse (n1 = n2 andalso s1 < s2)
  in
    ListMergeSort.sort compare_counts counts
  end

fun histogram_for_field (f,js) =
  histogram (string_values_for_field (f, js))
 *)
(**** PUT PROBLEMS 9-11 HERE ****)

fun filter_field_value (str1, str2, jlist) =
    case jlist of
	[] => []
      | jobj::jlist' => case dot(jobj, str1) of
			    NONE => filter_field_value(str1, str2, jlist')
			  | SOME v => case v of
					  String s => case strcmp(str2, s) of
							  EQUAL => jobj::filter_field_value(str1, str2, jlist')
						       | _ => filter_field_value(str1, str2, jlist')


(* 
val large_event_clearance_description_histogram =
    histogram_for_field("event_clearance_description", large_incident_reports_list);

val large_hundred_block_location_histogram =
    histogram_for_field("hundred_block_location", large_incident_reports_list);

;Control.Print.printDepth := 3;
Control.Print.printLength := 3;

(**** PUT PROBLEMS 12-15 HERE ****)

val forty_third_and_the_ave_reports =
    filter_field_value("hundred_block_location", "43XX BLOCK OF UNIVERSITY WAY NE",
		       large_incident_reports_list);

val forty_third_and_the_ave_event_clearance_description_histogram =
    histogram_for_field("event_clearance_description", forty_third_and_the_ave_reports);

val nineteenth_and_forty_fifth_reports =
    filter_field_value("hundred_block_location", "45XX BLOCK OF 19TH AVE NE",
		       large_incident_reports_list);

val nineteenth_and_forty_fifth_event_clearance_description_histogram =
    histogram_for_field("event_clearance_description", nineteenth_and_forty_fifth_reports);

;Control.Print.printDepth := 20;
Control.Print.printLength := 20;

 *)
(**** PUT PROBLEMS 16-19 HERE ****)

fun concat_with (sep_str, strli) =
    case strli of
	[] => ""
      | str1::[] =>  str1
      | str1::strli' => str1 ^ sep_str ^ concat_with(sep_str, strli')

fun quote_string (str) = "\"" ^ str ^ "\""

fun real_to_string_for_json (realnum) =
    if realnum < 0.0 then "-" ^ real_to_string(real_abs(realnum))
    else real_to_string(realnum)
(*
fun json_to_string (json_obj) =
    s
 For CHALLENGE PROBLEMS, see hw2challenge.sml *)



