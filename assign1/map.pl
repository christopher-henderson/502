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

color_map(L) :- color([], L).

color(Map, L) :- vertex(Vertex),                         % Give me a vertex.
                 \+ member([Vertex, _], Map),            % It must not already be colored.
                 color(Color),                           % Give me a color.
                 maplist(validColor(Vertex, Color), Map),% No other vertex that has already been colored,
                                                         %    and that has an edge with the target vertex, is allowed
                                                         %    to have the same color.
                 append(Map, [[Vertex, Color]], Map2),   % Update the accumulator.
                 color(Map2, L).                         % Recurse.

% The following counts the number of target vertices and makes
% sure that we colored ALL of them.
color(Map, L) :-  findall(_, vertex(_), TargetMap),
                  length(TargetMap, NumberOfVertices),
                  length(Map, NumberOfVerticesColored),
                  NumberOfVertices = NumberOfVerticesColored,
                  L = Map.

validColor(X, _, [Y, _]) :- \+ edge(X, Y).
validColor(_, C1, [_, C2]) :- C1 \= C2.
