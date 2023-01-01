:- consult(display).
:- consult(analyze).
:- consult(utils).

%Inicia o Jogo no Menu Principal
play :-
           drawMainMenu,
           read(N), 
           (N=1 -> drawGameMenu,read(M),
           initial_state(M, B),
           turn(1,B,_);
            N=2 -> drawRules, read(1), play;
            N=3 -> drawAboutUs, read(1), play
            ).

%Faz Setup do Tabuleiro e do Modo de Jogo
% M -> Modo de Jogo que pode ser:
% -- 1 -> Jogador vs Jogador
% -- 2 -> Jogador vs PC
% -- 3 -> PC vs PC
initial_state(1,B) :-
           %BOARDS DE TESTE DE MOVIMENTO
           /*Board = [ ['\x2f\','\x2f\','\x2f\','O','O','A','\\','\\','\\'],
                     ['\x2f\','\x2f\','\x2f\','A','O','A','\\','\\','\\'],
                     ['\x2f\','\x2f\','\x2f\','A','O','O','\\','\\','\\'],
                     ['A','O','O','A','O','A','O','O','O'],
                     ['O','O','O','O','O','O','O','O','O'],
                     ['O','O','O','B','O','B','O','O','O'],
                     ['\\','\\','\\','B','O','B','\x2f\','\x2f\','\x2f\'],
                     ['\\','\\','\\','B','O','B','\x2f\','\x2f\','\x2f\'],
                     ['\\','\\','\\','B','O','B','\x2f\','\x2f\','\x2f\']],*/
           %BOARD CORRETO ABAIXO
           B = [ ['\x2f\','\x2f\','\x2f\','A','O','A','\\','\\','\\'],
                     ['\x2f\','\x2f\','\x2f\','A','O','A','\\','\\','\\'],
                     ['\x2f\','\x2f\','\x2f\','A','O','A','\\','\\','\\'],
                     ['O','O','O','A','O','A','O','O','O'],
                     ['O','O','O','O','O','O','O','O','O'],
                     ['O','O','O','B','O','B','O','O','O'],
                     ['\\','\\','\\','B','O','B','\x2f\','\x2f\','\x2f\'],
                     ['\\','\\','\\','B','O','B','\x2f\','\x2f\','\x2f\'],
                     ['\\','\\','\\','B','O','B','\x2f\','\x2f\','\x2f\']].


turn(1,B,N) :-
           (checkBeforeTurn(1,B),
            display_game(B),
            announceTurn(1),
            moveChoice(B,1,N),
            turn(2,N,_));
           (display_game(B), win(2)).

turn(2,B,N) :-
           (checkBeforeTurn(2,B),
            display_game(B),
            announceTurn(2),
            moveChoice(B,2,N),
            turn(1,N,_));
           (display_game(B), win(1)).

announceTurn(P) :- write('Player '),write(P), write(' turn...\n').

win(P) :- write('Player '), write(P), write(' wins!\n').
                
moveChoice(B,P,N) :-
           write('Which piece do you want to move?\n'),
           write('Insert the line of the piece:\n'),
           read(L1),
           write('Insert the column of the piece:\n'),
           read(C1),
           (\+isPlayerPiece(L1,C1,B,P) -> pieceChoiceMessage(P), display_game(B), moveChoice(B,P,N);
                isPlayerPiece(L1,C1,B,P),
                write('Where do you want to move it to?\n'),
                write('Insert the line of the position:\n'),
                read(L2),
                write('Insert the column of the position:\n'),
                read(C2),
                (\+isAllowedMove(L1,C1,L2,C2,B) -> tryMoveAgainMessage(P), display_game(B), moveChoice(B,P,N), !;
                        isAllowedMove(L1,C1,L2,C2,B),
                        %write('Should move the piece from '), write(L1),write('-'),write(C1), write(' to '),write(L2),write('-'),write(C2), write('\n')
                        movePiece(L1,C1,L2,C2,B,N)
                )
           ).

pieceChoiceMessage(P) :- write('There isn\'t any pieces of yours there!\n'),
                write('Try again, player '), write(P), write('!\n').

tryMoveAgainMessage(P) :- write('You can\'t place the piece there! Try choosing another piece, player '), write(P), write('...\n').  

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