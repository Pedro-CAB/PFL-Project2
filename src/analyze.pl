%Funções que analisam o tabuleiro para obter informação

isFree(L,C,B) :-
           isElementIn(L,C,B,'O').

isInvalid(L,C,B) :-
           isElementIn(L,C,B,'\\');
           isElementIn(L,C,B,'\x2f\').

isPiece(L,C,B) :-
           isPlayerPiece(L,C,B,1); isPlayerPiece(L,C,B,2).

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

isCircleMove(L1,C1,L2,C2) :-
           C1 =\= C2,
           L1 =\= L2,
           isInBoard(L1,C1),
           isInBoard(L2,C2).

isValidMove(L1,C1,L2,C2,B) :-
           (L1 = L2, C1 = C2); %Quando o caminho já foi todo verificado
           (isHorMove(L1,C1,L2,C2),
            (C1 > C2,
             C is C1 - 1,
             isFree(L1,C,B),
             isValidMove(L1,C,L2,C2,B)
             );
            (C1 < C2,
             C is C1 + 1,
             isFree(L1,C,B),
             isValidMove(L1,C,L2,C2,B)
             )
            );
           (isVerMove(L1,C1,L2,C2),
            (L1 > L2,
             L is L1 - 1,
             isFree(L,C1,B),
             isValidMove(L,C1,L2,C2,B)
             );
            (L1 < L2,
             L is L1 + 1,
             isFree(L,C1,B),
             isValidMove(L,C1,L2,C2,B)
             )
            ).

isVerMove(L1,C1,L2,C2) :-
           C1 = C2,
           L1 =\= L2,
           isInBoard(L1,C1),
           isInBoard(L2,C2).

isHorMove(L1,C1,L2,C2) :-
           L1 = L2,
           C1 =\= C2,
           isInBoard(L1,C1),
           isInBoard(L2,C2).

isInBoard(L,C) :- %L -> Linha a verificar, C -> Coluna a verificar
           (L>0, L < 4, C > 3, C < 7);
           (L>3, L < 7, C > 0, C < 10);
           (L>6, L < 10, C > 3, C < 7).