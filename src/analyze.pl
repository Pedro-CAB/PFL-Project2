%Fun��es que analisam o tabuleiro para obter informa��o
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
           indexOf(L,B,X), %X � a linha do tabuleiro que queremos verificar
           indexOf(C,X,Y),
           E = Y.

indexOf(1,L,E) :- % I -> Index do Elemento, L -> Lista, E -> Valor do Elemento de Index I
           [E1|_] = L,
           E = E1.

indexOf(I,L,E) :- % I -> Index do Elemento, L -> Lista, E -> Valor do Elemento de Index I
           I1 is I-1,
           [_|L1] = L,
           indexOf(I1,L1,E).

isAllowedMove(L1,C1,L2,C2,B) :-
           isValidMove(L1,C1,L2,C2,1,B); isValidMove(L1,C1,L2,C2,-1,B).

isValidMove(L1,C1,L2,C2,S,B) :-
           (L1 = L2, C1 = C2); %Quando o caminho j� foi todo verificado
           isHorMove(L1,C1,L2,C2) ->
             (
                 (
                     S == 1,
                     ((C1 >= 9) -> C is 1; C is C1 + 1),
                     isFree(L1,C,B),
                     isValidMove(L1,C,L2,C2,S,B)
                 );
                 (
                     S == -1,
                     ((C1 =< 1) -> C is 9; C is C1 - 1),
                     isFree(L1,C,B),
                     isValidMove(L1,C,L2,C2,S,B)
                 )
             );
           isVerMove(L1,C1,L2,C2) ->
             (
                 (
                     S == 1,
                     ((L1 >= 9) -> L is 1; L is L1 + 1),
                     isFree(L,C1,B),
                     isValidMove(L,C1,L2,C2,S,B)
                 );
                 (
                     S == -1,
                     ((L1 =< 1) -> L is 9; L is L1 - 1),
                     isFree(L,C1,B),
                     isValidMove(L,C1,L2,C2,S,B)
                 )
             );
           (isCircleMove(L1,C1,L2,C2) ->
            (
             (
                 isSquare(L1,C1,1),
                  ((isRightEdge(L1,C1), S == 1) -> (L is 4, C is 10 - L1); %no sentido positivo, roda pela direita
                   (isLeftEdge(L1,C1), S == -1) -> (L is 4, C is L1); %no sentido negativo, roda pela esquerda
                   (S == -1) -> (L is L1, C is C1 - 1); %Coluna 5 no sentido negativo: Esquerda
                   (S == 1) -> (L is L1, C is C1 + 1)), %Coluna 5 no sentido positivo: Direita
                  isFree(L,C,B),
                  isValidMove(L,C,L2,C2,S,B)
             );
            (
                 isSquare(L1,C1,5),
                  ((isRightEdge(L1,C1), S == -1) -> (L is 6, C is L1);
                   (isLeftEdge(L1,C1), S == 1) -> (L is 6, C is 10 - L1);
                   (S == -1) -> (L is L1, C is C1 + 1);
                   (S == 1) -> (L is L1, C is C1 - 1)),
                  isFree(L,C,B),
                  isValidMove(L,C,L2,C2,S,B)
             );
             (
                 (isSquare(L1,C1,2)),
                  ((isLowerEdge(L1,C1), S == -1) -> (L is 10 - C1, C is 4);
                   (isUpperEdge(L1,C1), S == 1) -> (L is C1, C is 4);
                   (S == -1) -> (L is L1 + 1, C is C1);
                   (S == 1) -> (L is L1 -1, C is C1)),
                  isFree(L,C,B),
                  isValidMove(L,C,L2,C2,S,B)
             );
             (
                 (isSquare(L1,C1,4)),
                  ((isLowerEdge(L1,C1), S == 1) -> (L is C1, C is 6);
                   (isUpperEdge(L1,C1), S == -1) -> (L is 10 - C1, C is 6);
                   (S == 1) -> (L is L1 + 1, C is C1);
                   (S == -1) -> (L is L1 - 1, C is C1)),
                  isFree(L,C,B),
                  isValidMove(L,C,L2,C2,S,B)
             )
            )
           ).

checkBeforeTurn(P,B) :-
           isInPlay(1,4,P,B).

