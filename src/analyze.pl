%Funções que analisam o tabuleiro para obter informação

isEmpty(L,C,B) :-
           isInBoard(L,C),
           isElementIn(L,C,B,X),
           X = 'O'.

isPlayerPiece(L,C,B,1) :-
           isInBoard(L,C),
           isElementIn(L,C,B,'A').

isPlayerPiece(L,C,B,2) :-
           isInBoard(L,C),
           isElementIn(L,C,B,'B').

isElementIn(L,C,B,E) :-
           
           (((L > 0, L < 4) ; (L > 6, L < 10)),
           C1 is C-3,
           indexOf(L,B,X), %X é a linha do tabuleiro que queremos verificar
           indexOf(C1,X,Y),
           E = Y);
           
           ((L > 3, L < 7),
           indexOf(L,B,X), %X é a linha do tabuleiro que queremos verificar
           indexOf(C,X,Y),
           E = Y);
           (E = 'X'). %se estiver fora do tabuleiro, é sempre X

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

isInBoard(L,C) :- %L -> Linha a verificar, C -> Coluna a verificar
           (L>0, L<4, C > 3, C < 7); %Linhas 1-3
           (L>3, L<7, C > 0, C < 10); %Linhas 4-6
           (L>6, L<10, C > 3, C < 7). %Linhas 7-9