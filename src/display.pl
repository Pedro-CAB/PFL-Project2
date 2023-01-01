%Funcoes que fazem display dos menus, tabuleiro e elementos complexos do jogo

%Desenha o menu principal
drawMainMenu :-
                        write('______________________________________________\n'),
                        write('|                                             |\n'),
                        write('|        \\ \\                      / /         |\n'),
                        write('|         \\ \\                    / /          |\n'),
                        write('|          \\ \\      / /\\ \\      / /           |\n'),
                        write('|           \\ \\    / /  \\ \\    / /            |\n'),
                        write('|            \\ \\  / /    \\ \\  / /             |\n'),
                        write('|             \\ \\/ /      \\ \\/ /              |\n'),
                        write('|              Welcome to Wana!               |\n'),   
                        write('|                                             |\n'),
                        write('|               1 - Start Game                |\n'),    
                        write('|               2 - Rules                     |\n'),
                        write('|               3 - About Us                  |\n'),
                        write('|               4 - Exit Game                 |\n'),
                        write('|_____________________________________________|\n').

%Desenha o menu de modo de jogo
drawGameMenu :-
        write('______________________________________________\n'),
        write('|       _____                                 |\n'),
        write('|      / ____|                                |\n'),
        write('|     | |  __   __ _  _ __ ___    ___         |\n'),
        write('|     | | |_ | / _  || _  _   \\  / _ \\        |\n'),
        write('|     | |__| || (_| || | | | | ||  __/        |\n'),
        write('|      \\_____| \\__,_||_| |_| |_| \\___|        |\n'),
        write('|                                             |\n'),   
        write('|              Select a gamemode:             |\n'),
        write('|                                             |\n'),   
        write('|            1 - Player vs Player             |\n'),
        write('|            2 - Player vs Computer           |\n'),
        write('|            3 - Computer vs Computer         |\n'),
        write('|_____________________________________________|\n').

drawRules :-
        write('______________________________________________\n'),
        write('|                                             |\n'),
        write('|                   Rules                     |\n'),
        write('|      The goal is to trap your opponent!     |\n'),
        write('|  You only need to make one of their pieces  |\n'),
        write('|  stuck. Choose a piece of yours to move,    |\n'),
        write('|  you can move it as far as you want in the  |\n'),   
        write('|  same line, without going through or into   |\n'),
        write('|  the same spot as other piece. You can also |\n'),   
        write('|  go over the edge of the board and travel   |\n'),
        write('|  from the opposite side on the same line.   |\n'),
        write('|                 Have fun!                   |\n'),
        write('|             press 1. to go back             |\n'),
        write('|_____________________________________________|\n').

drawAboutUs :-
        write('______________________________________________\n'),
        write('|                                             |\n'),
        write('|                  About us                   |\n'),
        write('|                                             |\n'),
        write('|                                             |\n'),
        write('|                 FEUP - PFL                  |\n'),
        write('|                   Prolog                    |\n'),
        write('|                                             |\n'),   
        write('|        Mariana Teixeira > up201905705       |\n'),
        write('|           Pedro Gomes > up202006086         |\n'),
        write('|                                             |\n'),   
        write('|                                             |\n'),
        write('|             press 1. to go back             |\n'),
        write('|_____________________________________________|\n').


display_game(B) :-
           showBoard(B,1).

%Mostra o Tabuleiro B Linha a Linha
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

showBoard(B,N) :- % B -> Lista que representa o Tabuleiro. N -> N� da Linha
           [L|R] = B,
           write('      '),write(N), write('|'),showLine(L,N),
           N1 is N + 1,
           showBoard(R,N1).

%Mostra a Linha N do tabuleiro
showLine(L,N) :- % L -> Lista que representa uma linha do Tabuleiro. N -> N� da Linha
           (N>0, N<10),
           [S1|[S2|[S3|[S4|[S5|[S6|[S7|[S8|[S9|_]]]]]]]]] = L,
           write(S1),write('|'),write(S2),write('|'),write(S3),write('|'),write(S4),write('|'),write(S5),write('|'),write(S6),write('|'),write(S7),write('|'),write(S8),write('|'),write(S9),write('|\n').