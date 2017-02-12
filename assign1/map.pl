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
