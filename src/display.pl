%Funções que fazem display do tabuleiro e de elementos complexos do jogo

showBoard(B,1) :- % B -> Lista que representa o Tabuleiro.
           write('             Column       \n'),
           write('       |1|2|3|4|5|6|7|8|9|\n'),
           [L|R] = B,
           write('      1|'),
           showLine(L,1),
           showBoard(R,2).

showBoard(B,9) :- % B -> Lista que representa o Tabuleiro.
           [L|_] = B,
           write('      9|'),
           showLine(L,9),
           write('       |1|2|3|4|5|6|7|8|9|\n'),
           write('             Column       \n').

showBoard(B,5) :- % B -> Lista que representa o Tabuleiro.
           [L|R] = B,
           write(' Line '),write('5|'),showLine(L,5),
           showBoard(R,6).

showBoard(B,N) :- % B -> Lista que representa o Tabuleiro. N -> Nº da Linha
           [L|R] = B,
           write('      '),write(N), write('|'),showLine(L,N),
           N1 is N + 1,
           showBoard(R,N1).

showLine(L,N) :- % L -> Lista que representa uma linha do Tabuleiro. N -> Nº da Linha
           (N>0, N<10),
           [S1|[S2|[S3|[S4|[S5|[S6|[S7|[S8|[S9|_]]]]]]]]] = L,
           write(S1),write('|'),write(S2),write('|'),write(S3),write('|'),write(S4),write('|'),write(S5),write('|'),write(S6),write('|'),write(S7),write('|'),write(S8),write('|'),write(S9),write('|\n').