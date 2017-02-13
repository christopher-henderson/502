/*
A famous problem in mathematics concerns coloring adjacent planar regions. Like
cartographic maps, in this problem, it is required that, whatever colors are actually
used, no two adjacent regions may have the same color given the total number of
colors to be used in the entire region are less than or equal to 4. Two regions are
considered adjacent if they share some boundary line segment. Write a prolog
program to represent the following region (map) below and write a prolog
predicate “color_map” that will color the map for the whole region so that no
adjacent regions are colored with the same color given that you should use at most 4
colors (red, green, blue, yellow) for the entire region.
Please note that you need to represent the following region as well in your solution
by writing the vertex, edge and color predicates, for full credit.

Sample Run:
?-color_map(L).
L = [[1, red], [2, green], [3, blue], [4, yellow], [5, red], [6, green]];
…
…
*/

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

color_map(L) :- color(1, [[1, null], [2, null], [3, null], [4, null], [5, null], [6, null]], [red, green, blue, yellow], L).

color(Vertex, Map, Colors, L) :-  Vertex < 7,
                               member(Color, Colors),
                               maplist(validColor(Vertex, Color), Map),
                               V2 is Vertex + 1,
                               updateMap(Vertex, Color, Map, Map2),
                               color(V2, Map2, Colors, L).

color(_, Map, _, L) :-  L = Map.

validColor(X, C1, [Y, C2]) :- \+ edge(X, Y);
                             X \= Y,
                             C1 \= C2.

updateMap(Vertex, Color, Map, Map2) :- select([Vertex, null], Map, M),
                                      append(M, [[Vertex, Color]], Map2).
