% sent --> np, vp.
% np --> art, noun.
% vp --> verb, np.
% art --> [an].
% art --> [the].
% noun --> [man].
% noun --> [apple].
% verb --> [eats].

% sent(t_sent(T1, T2)) --> np(T1), vp(T2).
% np(t_np(T1, T2)) --> art(T1), noun(T2).
% vp(t_vp(T1, T2)) --> verb(T1), np(T2).
% art(t_art(an)) --> [an].
% art(t_art(the)) --> [the].
% noun(t_noun(man)) --> [man].
% noun(t_noun(apple)) --> [apple].
% verb(t_verb(eats)) --> [eats].

plus --> number, ['+'], exp.
plus --> number.

number --> digit, number.
number --> digit.
digit --> [0].
digit --> [1].
digit --> [2].
digit --> [3].
digit --> [4].
digit --> [5].
digit --> [6].
digit --> [7].
digit --> [8].
digit --> [9].
