%Funções auxiliares gerais

:- use_module(library(lists)).

%caso base de ser a primeira linha
replace([L|Ls], 0, Y, Z, [R|Ls]) :-
  replace_column(L,Y,Z,R).

%vai para a linha certa com a chamada recursiva
%lista, linha, coluna, valor, nova lista 
replace([L|Ls] , X , Y , Z , [L|Rs] ) :-
  X > 0,
  X1 is X-1,
  replace(Ls, X1, Y, Z, Rs).

%caso base de ser a primeira posicao
replace_column( [_|Cs] , 0 , Z , [Z|Cs] ) .  % once we find the specified offset, just make the substitution and finish up.

%vai para a coluna certa com a chamada recursiva
replace_column( [C|Cs] , Y , Z , [C|Rs] ) :-
  Y > 0 ,
  Y1 is Y-1 ,
  replace_column( Cs , Y1 , Z , Rs ).