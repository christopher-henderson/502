/*
Write a tail-recursive prolog program for the n queens problem. The objective is to
place n queens on a chessboard of size (n* n) so that no two queens are attacking
each other; i.e., no two queens are in the same row, the same column, or on the same
diagonal.
Note: All the recursive predicates in this program must be tail-recursive​.
Represent the positions of the queens as a list of numbers 1..N. For example: When
N = 8, the list (Qs) with the positions would be [4,2,7,3,6,8,5,1]. This means that the
queen in the first column is in row 4, the queen in the second column is in row 2, etc.
The goal predicate will take the form:
queens (N, Qs).
where N = the number of queens
 Qs = solution to the problem
Sample Run:
?- queens(8, Qs).
Qs = [4, 2, 7, 3, 6, 8, 5, 1];
Qs = [5, 2, 4, 7, 3, 8, 6, 1];
Qs = [3, 5, 2, 8, 6, 4, 7, 1];
*/

queens(N, Qs) :- queens(N, Qs, 0, []).
queens(N, Qs, C, A) :- C = N,
                       % We have been accumulating [Row, Column] pairs this whole
                       % time. So now we need to flatten it to just rows.
                       maplist(flatten, A, Qs).
queens(N, Qs, C, A) :- Column is C + 1,
                       between(1, N, R),
                       validate(R, Column, A),
                       append(A, [[R, Column]], A1),
                       queens(N, Qs, Column, A1).
validate(Row, Column, Accum) :- maplist(valid(Row, Column), Accum).
valid(Row, Column, [R, C]) :- Row \= R,
                              Column \= C,
                              Row + Column =\= R + C,
                              Row - Column =\= R - C.

flatten([X, _], X).
