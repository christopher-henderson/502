:- use_module(library(clpfd)).

/*******************************************************************************
N Queens Problem
*******************************************************************************/

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


/*******************************************************************************
Sudoku Solver
*******************************************************************************/

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
Making a slice predicate was the most convenient way I could think of extracting
the sub grids necessary for applying the all_distinct contraint to each 3x3 grid.

Example:
?- slice([1,2,3,4,5], 1, 4, S).
   S = [2, 3, 4]
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

 /*******************************************************************************
 Zebra Puzzle
 *******************************************************************************/

 solveZebra(Zebra, Water) :- Nationalities = [English, Spanish, Ukrainian, Norwegian, Japanese],
                             Colors = [Red, Green, White, Yellow, Blue],
                             Pets = [Dog, Serpent, Fox, Horse, Zebra],
                             Cigarettes = [Winston, Kool, Chesterfield, LuckyStrike, Kent],
                             Drinks = [Coffee, Tea, Milk, Juice, Water],

                             Nationalities ins 1..5,
                             Colors ins 1..5,
                             Pets ins 1..5,
                             Cigarettes ins 1..5,
                             Drinks ins 1..5,

                             all_distinct(Nationalities),
                             all_distinct(Colors),
                             all_distinct(Pets),
                             all_distinct(Cigarettes),
                             all_distinct(Drinks),

                             English #= Red,
                             Spanish #= Dog,
                             Green #= Coffee,
                             Ukrainian #= Tea,
                             (Green #= White + 1 ; Green #= White - 1),
                             Winston #= Serpent,
                             Yellow #= Kool,
                             Milk #= 3,
                             Norwegian #= 1,
                             (Chesterfield #= Fox + 1 ; Chesterfield #= Fox - 1),
                             (Horse #= Kool + 1 ; Horse #= Kool - 1),
                             LuckyStrike #= Juice,
                             Japanese #= Kent,
                             (Norwegian #= Blue + 1 ; Norwegian #= Blue - 1),

                             label(Nationalities),
                             label(Colors),
                             label(Pets),
                             label(Cigarettes),
                             label(Drinks).

 /*******************************************************************************
 Map Coloring
 *******************************************************************************/

 edge(1, 2).
 edge(1, 3).
 edge(1, 6).
 edge(1, 4).

 edge(2, 1).
 edge(2, 3).
 edge(2, 5).

 edge(3, 2).
 edge(3, 1).
 edge(3, 6).
 edge(3, 4).

 edge(4, 1).
 edge(4, 3).
 edge(4, 5).
 edge(4, 6).

 edge(5, 2).
 edge(5, 3).
 edge(5, 4).

 edge(6, 3).
 edge(6, 1).
 edge(6, 4).

 vertex(1).
 vertex(2).
 vertex(3).
 vertex(4).
 vertex(5).
 vertex(6).

 color(red).
 color(green).
 color(blue).
 color(yellow).

 color(1, red).
 color(2, green).
 color(3, blue).
 color(4, yellow).

 color_map(L) :- vertices(Vertices),
                 colors(Colors),
                 length(Vertices, NumVertices),
                 length(Colors, NumColors),
                 length(M, NumVertices),
                 matrix(M, NumVertices, 2),
                 transpose(M, T),
                 restrictVertices(T, NumVertices),
                 restrictColors(T, NumColors),
                 safe(M),
                 flatten(M, M1),
                 label(M1),
                 mapAnswer(M, L, []).

 /*
 Maps our integer representation of colors to our actual color atoms.
 */
 mapAnswer([], L, Acc) :- L = Acc.
 mapAnswer([[V, C]|T], L, Acc) :- color(C, Color),
                                append(Acc, [[V, Color]], Acc2),
                                mapAnswer(T, L, Acc2).

 /*
 Defines an N x M matrix.
 */
 matrix([], 0, _).
 matrix([H|T], N, M) :-  length(H, M),
                         N1 #= N - 1,
                         matrix(T, N1, M).

 restrictVertices([V, _], NumVertices) :- V ins 1..NumVertices,
                                          all_distinct(V).

 restrictColors([_, C], NumColors) :- C ins 1..NumColors.

 safe([]).
 safe([V|Others]) :- safe(V, Others),
                     safe(Others).
 safe([_, _], []).
 safe([V, C], [[V2, _]|Others]) :- \+ edge(V, V2),
                                     safe([V, C], Others).
 safe([V, C], [[V2, C2]|Others]) :- edge(V, V2),
                                    C #\= C2,
                                    safe([V, C], Others).

 /*
 My own version of findall for finding colors without using
 higher order predicates. I do this so that I can know how the
 number of colors in the graph without hard coding it.
 */
 colors(C) :- colors(C, []).
 colors(C, Acc) :- color(X),
                   \+ member(X, Acc),
                   append(Acc, [X], Acc1),
                   !,
                   colors(C, Acc1).
 colors(C, Acc) :- C = Acc.

 /*
 My own version of findall for finding vertices without using
 higher order predicates. I do this so that I can know how the
 number of vertices in the graph without hard coding it.
 */
 vertices(V) :- vertices(V, []).
 vertices(V, Acc) :- vertex(X),
                     \+ member(X, Acc),
                     append(Acc, [X], Acc1),
                     !,
                     vertices(V, Acc1).
 vertices(V, Acc) :- V = Acc.
