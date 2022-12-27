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
           write('Called for position ( '), write(L1), write(','),write(C1),write(')\n'),
           (L1 = L2, C1 = C2); %Quando o caminho já foi todo verificado
           (isHorMove(L1,C1,L2,C2),
             (
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
             )
           );
           (isVerMove(L1,C1,L2,C2),
             (
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
             )
           );
           (isCircleMove(L1,C1,L2,C2), write('Stuck In Circle Options\n'),
             (
                 isSquare(L1,C1,1), write('Entered Sector 1\n'),
              (
                  write('Starting Circle Move in Sector 1 (right)\n'),
                  (\+(isEdge(L1,C1)) -> (L is 4, C is 10 - L1); (L is L1, C is C1 + 1)),
                  isFree(L,C,B),
                  write('Moving to position ( '), write(L), write(','),write(C),write(')\n'),
                  isValidMove(L,C,L2,C2,B)
              );
              (
                  write('Starting Circle Move in Sector 1 (left)\n'),
                  (\+(isEdge(L1,C1)) -> (L is 4, C is L1); (L is L1, C is C1 - 1)),
                  isFree(L,C,B),
                  write('Moving to position ( '), write(L), write(','),write(C),write(')\n'),
                  isValidMove(L,C,L2,C2,B)
              )
             );
            (
                 isSquare(L1,C1,5), write('Entered Sector 5\n'),
              (
                  write('Starting Circle Move in Sector 5 (right)\n'),
                  (\+(isEdge(L1,C1)) -> (L is 6, C is L1); (L is L1, C is C1 + 1)),
                  isFree(L,C,B),
                  write('Moving to position ( '), write(L), write(','),write(C),write(')\n'),
                  isValidMove(L,C,L2,C2,B)
              );
              (
                  write('Starting Circle Move in Sector 5 (left)\n'),
                  (\+(isEdge(L1,C1)) -> (L is 6, C is 10 - L1); (L is L1, C is C1 - 1)),
                  isFree(L,C,B),
                  write('Moving to position ( '), write(L), write(','),write(C),write(')\n'),
                  isValidMove(L,C,L2,C2,B)
              )
             );
             (
                 (isSquare(L1,C1,2)),write('Entered Sector 2\n'),
              (
                  write('Starting Circle Move in Sector 2 (down)\n'),
                  (\+(isEdge(L1,C1)) -> (L is 10 - C1, C is 4); (L is L1 + 1, C is C1)),
                  isFree(L,C,B),
                  write('Moving to position ( '), write(L), write(','),write(C),write(')\n'),
                  isValidMove(L,C,L2,C2,B)
              );
              (
                  write('Starting Circle Move in Sector 2 (up)\n'),
                  (\+(isEdge(L1,C1)) -> (L is C1, C is 4); (L is L1 - 1, C is C1)),
                  isFree(L,C,B),
                  write('Moving to position ( '), write(L), write(','),write(C),write(')\n'),
                  isValidMove(L,C,L2,C2,B)
              )
             );
             (
                 (isSquare(L1,C1,4)),write('Entered Sector 4\n'),
              (
                  write('Starting Circle Move in Sector 4 (down)\n'),
                  (\+(isEdge(L1,C1)) -> (L is C1, C is 6); (L is L1 + 1, C is C1)),
                  isFree(L,C,B),
                  write('Moving to position ( '), write(L), write(','),write(C),write(')\n'),
                  isValidMove(L,C,L2,C2,B)
              );
              (
                  write('Sarting Circle Move in Sector 4 (up)\n'),
                  (\+(isEdge(L1,C1)) -> (L is 10 - C1, C is 6); (L is L1 - 1, C is C1)),
                  isFree(L,C,B),
                  write('Moving to position ( '), write(L), write(','),write(C),write(')\n'),
                  isValidMove(L,C,L2,C2,B)
              )
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