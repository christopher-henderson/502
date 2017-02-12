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

% Wrap the outer call with our own list to keep track of visited nodes.
findpath(X, Y, W, Path) :- findpath(X, Y, W, Path, [a,b,c,d,e,j]).
% If there is a direct edge, then that is the answer. Base case.
findpath(X, Y, W, Path, _) :- edge(X, Y, W), Path = [X, Y].
% The recursive solution.
findpath(X, Y, W, Path, NotVisited) :-
                 X \= Y,                         % The source and the destination CANNOT be the same.
                                                 %    If there is something like A --> A in the graph, then
                                                 %    the above predicate will find it out.
                 edge(Z, Y, W1),                 % Find some Z the definitely has an edge with Y.
                 member(Z, NotVisited),          % Z Must not have been visited yet, lest that be a cycle.
                 select(Y, NotVisited, NV1),     % Mark Y as having been visited. Do not mark Z yet as we
                                                 %    have not found that path yet.
                 findpath(X, Z, W2, Path1, NV1), % Find a path from X to Z.
                 appendToTail(Path1, Y, Path),   % The final path is the path from X to Z plus Y.
                 W is W1 + W2.                   % Calculate final weight.

appendToTail(List, Element, Result) :- flatten([List, Element], Result).















/*


W = 2,
P = [a, b, e] ;
W = 11,
P = [a, c, d, b, e] ;
W = 11,
P = [a, c, b, e] ;
W = 5,
P = [a, b, d, e] ;
W = 14,
P = [a, c, b, d, e] ;
W = 8,
P = [a, c, d, e] ;
W = 7,
P = [a, b, c, d, e] ;

W = 2,
P = [a, b, e] ;
W = 11,
P = [a, c, d, b, e] ;
W = 11,
P = [a, c, b, e] ;
W = 5,
P = [a, b, d, e] ;
W = 14,
P = [a, c, b, d, e] ;
W = 8,
P = [a, c, d, e] ;
W = 7,
P = [a, b, c, d, e] ;



*/


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
