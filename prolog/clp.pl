:- use_module(library(clpfd)).
/*
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
*/

queens(N, Qs) :- length(Qs, N),
                  Qs ins 1..N,
                  all_distinct(Qs),
                  safe(Qs),
                  label(Qs).
                  %labeling([ff], Qs)

safe([]).
safe([Q|Rest]) :- safe(Q, 1, Rest), safe(Rest).

safe(_, _, []).
safe(Q, D, [Q1|Rest]) :-
                      Q1 #\ Q + D,
                      Q1 #\ Q - D,
                      D1 #= D + 1,
                      safe(Q, D1, Rest).

sudoku(S) :- length(S, 9),
             setRows(S).


% look into transpose, and other clpfd builtins.
