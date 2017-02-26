:- use_module(library(clpfd)).

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

color_map(L) :-   vertices(Vertices),
                  colors(Colors),
                  length(Vertices, NumVertices),
                  length(Colors, NumColors),
                  length(L, NumVertices),
                  matrix(L, NumVertices, 2),
                  transpose(L, T),
                  restrictVertices(T, NumVertices),
                  restrictColors(T, NumColors),
                  safe(L),
                  flatten(L, L1),
                  label(L1).

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

% My own version of findall for finding colors.
colors(C) :- colors(C, []).
colors(C, Acc) :- color(X),
                  \+ member(X, Acc),
                  append(Acc, [X], Acc1),
                  !,
                  colors(C, Acc1).
colors(C, Acc) :- C = Acc.

% My own version of findall for finding vertices.
vertices(V) :- vertices(V, []).
vertices(V, Acc) :- vertex(X),
                    \+ member(X, Acc),
                    append(Acc, [X], Acc1),
                    !,
                    vertices(V, Acc1).
vertices(V, Acc) :- V = Acc.
