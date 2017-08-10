range(E, E, [E]).
range(S, E, [S|T]) :- S < E,
                 S1 is S + 1,
                 range(S1, E, T).

% Finding length of a list

len(N, L) :- len(N, L, 0).
len(Acc, [], Acc).
len(N, [_|T], Acc) :- Acc < N,
                      Acc1 is Acc + 1,
                      len(N, T, Acc1).
