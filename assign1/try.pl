edge(a, b, 1).
edge(a, c, 6).
edge(b, a, 1).
edge(b, e, 1).
edge(b, d, 3).
edge(b, c, 4).
edge(e, b, 1).
edge(e, d, 1).
edge(e, j, 2).
edge(d, e, 1).
edge(d, b, 3).
edge(d, c, 1).
edge(c, d, 1).
edge(c, b, 4).
edge(c, a, 6).

findpath(X, Y, W, Path) :- findpath(X, Y, W, Path, [a,b,c,d,e,j]).

findpath(X, Y, W, Path, _) :- edge(X, Y, W), Path = [X, Y].
findpath(X, Y, W, Path, NotVisited) :-
                 write("Finding path from "), write(X), write(" to "), write(Y),
                 edge(Z, Y, W1),
                 X \= Z, X \= Y, member(X, NotVisited), member(Y, NotVisited), member(Z, NotVisited),
                 select(Y, NotVisited, NV1),
                 findpath(X, Z, W2, Path1, NV1),
                 %select(Z, NV1, NV2),
                 appendToTail(Path1, Y, Path),
                 W is W1 + W2.

appendToTail(List, Element, Result) :- flatten([List, Element], Result).



























/*
noCycle(Path) :- list_to_set(Path, P1),
                 equal(Path, P1).
equal([H|T], [H|T]).
equal([], []).

findpath(X, Y, _, [X|T]) :- last(Y, T).
findpath(X, Y, W, [X, Y]) :- edge(X, Y, W).
findpath(X, Y, W, Path) :- findpath(X, Y, W, Path, []).
findpath(X, Y, W, Path, SoFar) :-
                           edge(X, Y, W), append([X, Y], SoFar, P1), list_to_set(P1, Path)
                           ;
                           list_to_set(SoFar, SoFar),
                           edge(Z, Y, EndWeight),
                           append([Z, Y], SoFar, SoFar1),
                           list_to_set(SoFar1, SoFar2),
                           findpath(X, Z, W1, Path, SoFar2),
                           W is EndWeight + W1.


%noCycle([]).
%noCycle([H|T]) :- \+ member(H, T).
appendTail(A, [_|T], Result) :- append(A, T, Result).
*/
