/*
Program the Tower of Hanoi puzzle. You must use a, b, c as your peg names. Your
output should be a bunch of `move' statements like `move a to b' (which means
moving the top disk from peg a to peg b). You can use Prolog's `write' predicate to
output a string or a variable to the screen. The `nl' predicate outputs a newline to
screen.
Note: ​The goal predicate will take the form:
hanoi (X, a, c, b).
where X is a variable (the number of discs)

%move([H|T], B, T, [H|B]).
Move a to c.
Move a to b.
Move c to b.
Move a to c.

%hanoi(0, A, B, C) :- move(A, C, _, _).
hanoi(X, A, B, C) :-
  print(A),
  print(B),
  print(C),
  nl,
  hanoi(X - 1, A, B, C),

  hanoi(X - 1, B, C, A).
  move(A, C, A1, C1),
  move(A1, B, A2, B1),
  move(C1, B1, C2, B2),
  move(A2, C2, A3, C3),
  hanoi(X - 1, B2, C3, A3).
*/


move(A, B) :- write('Move '), write(A), write(' to '), write(B), nl.
