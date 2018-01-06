
(* tuples must have a size determined at runtime,
   but can have any types

  lists can have any # of elements, but all list 
  els must have the same type *)

(* cons:: if e1 evaluates to v and e2 evaluates to 
    a list of v then  e1::e2 adds e1 to start of list*)

(* 'a list = alpha list; means u can replace the type  *)


fun sum_list (xs : int list) =
    if null xs
    then 0
    else hd xs + sum_list(tl xs);

fun countdown (x : int) =
    if x = 0
    then []
    else x :: countdown(x-1);

fun append (xs : int list, ys : int list) =
    if null xs
    then ys
    else (hd xs) :: append((tl xs), ys);

fun sum_pair_list (xs : (int * int) list) =
    if null xs
    then 0
    else #1 (hd xs) + #2 (hd xs) + sum_pair_list(tl xs);

		     
	
		       
	

			 
	
	
