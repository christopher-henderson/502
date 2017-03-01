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
Making a slice predicate was most convenient way I could think of extracting
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

 /*
 Zebra
 */

/*
 There are five colored houses in a row (numbered 1 to 5), each with an owner, a pet,
 cigarettes, and a drink.
 2. The English lives in the red house.
 3. The Spanish has a dog.
 4. They drink coffee in the green house.
 5. The Ukrainian drinks tea.
 6. The green house is next to the white house.
 7. The Winston smoker has a serpent.
 8. In the yellow house they smoke Kool.
 9. In the middle house they drink milk.
 10. The Norwegian lives in the first house from the left.
 11. The Chesterfield smoker lives near the man with the fox.
 12. In the house near the house with the horse they smoke Kool.
 13. The Lucky Strike smoker drinks juice.
 14. The Japanese smokes Kent.
 15. The Norwegian lives near the blue house.
*/


 solveZebra(Zebra, Water) :- Nationalities = [English, Spanish, Ukrainian, Norwegian, Japanese],
                             Colors = [Red, Green, White, Yellow, Blue],
                             Pets = [Dog, Serpent, Fox, Horse, Zebra],
                             Cigarettes = [Winston, Kool, Chesterfield, LuckStrike, Kent],
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
                             LuckStrike #= Juice,
                             Japanese #= Kent,
                             (Norwegian #= Blue + 1 ; Norwegian #= Blue - 1),

                             label(Nationalities),
                             label(Colors),
                             label(Pets),
                             label(Cigarettes),
                             label(Drinks).
