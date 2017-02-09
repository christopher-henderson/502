woman(mia).
woman(jody).
woman(yolanda).
playsAirGuitar(jody).
party.


mom(donna, chris).
mom(donna, tony).
mom(mia, bob).
mom(jody, bill).
mom(lady, dude).
mom(otherlady, otherdude).
dad(george, chris).
dad(george, tony).
dad(snoop, bob).
dad(snoop, bill).
dad(guy, dude).
dad(otherguy, otherdude).

brothers(X, Y) :- (mom(Z, X), mom(Z, Y) ; dad(Z, X), dad(Z, Y)) ,
                  X \= Y.


/*
trace - turn on tracer
notrace - turn off tracer

write('Like, dude, whoa.').
nl.
*/


fact(0, 1).
fact(N, F) :-
  N > 0,
  N1 is N - 1,
  fact(N1, F1),
  F is N * F1.


                    0 is our internal accumulator
len(L, N) :- len(L, 0, N).
len([], T, T).
len([H|T], X, N) :- X1 is X + 1,
                    len(T, X1, N).


                    %member(X, [X|_]).
                    %member(X, [_|T]) :- member(X, T).



  is_prime(2).
  is_prime(N) :- (N mod 2) =\= 0, \+ has_factor(3, N).

  has_factor(X, N) :- (N mod X) =:= 0.
  has_factor:- (N mod X) =\= 0, x * x < N, has_factor(X1, N)
