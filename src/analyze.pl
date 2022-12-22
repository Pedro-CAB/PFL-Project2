%Funções que analisam o tabuleiro para obter informação

isFree(L,C,B) :-
           isElementIn(L,C,B,'O').

isInvalid(L,C,B) :-
           isElementIn(L,C,B,'\\');
           isElementIn(L,C,B,'\x2f\').

isPlayerPiece(L,C,B,1) :-
           isElementIn(L,C,B,'A').

isPlayerPiece(L,C,B,2) :-
           isElementIn(L,C,B,'B').

isElementIn(L,C,B,E) :- % L -> linha, C -> coluna, B -> board, E -> elemento
           (L>0, L<10, C>0, C<10),
           indexOf(L,B,X), %X é a linha do tabuleiro que queremos verificar
           indexOf(C,X,Y),
           E = Y.

indexOf(1,L,E) :- % I -> Index do Elemento, L -> Lista, E -> Valor do Elemento de Index I
           [E1|_] = L,
           E = E1.

indexOf(I,L,E) :- % I -> Index do Elemento, L -> Lista, E -> Valor do Elemento de Index I
           I1 is I-1,
           [_|L1] = L,
           indexOf(I1,L1,E).

isMove(L,C,FL,FC) :- %(L,C) -> Posição Atual, (FL,FC) -> Nova Posição
           L = FL, C =\= FC; %movimento na vertical
           C = FC, L =\= FL. %movimento na horizontal

/*
isInBoard(L,C) :- %L -> Linha a verificar, C -> Coluna a verificar
           (L>0, L<10, C>0, C<10).
 */