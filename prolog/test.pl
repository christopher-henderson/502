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
