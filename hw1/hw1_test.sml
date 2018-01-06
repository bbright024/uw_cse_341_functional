(* test day *)
is_older((4,4,4), (4,4,4)); 	(* false *)
is_older((4,4,4), (5,4,4)); 	(* true *)
is_older((5,4,4), (4,4,4));	(* false *)
(* test month *)
is_older((4,5,6), (4,6,6)); 	(* true *)
is_older((4,7,6), (4,5,6)); 	(* false *)
is_older((4,6,6), (4,6,6)); 	(* false *)
(* test year *)
is_older((1,2,3), (1,2,4)); 	(* true *)
is_older((1,2,3), (1,2,2)); 	(* false *)
is_older((1,2,3), (1,2,3)); 	(* false *)

number_in_month([(1,2,2002),(1,3,2002),(1,4,2004),(1,3,2)], 3); (* 2 *)
number_in_month([], 4);						(* 0 *)
number_in_month([(1,2,2002),(1,3,2002),(1,4,2004),(1,3,2)], 10); (* 0 *)

number_in_months([(1,2,2002),(1,3,2002),(1,4,2004),(1,3,2)],[10,2,3,4]); (* 4 *)
number_in_months([],[]); (* 0 *)
number_in_months([],[1]); (* 0 *)
number_in_months([(1,2,3)],[]); (* 0 *)
number_in_months([(1,2,2002),(1,3,2002),(1,4,2004),(1,3,2)],
		 [10,8]); (* 0 *)
number_in_months([(1,2,2002),(1,3,2002),(1,4,2004),(1,3,2)],
		 [10,3,4]); (* 3 *)

dates_in_month([(1,2,2002),(1,3,2002),(1,4,2004),(1,3,2)], 3);
(* [(1,3,2002),(1,3,2)] *)
dates_in_month([], 4);						(* 0 *)
dates_in_month([(1,2,2002),(1,3,2002),(1,4,2004),(1,3,2)], 10); (* 0 *)

dates_in_months([(1,2,2002),(1,3,2002),(1,4,2004),(1,3,2)],[10,2,3,4]); (* 4 *)
dates_in_months([],[]); (* 0 *)
dates_in_months([],[1]); (* 0 *)
dates_in_months([(1,2,3)],[]); (* 0 *)
dates_in_months([(1,2,2002),(1,3,2002),(1,4,2004),(1,3,2)],
		 [10,8]); (* 0 *)
dates_in_months([(1,2,2002),(1,3,2002),(1,4,2004),(1,3,2)],
		 [10,3,4]); (* 3 *)

get_nth(["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"], 4);
get_nth(["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"], 12);
get_nth(["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"], 1);

date_to_string((12,5,1989));
date_to_string((1,1,1));

val ex8 = true;
number_before_reaching_sum(5, [1,2,3,4,5]); (* 2 *)
number_before_reaching_sum(5, [1]); (* 1 *)
number_before_reaching_sum(5, [5]); (* 0 *)
number_before_reaching_sum(5, []); (* 0 *)

val ex9 = true;

what_month(365);
what_month(4);
what_month(300);
what_month(40);

val ex10 = true;

month_range(1, 365);
month_range(40, 50);
month_range(40, 300);
month_range(31, 365);
month_range(333,31);

oldest([(1,2,3),(2,3,1),(4,5,1)]);
oldest([(1,2,3),(2,3,1),(4,5,1)]);
oldest([(1,2,3),(2,3,10),(4,5,1)]);
oldest([(1,2,3)]);
oldest([]);

val ex11 = true;

cumulative_sum([1,2,3,4,5]);
cumulative_sum([5]);
cumulative_sum([]);
cumulative_sum([10,20,30]);
cumulative_sum([12,27,13]);
(*  copies of needed lists, was bugging out the tabber in emacs for hw1
so saving them here
[31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
 *)



							     
	



