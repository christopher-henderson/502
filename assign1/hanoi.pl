hanoi(1, A, C, _) :- write('Move '), write(A), write(' to '), write(C), nl.
hanoi(X, A, C, B) :-
          X > 1,
          N is X - 1,
          hanoi(N, A, B, C),
          hanoi(1, A, C, _),
          hanoi(N, B, C, A).
