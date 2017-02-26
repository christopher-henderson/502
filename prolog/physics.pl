%:- use_module(library(clpfd)).
:- use_module(library(clpr)).

kinematics(Vf, Vi, Acc, T, Xf, Xi, Distance) :-
    {Vf = Vi + Acc * T},
    {Xf = Xi + Vi * T * 1/2 * Acc * T * T},
    {Vf * Vf = Vi * Vi + 2 * Acc * Distance}.
