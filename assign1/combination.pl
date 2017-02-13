/*
Generate the combinations of K distinct objects chosen from the N elements of
a list: (10 points)
In how many ways can a committee of 3 be chosen from a group of 12 people? We
all know that there are C(12,3) = 220 possibilities (C(N,K) denotes the well-known
binomial coefficients). We need to generate all the possibilities (via backtracking).
Write a combination predicate which takes the following form:
combination(X, [x, y, z, ...], L).
where X is the number of elements to be chosen from the list
[x, y, z, ...] is the list of elements to be used
L is the resultant list of distinct objects
Sample Run:
?- combination(3,[a,b,c,d,e,f],L).
L = [a,b,c] ;
L = [a,b,d] ;
L = [a,b,e] ;
….
….
File Name: ​combination.pl
*/


combination(1, List, L) :- member(H, List),
                           L = [H].
combination(X, List, L) :- member(H, List),
                           splitList(H, List, List1),
                           X1 is X - 1,
                           combination(X1, List1, List2),
                           appendHead(H, List2, L).


splitList(H, [H|T], T).
splitList(H, List, Result) :- select(_, List, List1), !,
                              splitList(H, List1, Result).

appendHead(H, T, [H|T]).
