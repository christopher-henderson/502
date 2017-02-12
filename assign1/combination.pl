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

% E.G. The only way to select 5 items from list of length 5 is the list itself.
combination(X, List, L) :- length(List, Length),
                           Length = X,
                           L = List.

% Kind of a design decision. If you want to choose 5 elements from a list that
% has only four elements, then that is not possible and should be false.
combination(X, List, L) :- length(List, Length),
                          Length < X,
                          fail.

combination(X, List, L) :- 
