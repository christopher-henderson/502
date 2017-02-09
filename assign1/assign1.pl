findpath(a, b, 1, [a, b]).
findpath(a, c, 6, [a, c]).

findpath(b, a, 1, [b, a]).
findpath(b, e, 1, [b, e]).
findpath(b, d, 3, [b, d]).
findpath(b, c, 4, [b, c]).

findpath(e, b, 1, [e, b]).
findpath(e, d, 1, [e, d]).
findpath(e, j, 2, [e, j]).

findpath(d, e, 1, [d, e]).
findpath(d, b, 3, [d, b]).
findpath(d, c, 1, [d, c]).

findpath(c, d, 1, [c, d]).
findpath(c, b, 4, [c, b]).
findpath(c, a, 6, [c, b]).


findpath(X,Y,Weight,Path) :-
                             findpath(X, Z, W1, P1),
                             findpath(Z, Y, W2, P2),
                             \+ member(X, P2),
                             appendTail(P1, P2, Path),
                             Weight is W1 + W2.

appendTail(A, [_|T], Result) :- append(A, T, Result).
