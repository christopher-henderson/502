/*
On legal and financial documents, like cheques, numbers must sometimes be written
in full words. Example: 283 must be written as two-eight-three. Write a predicate
full_words/1 to print (non-negative) integer numbers in full words.
Sample Run:
?- full_words(283).
two-eight-three
?- full_words(2017).
two-zero-one-seven
*/

full_words(0) :- write("zero").
full_words(1) :- write("one").
full_words(2) :- write("two").
full_words(3) :- write("three").
full_words(4) :- write("four").
full_words(5) :- write("five").
full_words(6) :- write("six").
full_words(7) :- write("seven").
full_words(8) :- write("eight").
full_words(9) :- write("nine").

full_words(Value) :- LeastSignificant is Value mod 10,
                     Remainder is Value div 10,
                     full_words(Remainder),
                     write("-"),
                     full_words(LeastSignificant).
