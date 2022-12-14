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
           Board = [            ['A','O','A'],
                                 ['A','O','A'],
                                 ['A','O','A'],
                     ['O','O','O','A','O','A','O','O','O'],
                     ['O','O','O','O','O','O','O','O','O'],
                     ['O','O','O','B','O','B','O','O','O'],
                                 ['B','O','B'],
                                 ['B','O','B'],
                                 ['B','O','B']],
           write('Starting Player 1 Turn...'),
           turn(1, Board).


turn(P,B) :-
           write('Starting Player '), write(P),write(' turn...\n'),
           write('___________________\n'),
           write('|A|B|C|D|E|F|G|H|I|\n'),
           showBoard(B).

showBoard(B) :-
           [L|R] = B,
           showLine(L,1),
           showBoard(R).

showLine(L,N1) :- % N1= Nº da Linha
           N1>0, N1<4,
           write('|X|X|X'),
           [S1|R] = L,
           [S2|R2] = R,
           [S3|_] = R2,
           write('|'),write(S1),write('|'),write(S2),write('|'),write(S3),write('|'),
           write('X|X|X|\n').
           
           
           