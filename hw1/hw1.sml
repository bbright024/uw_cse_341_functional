(* ASSIGNMENT:
     Write 12 SML functions and tests related to calendar dates
      - date is a value of type int * int * int , a truple int 
             (day, month, year)  
                    where year > 0,
                          1 <= month <= 12
                          0 < day <= 31
      - 1 <= day of year <= 365 

 *)

(* 
CORRECT BINDINGS FOR FUNS:
val is_older = fn : (int * int * int) * (int * int * int) -> bool


val dates_in_month = fn : (int * int * int) list * int -> (int * int * int) list
val dates_in_months = fn : (int * int * int) list * int list -> (int * int * int) list
val get_nth = fn : string list * int -> string
val date_to_string = fn : int * int * int -> string
val number_before_reaching_sum = fn : int * int list -> int
val what_month = fn : int -> int
val month_range = fn : int * int -> int list
val oldest = fn : (int * int * int) list -> (int * int * int) option
val cumulative_sum = fn : int list -> int list
 *)

(* 1. Takes two dates
      - ret true if d1 comes before d2
            false if d1 = d2 or d1 is after d2 
*)
fun is_older(d1 : (int * int * int), d2 : (int * int * int)) =
    (#3 d1) < (#3 d2)
    orelse
    ((#3 d1) = (#3 d2) andalso (#2 d1) < (#2 d2))
    orelse
    ((#2 d1) = (#2 d2) andalso (#1 d1) < (#1 d2))

(* 2. Takes list of dates and a month
      - ret number of dates in the list are in the given month 
val number_in_month = fn : (int * int * int) list * int -> int
*)
fun number_in_month(dates : (int * int * int) list, month : int) =
    if dates = []
    then 0
    else (if (#2 (hd dates)) = month
	  then 1 + number_in_month(tl dates, month)
	  else number_in_month(tl dates, month))

(* 3. Takes list of dates and list of months
      - ret number of dates in date list that ar ein any months of m list 
      - assumes list of months has 0 repeats
      - use number_in_month 
val number_in_months = fn : (int * int * int) list * int list -> int
*)
fun number_in_months(dates : (int * int * int) list, months : int list) =
    if dates = [] orelse months = []
    then 0
    else number_in_month(dates, hd months) + number_in_months(dates, tl months)

(* 4. Takes list of dates and a single month
     - ret a list holding the dates from the list of dates in the month 
         - this ret list should have dates in same order*)
fun dates_in_month(dates : (int * int * int) list, month : int) =
    if dates = []
    then []
    else (if (#2 (hd dates)) = month
	  then (hd dates) :: dates_in_month(tl dates, month)
	  else dates_in_month(tl dates, month))
	     
(* 5. Takes list of dates, list of months
      - ret a list with dates from given list in any of the months
      - assume no months repeated
      - use dates_in_month
      - use @ - SML's list append operator *)
fun dates_in_months(dates : (int * int * int) list, months : int list) =
    if dates = [] orelse months = []
    then []
    else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)

(* 6. Takes list of strings and int n
      - returns nth element of the list where head of the list is 1st
      - do not worry about case where list has too few elements
      - func may apply hd or tl to the empty list in this case *)
fun get_nth(strs : string list, n : int) =
    if n = 1
    then hd strs
    else get_nth(tl strs, n - 1);
(* 

 *)
(* 7. Takes a date 
     - ret a string of form September-10-2018
     - use operator ^ for concatenating strings
     - use Int.toString(i) for converting i to a string
     - use a list holding 12 strings and get_nth *)
(* . January, February, March, April,
May, June, July, August, September, October, November, December *)
fun date_to_string(date : (int * int * int)) =
    get_nth(["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"], (#2 date))
    ^ "-" ^ Int.toString((#1 date)) ^ "-" ^ Int.toString((#3 date)) 

(* 8. Takes int sum, which is > 0 and int list, all pos numbs 
     - ret int n such that first n elements of the list are less than sum
     - assume entire list sums to more than passed in value*)
fun number_before_reaching_sum(sum : int, li : int list) =
    if sum <= 0 orelse li = []
    then 0
    else
	let
	    val newsum = sum - (hd li)
	in
	    if newsum <= 0
	    then 0
	    else 1 + number_before_reaching_sum(newsum, tl li)
	end
					       
(* 9. Takes a day of the year 
     - ret the month the day is in (1 for jan, 2 feb, etc)
     - use a list holding 12 ints and number_before_rea_sum *)
fun what_month(day : int) =
    if day < 31 orelse day > 365
    then 1
    else 1 + number_before_reaching_sum(day, [31, 28, 31,
					      30, 31, 30, 31, 31, 30, 31, 30, 31])

(* 10. Takes two days
      - ret an int list where [m1, m2, ..., mn] m1 = month of day 1,
          m2 = month of day 1 + 1, and mn is month of day2 
      - result will have length day2 - day1 + 1 or length 0 if day1 > day2*)
fun month_range(day1 : int, day2 : int) =
    if day1 > day2
    then []
    else 
	let
	    fun add_months(m1, mn) =
		if m1 = mn
		then [mn]
		else m1 :: add_months(m1 + 1, mn)
	in
	    add_months(what_month(day1),what_month(day2))
	end

(* 11. Takes list of dates
      - ret NONE if list has no dates, or
      - ret SOME d where date d is oldest date in list *)
fun oldest(dates : (int * int * int) list) =
    if null dates
    then NONE
    else 
	let
	    val tl_ans = oldest(tl dates)
	in 
	    if isSome tl_ans andalso is_older(valOf tl_ans, hd dates)
	    then tl_ans
	    else SOME (hd dates)
	end 

(* 12. Takes list of numbers
     - ret a list of partial sums of the nums
          [12,27,13] --> [12,39,52]
     - use a helper function that takes 2 args *)
fun cumulative_sum(nums : int list) =
    if null nums
    then []
    else
	let
	    val tot = hd nums
	    fun add_to_head(a : int, b : int list) =
		if null b
		then [a]
		else a :: add_to_head(a + hd b, tl b)
	in
	    add_to_head(tot, tl nums)
	end
(*
	    for (i = 0; i < len(xxx); i++) {
	    tot = tot + xxx[i];
	    xxx[i] = tot;
	}
*)
(* CHALLENGE PROBLEMS *)

(* 13. Takes list of dates and list of months
      - ret number of dates in date list that ar ein any months of m list 
      - use number_in_month *)
(* new part: eliminate doubles in months - then use previous work*)
fun number_in_months_challenge(dates : (int * int * int) list, months : int list) =
    400;



(* 14. Takes list of dates, list of months
      - ret a list with dates from given list in any of the months
      - use dates_in_month
      - use @ - SML's list append operator *)
(* new part: eliminate doubles in months - then use previous work*)
fun dates_in_months_challenge(dates : (int * int * int) list, months : int list) =
    400;

(* 15. Takes a date, determines if it is a real date in common era
       - real date = pos year, month between 1-12, day appropriate
          for the month, handles leap year
           - leap years = divisible by 400 or divisible by 4 but not 100
       - do not worry about days lost in conversion to Gregorian cal  *)
fun reasonable_date(date : (int * int * int)) =
    true;


