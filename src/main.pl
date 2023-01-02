:- use_module(library(random)).

:- consult(display).
:- consult(analyze).
:- consult(utils).

%Inicia o Jogo no Menu Principal
play :-
           drawMainMenu,
           read(N), 
           (N=1 -> drawGameMenu,read(M),        % M -> Modo de Jogo
            chooseBoard(O),
            initial_state(B),                   %inicio do jogo consoante os Modos de Jogo
                (M=1 -> display_game(1,B,_,O);  % -- 1 -> Jogador vs Jogador
                 M=2 -> display_game(3,B,_,O);  % -- 2 -> Jogador vs PC
                 M=3 -> display_game(5,B,_,O)   % -- 3 -> PC vs PC
                );   
            N=2 -> drawRules, read(1), play;
            N=3 -> drawAboutUs, read(1), play;
            N=4 -> true
            ).

chooseBoard(O) :-
           drawBoardOptions,
           read(R),
           (R=1->O=R;R=2->O=R;R=3->O=R;O=1).

%Faz Setup do Tabuleiro
initial_state(B) :-
           %BOARDS DE TESTE DE MOVIMENTO
           B = [ ['\x2f\','\x2f\','\x2f\','A','A','O','\\','\\','\\'],
                     ['\x2f\','\x2f\','\x2f\','A','O','A','\\','\\','\\'],
                     ['\x2f\','\x2f\','\x2f\','A','O','A','\\','\\','\\'],
                     ['O','O','O','A','O','A','O','O','O'],
                     ['O','O','O','O','O','O','O','O','O'],
                     ['B','O','O','O','O','B','O','O','O'],
                     ['\\','\\','\\','B','O','B','\x2f\','\x2f\','\x2f\'],
                     ['\\','\\','\\','B','O','B','\x2f\','\x2f\','\x2f\'],
                     ['\\','\\','\\','B','O','B','\x2f\','\x2f\','\x2f\']].
           %BOARD CORRETO ABAIXO
           /*B = [ ['\x2f\','\x2d\','\x2d\','A','O','A','\x2d\','\x2d\','\\'],
                     ['\x7c\','\x2f\','\x2d\','A','O','A','\x2d\','\\','\x7c\'],
                     ['\x7c\','\x7c\','\x2f\','A','O','A','\\','\x7c\','\x7c\'],
                     ['O','O','O','A','O','A','O','O','O'],
                     ['O','O','O','O','O','O','O','O','O'],
                     ['O','O','O','B','O','B','O','O','O'],
                     ['\x7c\','\x7c\','\\','B','O','B','\x2f\','\x7c\','\x7c\'],
                     ['\x7c\','\\','\x2d\','B','O','B','\x2d\','\x2f\','\x7c\'],
                     ['\\','\x2d\','\x2d\','B','O','B','\x2d\','\x2d\','\x2f\']].*/


display_game(1,B,N,O) :-
           (game_over(1,B),
            display_game(B,O),
            announceTurn(1),
            move([B,O],1,N),
            display_game(2,N,_,O));
           (display_game(B,O), win(2)).

display_game(2,B,N,O) :-
           (game_over(2,B),
            display_game(B,O),
            announceTurn(2),
            move([B,O],2,N),
            display_game(1,N,_,O));
           (display_game(B,O), win(1)).

display_game(3,B,N,O) :-
           (checkBeforeTurn(1,B),
            display_board(B,O),
            announceTurn(1),
            move([B,O],1,N),
            display_game(4,N,_,O));
           (display_board(B,O), win(2)).

%computer 1 takes the second turn against human player
display_game(4,B,N,O) :-
           (checkBeforeTurn(2,B),
            display_board(B,O),
            announceTurn(2),
            computerMove([B,2],N),
            display_game(3,N,_,O));
           (display_board(B,O), win(1)).

%computer 2 turn 1 in (pc vs pc)
display_game(5,B,N,O) :-
           (checkBeforeTurn(1,B),
            display_board(B,O),
            announceTurn(1),
            computerMove([B,1],N),
            display_game(6,N,_,O));
           (display_board(B,O), win(2)).

%computer 3 turn 2 in (pc vs pc)
display_game(6,B,N,O) :-
           (checkBeforeTurn(2,B),
            display_board(B,O),
            announceTurn(2),
            computerMove([B,2],N),
            display_game(5,N,_,O));
           (display_board(B,O), win(1)).

announceTurn(P) :- write('Player '),write(P), write(' turn...\n').

win(P) :- write('Player '), write(P), write(' wins!\n').
                
move(Gs,P,N) :-
           [B,O]=Gs,
           write('Which piece do you want to move?\n'),
           write('Insert the line of the piece:\n'),
           read(L1),
           write('Insert the column of the piece:\n'),
           read(C1),
           (\+isPlayerPiece(L1,C1,B,P) -> pieceChoiceMessage(P), display_game(B,O), move(Gs,P,N);
                isPlayerPiece(L1,C1,B,P),
                write('Where do you want to move it to?\n'),
                write('Insert the line of the position:\n'),
                read(L2),
                write('Insert the column of the position:\n'),
                read(C2),
                (\+isAllowedMove(L1,C1,L2,C2,B) -> tryMoveAgainMessage(P), display_game(B,O), move(Gs,P,N), !;
                        isAllowedMove(L1,C1,L2,C2,B),
                        %write('Should move the piece from '), write(L1),write('-'),write(C1), write(' to '),write(L2),write('-'),write(C2), write('\n')
                        movePiece(L1,C1,L2,C2,B,N)
                )
           ).

computerMove(Gs, N) :-
           [B,P]=Gs,
           random(1,9,L1),
           random(1,9,C1),
           (\+isPlayerPiece(L1,C1,B,P)->computerMove(Gs, N);
              isPlayerPiece(L1,C1,B,P) -> random(1,9,L2),
              random(1,9,C2),
              (\+isAllowedMove(L1,C1,L2,C2,B)->computerMove(Gs, N);
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