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
  - [Execução de Jogadas](#execução-de-jogadas)
  - [Lista de Jogadas Válidas](#lista-de-jogadas-válidas)
  - [Final do Jogo](#final-do-jogo)
  - [Avaliação do Tabuleiro](#avaliação-do-tabuleiro)
  - [Jogada do Computador](#jogada-do-computador)
- [Conclusões](#conclusões)
- [Bibliografia](#bibliografia)

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
- O **tamanho do tabuleiro** é representado como um inteiro e na notação usada representamo-lo com a letra O. Pode ter os valores 1, 2 ou 3, com o espaçamento entre casas no tabuleiro sendo maior quanto maior for o valor escolhido pelo utilizador. No menu, é possível previsualizar como cada tabuleiro fica antes de escolher.
- A informação relativa a se o jogo ainda está a decorrer ou se já houve um vencedor é aferida no início de cada turno pela função checkBeforeTurn(P,B), que retorna um resultado afirmativo caso o jogador P ainda esteja em jogo no tabuleiro B ou negativo caso ele tenha sido derrotado.
### Visualização do Estado de Jogo
- Todas as funções relativas à visualização do estado de jogo, quer durante a partida quer antes estão no ficheiro display.pl.
- A função principal para exibição do tabuleiro é, como descrito no enunciado, o predicado display_game, que recebe como argumentos os valores referentes ao tabuleiro atual, ao modo de jogo que está a ser jogado e vai atualizando o estado do jogo mediante inputs do(s) jogador(es) e o resultado das funções de verificação chamadas dentro dela, que fazem todo o processo que envolve o decorrer de um turno.
Temos também, como sugerido no enunciado, um predicado initial_state que quando chamado devolve o tabuleiro no seu estado inicial para iniciar o jogo. As restantes variáveis descritas acima referentes ao estado do jogo são obtidas através dos inputs do utilizador no menu.
### Execução de Jogadas
- As funções usadas para validação das jogadas estão no ficheiro analyze.pl.
- O processo de obtenção do input de jogada, validação e execução da mesma fica a cargo do predicado move. Este predicado recebe o tabuleiro atual, o seu tamanho de representação e o jogador que está neste momento a jogar e devolve o tabuleiro com o movimento executado. As coordenadas da peça a mover e do seu destino são então fornecidas pelo utilizador durante a execução da função. Se em algum ponto o jogador indicar como coordenadas da peça uma casa vazia ou indicar como coordenadas de destino uma casa para a qual a peça não possa mover-se, o jogo irá notificá-lo disso, mostrar o tabuleiro novamente e solicitar um novo input.
### Lista de Jogadas Válidas
### Final do Jogo
Como explicado acima, as regras do Wana declaram que um jogador perde quando inicia o seu turno sem poder pelo menos uma das suas peças. Assim, ao invés de um predicado que analisa o tabuleiro atual e retorna um vencedor, implementamos esta verificação chamando um predicado game_over que recebe o tabuleiro e o jogador que vai iniciar o turno naquele momento, verificando se esse jogador perdeu ou se ainda está em jogo. Caso tenha alguma peça presa, o seu turno não começa e em vez disso o tabuleiro é mostrado uma última vez, junto com uma mensagem a parabenizar o vencedor.
### Avaliação do Jogo
### Jogada do Computador
## Conclusões
## Bibliografia
