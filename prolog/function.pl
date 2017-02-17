% Hs = [h(A,B,C,D,E)]

solve(Hs) :- length(Hs, 5),
             member(h(English, _, _, _ , red), Hs),
             member(h(Spanish, dog, _, _ , _), Hs).
