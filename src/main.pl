:- consult(display).
:- consult(analyze).

play :-
           write('Welcome to Wana!\n'),
           write('Select a gamemode:\n'),
           write('(a) Player vs Player\n'),
           write('(b) Player vs Computer\n'),
           write('(c) Computer vs Computer\n'),
           read(M),
           start(M).

start(M) :-
           M = a,
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
           M = a,
           turn(1,B),
           %not(win(B)), win/lose shows board and result (who won)
           turn(2,B),
           %not(win(B)),
           game(M,B).

turn(P,B) :-
           write('Player '), write(P), write(' turn...\n'),
           showBoard(B,1),
           moveChoice(B,P).
                
moveChoice(B,P) :-
           write('Which piece do you want to move?\n'),
           write('Insert the line of the piece:\n'),
           read(L1),
           write('Insert the column of the piece:\n'),
           read(C1),
           (\+isPlayerPiece(L1,C1,B,P) -> pieceChoiceMessage(P), showBoard(B,1), moveChoice(B,P),!,fail; isPlayerPiece(L1,C1,B,P)),
           write('Where do you want to move it to?\n'),
           write('Insert the line of the position:\n'),
           read(L2),
           write('Insert the column of the position:\n'),
           read(C2),
           (\+isFree(L2,C2,B) -> tryMoveAgainMessage, showBoard(B,1), moveChoice(B,P), !, fail; isFree(L2,C2,B)),
           write('Should move the piece from '), write(L1),write('-'),write(C1), write(' to '),write(L2),write('-'),write(C2), write('\n'). %TODO - move.

pieceChoiceMessage(P) :- write('There isn\'t any pieces of yours there!\n'),
                write('Try again, player '), write(P), write('!\n').

tryMoveAgainMessage :- write('You can\'t place the piece there! Try choosing another piece...\n').                
