datatype mytype = TwoInts of int * int
		| Str of string
       | Pizza

	     (* 
		enum constructors {
		   TwoInts,
		   Str,
		   Pizza
		}
                union mytype {
		TwoInts - function pointer that takes int array, returns mytype?
		Str - function pointer taking a string, returning a mytype
		Pizza - function pointer returning another mytype
		} 

		struct mytype_data {
		   union data {
		      int *TwoInts_d;
		      char *string_d;
		      mytype_data *Pizza_d;
		   }  holds the data stored by the functions in the union
		  int constructor_function;
		}
mytype_data *create_mytype(int constructor, void *data) {
    mytype_data *new_mytype = malloc(sizeof(struct mytype_data));
    //check return for err
    new_mytype->constructor_function = constructor;
    switch constructor:
        case (TwoInts) :
	    new_mytype->data.TwoInts_d = (int * )data;
	    break;
	case(Str):
	    new_mytype->data.string_d = (char * )data;
	    break;
	case(Pizza):
	    new_mytype->data.Pizza_d = (mytype_data * )data;
        
	anyway, something like this would be how i think it works on the backend
	of ML.
}
		that way with a pizza-style constructor you can 
		implement branches and trees and other data structures...
		probably need 2 though for something more complex than 
		a regular linked list

		pattern matching is used because ML is weak and doesn't have 
		pointers.  pretty much forced to iterate through the union
		of mytype_data... wait no.
		the backend of ML will use pointers to know which constructor
		saved the data to the invisible mytype_data, and save that info
		with it. 
	      
	      using the case thing allows you to switch based on the 
	      mytype_data->constructor_function value... so wouldnt the mytype
	      just be an enum then, instead of a union?  or maybe both?


	      in the case expression, each function is defined.*)
	     
	     
