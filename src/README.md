# PFL_TP2_T08_Wana_5
Este projeto consistiu na implementação do jogo de tabuleiro Wana em Prolog. O projeto foi realizado por:
- Mariana Lima Teixeira, up
- Pedro Manuel Costa Aguiar Botelho Gomes, up202006086

Ambos os elementos contribuíram igualmente para o desenvolvimento do projeto, pelo que concordamos que a contribuição atribuída a cada elemento deve ser 50%.

## Conteúdos
- [Instalação e Execução](#instruções-de-execução)

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
- [Site da BoardGameGeek, com resumo das regras]https://boardgamegeek.com/boardgame/364012/wana
