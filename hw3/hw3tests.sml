use "hw3provided.sml";

val string_list_test = ["ABCDabcd", "efg1234hij", "klmnop", "QRSTUV"];
val test1 = only_lowercase(string_list_test) = ["efg1234hij", "klmnop"];

val long_str_test = ["12345", "67890", "a", "b"];
val test200 = longest_string_1(long_str_test) = "12345";

val test201 = longest_string_1([]) = "";

val test300 = longest_string_2([]) = "";
val test200 = longest_string_2(long_str_test) = "67890";

val test500 = longest_lowercase string_list_test;

(*)val testnine_b1 = count_wildcards (VariableP "heh") = 0;  *)
val testnine_b2 = count_wildcards (WildcardP) = 1;
val testnine_b3 = count_wildcards (TupleP [(WildcardP), (WildcardP), (VariableP "heh")]) = 2;

val testnine_c1 =
    count_wild_and_variable_lengths
	(TupleP [(WildcardP), (WildcardP), (VariableP "heh")]) = 5;


val testnine_d1 = count_a_var ("h", (TupleP [(VariableP "heh"), (VariableP "heh")])) = 0;
val testnine_d2 = count_a_var ("heh", (TupleP [(VariableP "heh"), (VariableP "heh")])) = 2;
val testnine_d3 = count_a_var ("h", (TupleP [(VariableP "heh"), (VariableP "heh"),
					     (ConstructorP ("h", (VariableP "heh")))])) = 0;

val testten01 = check_pat (TupleP [(VariableP "heh"), (VariableP "heh")]) = false;
val testten02 = check_pat (TupleP [(VariableP "heh"), (VariableP "hehh")]) = true;
val testten03 = check_pat (TupleP [(VariableP "heh")]) = true;
