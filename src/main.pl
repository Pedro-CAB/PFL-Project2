:- consult(display).
:- consult(analyze).
:- consult(utils).

%Inicia o Jogo no Menu Principal
play :-
           drawMainMenu,
           read(N),
           drawGameMenu(N),
           read(M),
           start(M).

%Faz Setup do Tabuleiro e do Modo de Jogo
% M -> Modo de Jogo que pode ser:
% -- 1 -> Jogador vs Jogador
% -- 2 -> Jogador vs PC
% -- 3 -> PC vs PC
start(M) :-
           M = 1,
           %BOARDS DE TESTE DE MOVIMENTO
           Board = [ ['\x2f\','\x2f\','\x2f\','O','O','A','\\','\\','\\'],
                     ['\x2f\','\x2f\','\x2f\','A','O','A','\\','\\','\\'],
                     ['\x2f\','\x2f\','\x2f\','A','O','O','\\','\\','\\'],
                     ['A','O','O','A','O','A','O','O','O'],
                     ['O','O','O','O','O','O','O','O','O'],
                     ['O','O','O','B','O','B','O','O','O'],
                     ['\\','\\','\\','B','O','B','\x2f\','\x2f\','\x2f\'],
                     ['\\','\\','\\','B','O','B','\x2f\','\x2f\','\x2f\'],
                     ['\\','\\','\\','B','O','B','\x2f\','\x2f\','\x2f\']],
           %BOARD CORRETO ABAIXO
           /*Board = [ ['\x2f\','\x2f\','\x2f\','A','O','A','\\','\\','\\'],
                     ['\x2f\','\x2f\','\x2f\','A','O','A','\\','\\','\\'],
                     ['\x2f\','\x2f\','\x2f\','A','O','A','\\','\\','\\'],
                     ['O','O','O','A','O','A','O','O','O'],
                     ['O','O','O','O','O','O','O','O','O'],
                     ['O','O','O','B','O','B','O','O','O'],
                     ['\\','\\','\\','B','O','B','\x2f\','\x2f\','\x2f\'],
                     ['\\','\\','\\','B','O','B','\x2f\','\x2f\','\x2f\'],
                     ['\\','\\','\\','B','O','B','\x2f\','\x2f\','\x2f\']],*/
           game(M,Board).    

game(1,B) :-
           turn(1,B,_).


turn(1,B,N) :-
           (announceTurn(1),
            checkBeforeTurn(1,B),
            showBoard(B,1),
            moveChoice(B,1,N),
            turn(2,N,_));
           (showBoard(B,1), win(2)).

turn(2,B,N) :-
           (announceTurn(2),
            checkBeforeTurn(2,B),
            showBoard(B,1),
           moveChoice(B,2,N),
           turn(1,N,_));
           (showBoard(B,1), win(1)).

announceTurn(P) :- write('Player '),write(P), write(' turn...\n').

win(P) :- write('Player '), write(P), write(' wins!\n').
                
moveChoice(B,P,N) :-
           write('Which piece do you want to move?\n'),
           write('Insert the line of the piece:\n'),
           read(L1),
           write('Insert the column of the piece:\n'),
           read(C1),
           (\+isPlayerPiece(L1,C1,B,P) -> pieceChoiceMessage(P), showBoard(B,1), moveChoice(B,P,N);
                isPlayerPiece(L1,C1,B,P),
                write('Where do you want to move it to?\n'),
                write('Insert the line of the position:\n'),
                read(L2),
                write('Insert the column of the position:\n'),
                read(C2),
                (\+isAllowedMove(L1,C1,L2,C2,B) -> tryMoveAgainMessage, showBoard(B,1), moveChoice(B,P,N), !;
                        isAllowedMove(L1,C1,L2,C2,B),
                        %write('Should move the piece from '), write(L1),write('-'),write(C1), write(' to '),write(L2),write('-'),write(C2), write('\n')
                        movePiece(L1,C1,L2,C2,B,N)
                )
           ).

pieceChoiceMessage(P) :- write('There isn\'t any pieces of yours there!\n'),
                write('Try again, player '), write(P), write('!\n').

tryMoveAgainMessage :- write('You can\'t place the piece there! Try choosing another piece...\n').  

% Move a Peça que está em (L1,C1) para (L2,C2).
% A alteração é feita no tabuleiro B e guardada no tabuleiro Result
movePiece(L1,C1,L2,C2,B,Result) :-
           indexOf(L1,B,X), %X é a linha do tabuleiro da peca a mover
           indexOf(C1,X,Y), %Y é a peça a mover
           indexOf(L2,B,W), %W é a linha do tabuleiro da peca destino
           indexOf(C2,W,Z), %Z é a peça destino
           L3 is L1-1,
           C3 is C1-1,
           replace(B, L3 , C3 , Z , B1),
           L4 is L2-1,
           C4 is C2-1,
           replace(B1, L4 , C4 , Y , Result).