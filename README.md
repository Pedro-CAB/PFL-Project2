# PFL_TP2_T08_Wana_5
Este projeto consistiu na implementação do jogo de tabuleiro Wana em Prolog. O projeto foi realizado por:
- Mariana Lima Teixeira, up
- Pedro Manuel Costa Aguiar Botelho Gomes, up202006086

Ambos os elementos contribuíram igualmente para o desenvolvimento do projeto, pelo que concordamos que a contribuição atribuída a cada elemento deve ser 50%.

## Conteúdos
- [Instalação e Execução](#instruções-de-execução)
- [Descrição do Jogo](#descrição-do-jogo)
  - [Links Relevantes](#links-relevantes)
- [Lógica do Jogo](#lógica-do-jogo)
  - [Representação Interna do Estado do Jogo](#representação-interna-do-estado-do-jogo)
  - [Visualização do Estado do Jogo](#visualização-do-estado-do-jogo)

## Instruções de Execução

- Compilar o código em Prolog a partir do ficheiro main.pl no Eclipse.
- Digitar "play." no terminal para iniciar o jogo.

## Descrição do Jogo
Wana é um jogo com um tabuleiro com o tamanho 9x9 casas, como o da imagem abaixo.

![image](https://user-images.githubusercontent.com/80784137/210279339-cb9e7fc4-f094-49be-949b-4a581b9324f0.png)

Apenas as casas marcadas com círculos pequenos podem ser ocupadas por peças e cada jogador tem um conjunto de 8 peças com as quais pode jogar durante a partida.
À vez, cada um dos jogadores deve movimentar uma das suas peças seguindo as seguintes regras:
- Uma peça pode mover-se quantas casas quiser na direção de uma linha branca do tabuleiro que esteja conectada à peça onde iniciou o movimento do turno. Isto inclui as linhas horizontais e verticais e também as linhas circulares nos quatro cantos do tabuleiro.
- Se uma peça se mover até à extremidade de uma linha vertical ou horizontal, pode continuar o seu movimento a partir da outra ponta da mesma linha, na extremidade oposta do tabuleiro.
- Para mover uma peça de uma casa para outra, precisa de haver pelo menos um caminho que una as duas através de uma só linha contínua no tabuleiro que não tenha nenhuma casa ocupada por peças, sejam elas do jogador adversário ou do que está a jogar no momento.

Os jogadores movem uma peça à vez até que um deles inicie o seu turno com pelo menos uma peça que não tenha opção de movimento nenhuma. Os jogadores são, segundo as regras, obrigados a mover sempre alguma peça na sua vez, não podendo passar o turno.

### Links Relevantes
Abaixo estão alguns links consultados para compreender melhor o funcionamento do jogo:
- [Página de Divulgação do Jogo no Kickstarter](https://www.kickstarter.com/projects/khanat/wana)
- [Site da BoardGameGeek, com resumo das regras](https://boardgamegeek.com/boardgame/364012/wana)

## Lógica do Jogo
### Representação Interna do Estado do Jogo
- O **tabuleiro do jogo** é guardado como uma lista de listas de strings e vai sendo passado entre as funções do ciclo de jogo. Sempre que é feito um movimento, o tabuleiro anterior a esse movimento é recebido por uma função que determina o novo tabuleiro, tabuleiro esse que passa a ser o usado daí em diante, até que o tabuleiro seja alterado novamente. Para facilitar a interpretação do código, usamos a letra B para identificar o argumento que correspondia ao tabuleiro recebido nas funções que precisavam dele.
- O **modo de jogo** (Jogador vs Jogador, Jogador vs PC, PC vs PC) é passado como um inteiro (valores 1, 2 e 3 respetivamente). A notação usada para identificar este valor foi a letra M.
- O **jogador atual** é representado como um inteiro e na notação usada representamos esta variável com a letra P.
- O **tamanho do tabuleiro** é representado como um inteiro e na notação usada representamo-lo com a letra O.
- A informação relativa a se o jogo ainda está a decorrer ou se já houve um vencedor é aferida no início de cada turno pela função checkBeforeTurn(P,B), que retorna um resultado afirmativo caso o jogador P ainda esteja em jogo no tabuleiro B ou negativo caso ele tenha sido derrotado.
### Visualização do Estado de Jogo
- Todas as funções relativas à visualização do estado de jogo, quer durante a partida quer antes estão no ficheiro display.pl.
- A função principal para exibição do tabuleiro é, como descrito no enunciado, a função display_game, que recebe como argumentos os valores referentes ao tabuleiro atual, ao modo de jogo que está a ser jogado e vai atualizando o estado do jogo mediante inputs do(s) jogador(es) e o resultado das funções de verificação chamadas dentro dela, que fazem todo o processo que envolve o decorrer de um turno.