isInPlay(L,C,P,B) :-
           (C == 9, L == 9);
           (L < 9, C == 9, L1 is L + 1, checkMovablePiece(L,C,P,B), isInPlay(L1,1,P,B));
           (C < 9, C1 is C+1, checkMovablePiece(L,C,P,B), isInPlay(L,C1,P,B)).

checkMovablePiece(L,C,P,B) :-
           %Ou não está no tabuleiro, ou é uma peça que se pode mover do jogador ou não é uma peça do jogador
               \+isInBoard(L,C);(isPlayerPiece(L,C,B,P),canMove(L,C,B));\+isPlayerPiece(L,C,B,P).

canMove(L,C,B) :-
           (isSquare(L,C,1),
                ((isLeftEdge(L,C), isFree(4,L,B));
                 isFree(L,C-1,B);
                (isRightEdge(L,C),isFree(4,10-L,B));
                 isFree(L,C+1,B);
                 isFree(L-1,C,B);
                 isAllowedMove(L,C,L+1,C,B)
                ));
           (isSquare(L,C,5),
                ((isLeftEdge(L,C),isFree(6,10-L,B));
                  isFree(L,C-1,B);
                 (isRightEdge(L,C),isFree(6,L,B));
                  isFree(L,C+1,B);
                  isFree(L-1,C,B);
                  isFree(L+1,C,B)
                ));
           (isSquare(L,C,2),
                ((isUpperEdge(L,C),isFree(C,4,B));
                  isFree(L-1,C,B);
                 (isLowerEdge(L,C),isFree(10-C,4,B));
                  isFree(L+1,C,B);
                  isFree(L,C-1,B);
                  isFree(L,C+1,B)
                ));
           (isSquare(L,C,3),
                (
                  isFree(L-1,C,B);
                  isFree(L+1,C,B);
                  isFree(L,C-1,B);
                  isFree(L,C+1,B)
                ));
           (isSquare(L,C,4),
                ((isUpperEdge(L,C),isFree(10-C,6,B));
                  isFree(L-1,C,B);
                 (isLowerEdge(L,C),isFree(C,6,B));
                  isFree(L+1,C,B);
                  isFree(L,C-1,B);
                  isFree(L,C+1,B)
                )).

isSquare(L,C,N) :-
           (N = 1, L > 0, L < 4, C > 3, C < 7);
           (N = 2, L > 3, L < 7, C > 0, C < 4);
           (N = 3, L > 3, L < 7, C > 3, C < 7);
           (N = 4, L > 3, L < 7, C > 6, C < 10);
           (N = 5, L > 6, L < 10, C > 3, C < 7).
           
isLeftEdge(L,C) :-
           isEdge(L,C), C = 4, (isSquare(L,C,1);isSquare(L,C,5)).

isRightEdge(L,C) :-
           isEdge(L,C), C = 6, (isSquare(L,C,1);isSquare(L,C,5)).   

isUpperEdge(L,C) :-
           isEdge(L,C), L = 4, (isSquare(L,C,2);isSquare(L,C,4)).

isLowerEdge(L,C) :-
           isEdge(L,C), L = 6, (isSquare(L,C,2);isSquare(L,C,4)).         


isEdge(L,C) :- %identifica pontos de entrada em curvas
           ((L = 1 ; L = 2 ; L = 3; L = 7; L = 8; L = 9), (C = 4 ; C = 6));
           ((L = 4 ; L = 6), (C = 1 ; C = 2 ; C = 3; C = 7; C = 8; C = 9)).

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

belongsToCircle(L,C,Circle) :-
           isInBoard(L,C),
           (
               Circle = 1,
               (L = 1; C = 1 ; L = 9 ; C = 9)
           );
           (
               Circle = 2,
               (L = 2; C = 2 ; L = 8 ; C = 8)
           );
           (
               Circle = 3,
               (L = 3; C = 3; L = 7 ; C = 7)
           ).

isCircleMove(L1,C1,L2,C2) :-
           C1 =\= C2,
           L1 =\= L2,
           isInBoard(L1,C1),
           isInBoard(L2,C2).

isInBoard(L,C) :- %L -> Linha a verificar, C -> Coluna a verificar
           (L>0, L < 4, C > 3, C < 7);
           (L>3, L < 7, C > 0, C < 10);
           (L>6, L < 10, C > 3, C < 7).