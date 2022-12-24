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

isValidMove(L1,C1,L2,C2,B) :-
           (L1 = L2, C1 = C2); %Quando o caminho já foi todo verificado
           (isHorMove(L1,C1,L2,C2),
             (
                 (\+(C1 < 9) -> C is 1; C is C1 + 1),
                 isFree(L1,C,B),
                 isValidMove(L1,C,L2,C2,B),
                 write('Stuck In Horizontal Option 1\n')
             );
             (
                 (\+(C1 > 1) -> C is 9; C is C1 - 1),
                 isFree(L1,C,B),
                 isValidMove(L1,C,L2,C2,B),
                 write('Stuck In Horizontal Option 2\n')
             )
           );
           (isVerMove(L1,C1,L2,C2),
             (
                 (\+(L1 < 9) -> L is 1; L is L1 + 1),
                 isFree(L,C1,B),
                 isValidMove(L,C1,L2,C2,B),
             write('Stuck In Vertical Option 1\n')
             );
             (
                 (\+(L1 > 1) -> L is 9; L is L1 - 1),
                 isFree(L,C1,B),
                 isValidMove(L,C1,L2,C2,B),
             write('Stuck In Vertical Option 2\n')
             )
           );
           (isCircleMove(L1,C1,L2,C2),
             ((isSquare(L1,C1,1);isSquare(L1,C1,5)),
              (\+(isEdge(L1,C1)) -> (L is C1, C is L1); (L is L1, C is C1 + 1)),
              isFree(L,C,B),
              isValidMove(L,C,L2,C2,B),
             write('Stuck In Circle Option 1\n')
             );
             ((isSquare(L1,C1,2);isSquare(L1,C1,4)),
              (\+(isEdge(L1,C1)) -> (L is C1, C is L1); (L is L1 + 1, C is C1)),
              isFree(L,C,B),
              isValidMove(L,C,L2,C2,B),
             write('Stuck In Circle Option 2\n')
             );
             ((isSquare(L1,C1,1);isSquare(L1,C1,5)),
              (\+(isEdge(L1,C1)) -> (L is C1, C is L1); (L is L1, C is C1 - 1)),
              isFree(L,C,B),
              isValidMove(L,C,L2,C2,B),
             write('Stuck In Circle Option 3\n')
             );
             ((isSquare(L1,C1,2);isSquare(L1,C1,4)),
              (\+(isEdge(L1,C1)) -> (L is C1, C is L1); (L is L1 - 1, C is C1)),
              isFree(L,C,B),
              isValidMove(L,C,L2,C2,B),
             write('Stuck In Circle Option 4\n')
             )
           ).
           

isSquare(L,C,N) :-
           (N = 1, L > 0, L < 4, C > 3, C < 7);
           (N = 2, L > 3, L < 7, C > 0, C < 4);
           (N = 3, L > 3, L < 7, C > 3, C < 7);
           (N = 4, L > 3, L < 7, C > 6, C < 10);
           (N = 5, L > 6, L < 10, C > 3, C < 7).
           

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

isCircleMove(L1,C1,L2,C2) :-
           C1 =\= C2,
           L1 =\= L2,
           isInBoard(L1,C1),
           isInBoard(L2,C2).

isInBoard(L,C) :- %L -> Linha a verificar, C -> Coluna a verificar
           (L>0, L < 4, C > 3, C < 7);
           (L>3, L < 7, C > 0, C < 10);
           (L>6, L < 10, C > 3, C < 7).