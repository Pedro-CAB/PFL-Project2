:- consult(display).
:- consult(analyze).
:- consult(utils).

play :-
           drawMainMenu,
           read(N),
           drawGameMenu(N),
           read(M),
           start(M).

start(M) :-
           M = 1,
           Board = [ ['\x2f\','\x2f\','\x2f\','A','O','A','\\','\\','\\'],
                     ['\x2f\','\x2f\','\x2f\','A','O','A','\\','\\','\\'],
                     ['\x2f\','\x2f\','\x2f\','A','O','A','\\','\\','\\'],
                     ['O','O','O','A','O','A','O','O','O'],
                     ['O','O','O','O','O','O','O','O','O'],
                     ['O','O','O','B','O','B','O','O','O'],
                     ['\\','\\','\\','B','O','B','\x2f\','\x2f\','\x2f\'],
                     ['\\','\\','\\','B','O','B','\x2f\','\x2f\','\x2f\'],
                     ['\\','\\','\\','B','O','B','\x2f\','\x2f\','\x2f\']],
           game(M,Board).    

game(M,B) :-
           M = 1,
           turn(1,B,N),
           %not(win(B)), win/lose shows board and result (who won)
           turn(2,N,R),
           %not(win(B)),
           game(M,R).

turn(P,B,N) :-
           write('Player '), write(P), write(' turn...\n'),
           showBoard(B,1),
           moveChoice(B,P,N).
                
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
                (\+isFree(L2,C2,B) -> tryMoveAgainMessage, showBoard(B,1), moveChoice(B,P,N), !;
                        isFree(L2,C2,B),
                        %write('Should move the piece from '), write(L1),write('-'),write(C1), write(' to '),write(L2),write('-'),write(C2), write('\n')
                        movePiece(L1,C1,L2,C2,B,N)
                )
           ).

pieceChoiceMessage(P) :- write('There isn\'t any pieces of yours there!\n'),
                write('Try again, player '), write(P), write('!\n').

tryMoveAgainMessage :- write('You can\'t place the piece there! Try choosing another piece...\n').  

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

