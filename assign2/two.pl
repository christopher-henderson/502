:- use_module(library(clpfd)).

/*
N Queens
*/

queens(N, Qs) :-  length(Qs, N),
                  Qs ins 1..N,
                  all_distinct(Qs),
                  not_attacking(Qs),
                  label(Qs).

not_attacking([]).
not_attacking([Q|Others]) :- not_attacking(Q, 1, Others),
                             not_attacking(Others).
not_attacking(_, _, []).
not_attacking(Q1, Distance, [Q2|Others]) :- Q2 #\= Q1 + Distance,
                                            Q2 #\= Q1 - Distance,
                                            Distance2 #= Distance + 1,
                                            not_attacking(Q1, Distance2, Others).


/*
Sudoku
*/

sudoku(Puzzle) :- length(Puzzle, 9),
                  setRows(Puzzle),
                  transpose(Puzzle, Puzzle2),
                  setRows(Puzzle2),
                  flatten(Puzzle, P2),
                  label(P2).
                  %label(Puzzle).

setRows([]).
setRows([Row|Others]) :- Row ins 1..9,
                         all_distinct(Row),
                         setRows(Others).

problem(1, [[_,_,6, 5,9,_, _,_,_],
 [_,_,3, _,_,_, _,7,_],
 [_,_,_, _,_,_, 5,6,_],
 [_,2,_, 1,7,_, _,_,_],
 [4,8,5, _,_,_, _,_,_],
 [_,6,_, _,_,4, 9,_,_],
 [2,_,_, _,_,5, _,_,8],
 [_,3,8, _,_,1, _,_,_],
 [_,_,_, 3,_,_, 7,5,4]]).

 color_map(L)
