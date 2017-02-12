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


%findpath(H, Y, _, [H|T]) :- \+ cycle([H|T]), last(Y, T).

findpath(X,Y,Weight,Path) :-
                             write("Path so far: "), write(Path),
                             findpath(Z, Y, W1, P1),
                             write("Found path: "), write(P1),
                             findpath(X, Z, W2, P2),
                             write("Found path2: "), write(P2),
                             appendTail(P2, P1, Path),
                             write("Path is: "), write(Path),
                             Weight is W1 + W2.

noCycle(Path) :- list_to_set(Path) =\= Path;
%noCycle([]).
%noCycle([H|T]) :- \+ member(H, T).
appendTail(A, [_|T], Result) :- append(A, T, Result).
