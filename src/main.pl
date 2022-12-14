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
           Board = [             ['A','O','A'],
                                 ['A','O','A'],
                                 ['A','O','A'],
                     ['O','O','O','A','O','A','O','O','O'],
                     ['O','O','O','O','O','O','O','O','O'],
                     ['O','O','O','B','O','B','O','O','O'],
                                 ['B','O','B'],
                                 ['B','O','B'],
                                 ['B','O','B']],
           game(M,Board).    

game(M,B) :-
           M = a,
           turn(1,B),
           %not(win(B)),
           turn(2,B),
           %not(win(B)),
           game(M,B).

turn(P,B) :-
           write('Player '), write(P),write(' turn...\n'),
           showBoard(B,1),
           moveChoice(B).
                
moveChoice(B) :-
           write('Which piece do you want to move?\n'),
           write('Insert the letter of the piece:\n'),
           read(L1),
           write('Insert the number of the piece:\n'),
           read(N1),
           write('Moving Piece in '),write(L1),write('-'),write(N1), write('...\n'),
           write('Where do you want to move it to?\n'),
           write('Insert the letter of the position:\n'),
           read(L2),
           write('Insert the number of the position:\n'),
           read(N2),
           write('Should move the piece from '), write(L1),write('-'),write(N1), write(' to '),write(L2),write('-'),write(N2), write('\n'),
           showBoard(B,1).

showBoard(B,1) :-
           write('             Column       \n'),
           write('       |1|2|3|4|5|6|7|8|9|\n'),
           [L|R] = B,
           write('      1|'),
           showLine(L,1),
           showBoard(R,2).

showBoard(B,9) :-
           [L|_] = B,
           write('      9|'),
           showLine(L,9),
           write('       |1|2|3|4|5|6|7|8|9|\n'),
           write('             Column       \n').

showBoard(B,5) :-
           [L|R] = B,
           write(' Line '),write('5|'),showLine(L,5),
           showBoard(R,6).

showBoard(B,N) :-
           [L|R] = B,
           write('      '),write(N), write('|'),showLine(L,N),
           N1 is N + 1,
           showBoard(R,N1).

showLine(L,N) :- % N1= Nº da Linha
           (N>0 , N<4),
           [S1|[S2|[S3|_]]] = L,
           write('     |'),write(S1),write('|'),write(S2),write('|'),write(S3),write('|     |'),
           write('\n').

showLine(L,N) :- % N1= Nº da Linha
           (N>6 , N<10),
           write('     '),
           [S1|[S2|[S3|_]]] = L,
           write('|'),write(S1),write('|'),write(S2),write('|'),write(S3),write('|     |\n').

showLine(L,N) :- % N1= Nº da Linha
           N>3, N<7,
           [S1|[S2|[S3|[S4|[S5|[S6|[S7|[S8|[S9|_]]]]]]]]] = L,
           write(S1),write('|'),write(S2),write('|'),write(S3),write('|'),write(S4),write('|'),write(S5),write('|'),write(S6),write('|'),write(S7),write('|'),write(S8),write('|'),write(S9),write('|\n').