datatype mytype = TwoInts of int * int
		| Str of string
		| Pizza
       | Alsothis


(* adds a new type mytype to the environment
        TwoInts, Str, and Pizza are constructors - functions that 
           make values of the new type (or is a value of the new type)
           and return mytype
           Pizza and Alsothis are just aliases of mytype
 *)

	     
