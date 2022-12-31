%Fun��es que analisam o tabuleiro para obter informa��o

%Verifica se a casa (L,C) no tabuleiro B está livre
isFree(L,C,B) :-
           isElementIn(L,C,B,'O').

%Verifica se a casa (L,C) é uma casa onde não pode haver peças
isInvalid(L,C,B) :-
           isElementIn(L,C,B,'\\');
           isElementIn(L,C,B,'\x2f\').

%Verifica se a casa (L,C) está ocupada por uma peça qualquer no tabuleiro B
isPiece(L,C,B) :-
           isPlayerPiece(L,C,B,1); isPlayerPiece(L,C,B,2).

%Verifica se a casa (L,C) está ocupada por uma peça do jogador P no tabuleiro B
isPlayerPiece(L,C,B,1) :-
           isElementIn(L,C,B,'A').

isPlayerPiece(L,C,B,2) :-
           isElementIn(L,C,B,'B').

%Verifica se a casa (L,C) é ocupada pelo elemento  no tabuleiro B
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

%Verifica se o movimento (L1,C1)->(L2,C2) é permitido no tabuleiro B em algum dos dois sentidos
isAllowedMove(L1,C1,L2,C2,B) :-
           isValidMove(L1,C1,L2,C2,1,B); isValidMove(L1,C1,L2,C2,-1,B).

%Verifica se o movimento (L1,C1)->(L2,C2) é permitido no tabuleiro B no sentido S
isValidMove(L1,C1,L2,C2,S,B) :-
           (L1 = L2, C1 = C2); %Quando o caminho j� foi todo verificado
           isHorMove(L1,C1,L2,C2),
             ((S == 1),
                 (
                     isSquare(L1,C1,1),
                     C is C1 + 1,
                     isFree(L1,C,B),
                     isValidMove(L1,C,L2,C2,S,B)
                 );
                 (
                     isSquare(L1,C1,5),
                     C is C1 + 1,
                     isFree(L1,C,B),
                     isValidMove(L1,C,L2,C2,S,B)  
                 );
                 (
                     ((C1 >= 9) -> C is 1; C is C1 + 1),
                     isFree(L1,C,B),
                     isValidMove(L1,C,L2,C2,S,B)
                 )
             );!;
             ((S == -1),
                 (
                     isSquare(L1,C1,2),
                     C is C1 + 1,
                     isFree(L1,C,B),
                     isValidMove(L1,C,L2,C2,S,B)
                 );
                 (
                     isSquare(L1,C1,4),
                     C is C1 - 1,
                     isFree(L1,C,B),
                     isValidMove(L1,C,L2,C2,S,B)  
                 );
                 (
                     ((C1 =< 1) -> C is 9; C is C1 - 1),
                     isFree(L1,C,B),
                     isValidMove(L1,C1,L2,C2,S,B)
                 )
             );!;
           isVerMove(L1,C1,L2,C2),
             ((S == 1),
                 (
                     isSquare(L1,C1,2),
                     L is L1 - 1,
                     isFree(L,C1,B),
                     isValidMove(L,C1,L2,C2,S,B)
                 );
                 (
                     isSquare(L1,C1,4),
                     L is L1 + 1,
                     isFree(L,C1,B),
                     isValidMove(L,C1,L2,C2,S,B)  
                 );
                 (
                     ((L1 >= 9) -> L is 1; L is L1 + 1),
                     isFree(L,C1,B),
                     isValidMove(L,C1,L2,C2,S,B)
                 )
             );!;
             ((S == -1),
                 (
                     isSquare(L1,C1,2),
                     L is L1 + 1,
                     isFree(L,C1,B),
                     isValidMove(L,C1,L2,C2,S,B)
                 );
                 (
                     isSquare(L1,C1,4),
                     L is L1 - 1,
                     isFree(L,C1,B),
                     isValidMove(L,C1,L2,C2,S,B)  
                 );
                 (
                     ((L1 =< 1) -> L is 9; L is L1 - 1),
                     isFree(L,C1,B),
                     isValidMove(L,C1,L2,C2,S,B)
                 )
             );!;
           (isCircleMove(L1,C1,L2,C2),
            (
             (
                 isSquare(L1,C1,1),
                  ((isRightEdge(L1,C1), S == 1,L is 4, C is 10 - L1); %no sentido positivo, roda pela direita
                   (isLeftEdge(L1,C1), S == -1, L is 4, C is L1); %no sentido negativo, roda pela esquerda
                   (S == -1, L is L1, C is C1 - 1); %Coluna 5 no sentido negativo: Esquerda
                   (S == 1, L is L1, C is C1 + 1)), %Coluna 5 no sentido positivo: Direita
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

%Verifica se o jogador P ainda não perdeu no Tabuleiro B
checkBeforeTurn(P,B) :-
           isInPlay(1,4,P,B).

%Verifica se na casa (L,C) do tabuleiro B há alguma peça do jogador P, e em caso afirmativo, verifica se ela se pode mover
isInPlay(L,C,P,B) :-
           (C == 9, L == 9);
           (L < 9, C == 9, L1 is L + 1, checkMovablePiece(L,C,P,B), isInPlay(L1,1,P,B));
           (C < 9, C1 is C+1, checkMovablePiece(L,C,P,B), isInPlay(L,C1,P,B)).

%Verifica se a casa (L,C) no tabuleiro B é uma peça que se pode mover, uma casa fora do tabuleiro ou uma casa vazia
checkMovablePiece(L,C,P,B) :-
           %Ou não está no tabuleiro, ou é uma peça que se pode mover do jogador ou não é uma peça do jogador
               \+isInBoard(L,C);(isPlayerPiece(L,C,B,P),canMove(L,C,B));\+isPlayerPiece(L,C,B,P).

%Verifica se uma peça hipotética na casa (L,C) do tabuleiro B consegue mover-se
canMove(L,C,B) :-
           (isSquare(L,C,1),
                ((isLeftEdge(L,C), isFree(4,L,B));
                 (isRightEdge(L,C),isFree(4,10-L,B));
                 (L == 1, isFree(9,C,B));
                 isFree(L,C-1,B);
                 isFree(L,C+1,B);
                 isFree(L-1,C,B);
                 isFree(L+1,C,B)
                ));
           (isSquare(L,C,5),
                ((isLeftEdge(L,C),isFree(6,10-L,B));
                 (isRightEdge(L,C),isFree(6,L,B));
                 (L == 9, isFree(1,C,B));
                  isFree(L,C-1,B);
                  isFree(L,C+1,B);
                  isFree(L-1,C,B);
                  isFree(L+1,C,B)
                ));
           (isSquare(L,C,2),
                ((isUpperEdge(L,C),isFree(C,4,B));
                 (isLowerEdge(L,C),isFree(10-C,4,B));
                 (C == 1, isFree(L,9,B));
                  isFree(L-1,C,B);
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
                 (isLowerEdge(L,C),isFree(C,6,B));
                 (C == 9, isFree(L,1,B));
                  isFree(L-1,C,B);
                  isFree(L+1,C,B);
                  isFree(L,C-1,B);
                  isFree(L,C+1,B)
                )).

%Verifica se a casa (L,C) fica no Setor N do tabuleiro
isSquare(L,C,N) :-
           (N = 1, L > 0, L < 4, C > 3, C < 7);
           (N = 2, L > 3, L < 7, C > 0, C < 4);
           (N = 3, L > 3, L < 7, C > 3, C < 7);
           (N = 4, L > 3, L < 7, C > 6, C < 10);
           (N = 5, L > 6, L < 10, C > 3, C < 7).

%Verifica se (L,C) é uma beirada esquerda que dá acesso a um círculo           
isLeftEdge(L,C) :-
           isEdge(L,C), C = 4, (isSquare(L,C,1);isSquare(L,C,5)).

%Verifica se (L,C) é uma beirada direita que dá acesso a um círculo
isRightEdge(L,C) :-
           isEdge(L,C), C = 6, (isSquare(L,C,1);isSquare(L,C,5)).   

%Verifica se (L,C) é uma beirada superior que dá acesso a um círculo
isUpperEdge(L,C) :-
           isEdge(L,C), L = 4, (isSquare(L,C,2);isSquare(L,C,4)).

%Verifica se (L,C) é uma beirada inferior que dá acesso a um círculo
isLowerEdge(L,C) :-
           isEdge(L,C), L = 6, (isSquare(L,C,2);isSquare(L,C,4)).         

%Verifica se (L,C) é uma beirada que dá acesso a um círculo
isEdge(L,C) :- %identifica pontos de entrada em curvas
           ((L = 1 ; L = 2 ; L = 3; L = 7; L = 8; L = 9), (C = 4 ; C = 6));
           ((L = 4 ; L = 6), (C = 1 ; C = 2 ; C = 3; C = 7; C = 8; C = 9)).

%Verifica se (L1,C1)->(L2,C2) pode ser um movimento vertical
isVerMove(L1,C1,L2,C2) :-
           C1 = C2,
           L1 =\= L2,
           isInBoard(L1,C1),
           isInBoard(L2,C2).

%Verifica se (L1,C1)->(L2,C2) pode ser um movimento horizontal
isHorMove(L1,C1,L2,C2) :-
           L1 = L2,
           C1 =\= C2,
           isInBoard(L1,C1),
           isInBoard(L2,C2).

%Verifica se (L,C) pertence ao circulo Circle
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

%Verifica se (L1,C1)->(L2,C2) pode ser um movimento circular
isCircleMove(L1,C1,L2,C2) :-
           belongsToCircle(L1,C1,Circle1),
           belongsToCircle(L2,C2,Circle2),
           Circle1 == Circle2,
           isInBoard(L1,C1),
           isInBoard(L2,C2).

%Verifica se (L,C) está dentro do tabuleiro e é uma casa válida para peças
isInBoard(L,C) :- %L -> Linha a verificar, C -> Coluna a verificar
           (L>0, L < 4, C > 3, C < 7);
           (L>3, L < 7, C > 0, C < 10);
           (L>6, L < 10, C > 3, C < 7).