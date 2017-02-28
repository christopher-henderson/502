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
                  transpose(Puzzle, Columns),
                  setRows(Columns),
                  setGrids(Puzzle, 0),
                  flatten(Puzzle, SolvedPuzzle),
                  label(SolvedPuzzle),
                  write(Puzzle).

setRows([]).
setRows([Row|Others]) :- length(Row, 9),
                         Row ins 1..9,
                         all_distinct(Row),
                         setRows(Others).

/*
Applies the all_distinct constraint to all 3x3 subgrids.
*/
setGrids(Grid, N) :- length(Grid, L), N #>= L.
setGrids(Grid, N1) :- N2 #= N1 + 1,
                      N3 #= N1 + 2,
                      N4 #= N1 + 3,
                     nth0(N1, Grid, Row1),
                     nth0(N2, Grid, Row2),
                     nth0(N3, Grid, Row3),
                     slice(Row1, N1, N4, SlicedRow1),
                     slice(Row2, N1, N4, SlicedRow2),
                     slice(Row3, N1, N4, SlicedRow3),
                     append(SlicedRow1, SlicedRow2, SubGrid),
                     append(SubGrid, SlicedRow3, FinalSubGrid),
                     all_distinct(FinalSubGrid),
                     NextSubGrid #= N4,
                     setGrids(Grid, NextSubGrid).

/*
This is the most convenient way I could think of extracting the sub grids
necessary for applying the all_distinct contraint to each 3x3 grid.
*/
slice(List, Beginning, End, Result) :- slice(List, Beginning, End, Result, []).
slice(_, End, End, Result, Acc) :- Result = Acc.
slice(List, Beginning, _, Result, Acc) :- length(List, L),
                                            L #=< Beginning,
                                            Result = Acc.
slice(List, Beginning, End, Result, Acc) :- nth0(Beginning, List, Value),
                                            append(Acc, [Value], Acc2),
                                            Beginning2 #= Beginning + 1,
                                            slice(List, Beginning2, End, Result, Acc2).

problem(1, [[_,_,6, 5,9,_, _,_,_],
 [_,_,3, _,_,_, _,7,_],
 [_,_,_, _,_,_, 5,6,_],
 [_,2,_, 1,7,_, _,_,_],
 [4,8,5, _,_,_, _,_,_],
 [_,6,_, _,_,4, 9,_,_],
 [2,_,_, _,_,5, _,_,8],
 [_,3,8, _,_,1, _,_,_],
 [_,_,_, 3,_,_, 7,5,4]]).
