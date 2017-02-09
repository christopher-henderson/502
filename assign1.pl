findpath(a, b, 1, [a, b]).
findpath(a, c, 6, [a, c]).

findpath(b, e, 1, [b, e]).
findpath(b, d, 3, [b, d]).
findpath(b, c, 4, [b, c]).

findpath(e, d, 1, [e, d]).
findpath(e, j, 2, [e, j]).

findpath(d, b, 3, [d, b]).
findpath(d, c, 1, [d, c]).



findpath(X,Y,Weight,Path) :-
                             findpath(X, Z, W1, P1),
                             findpath(Z, Y, W2, P2),
                             appendTail(P1, P2, Path),
                             Weight is W1 + W2.

appendTail(A, [_|T], Result) :- append(A, T, Result).

member(X, [X|_]).
member(X, [_|T]) :- member(X, T).
