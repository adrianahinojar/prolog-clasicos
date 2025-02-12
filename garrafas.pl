%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   GARRAFAS %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
my_reach(S1, S2, Path) :- my_reach_(S1, S2, [S1], Path).

my_reach_(S1, S2, Prev, Next) :-
    my_trans(S1, S2),
    \+ member(S2, Prev),
    append(Prev, [S2], Next).

my_reach_(S1, S2, Prev, Next) :-
    my_trans(S1, S3),
    append(Prev, [S3], Prev1),
    \+ member(S3, Prev),
    my_reach_(S3, S2, Prev1, Next).

my_trans(e(P1, G1), e(3, G1)) :- P1 < 3. %llenar la 
my_trans(e(P1, G1), e(P1, 5)) :- G1 < 5. %llenar la 
my_trans(e(P1, G1), e(0, G1)) :- P1 > 0. %vaciar 
my_trans(e(P1, G1), e(P1, 0)) :- G1 > 0. %vaciar 
my_trans(e(P1, G1), e(P2, G2)) :- % de la pequeña a la grande
    P2 = 0,
    G2 is G1 + P1,
    P1 > 0,
    G2 =< 5.

my_trans(e(P1, G1), e(P2, G2)) :- % de la pequeña a la grande pero no cabe
    G2 = 5,
    P2 is G1 + P1 - 5,
    P1 > 0,
    P1 + G1 > 5.

my_trans(e(P1, G1), e(P2, G2)) :- % de la grande a la pequeña
    G2 = 0,
    P2 is P1 + G1,
    G1 > 0,
    P2 =< 3.

my_trans(e(P1, G1), e(P2, G2)) :- % de la grande a la pequeña pero no cabe
    P2 = 3,
    G2 is G1 + P1 - 3,
    G1 > 0,
    P1 + G1 > 3.