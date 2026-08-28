# Enunciado — Teste Técnico GGSoft: Animação de Personagem

## Objetivo

Avaliar sua capacidade de pegar um personagem **estático** e transformá-lo
numa **animação de IDLE em loop contínuo**, usando a técnica de **bone +
malha (skinning)** — a mesma abordagem usada em jogos 2D reais, inclusive
os nossos.

## Contexto

Idle é a animação que um personagem de jogo fica repetindo enquanto
espera (respirando, balançando levemente). Ela quase nunca é feita
quadro-a-quadro pronto (sprite-sheet) — é montada recortando o personagem
em partes e articulando essas partes por um esqueleto de **bones**
(ossos), opcionalmente com **malha (mesh/skinning)** pra deformação
suave nas juntas. É exatamente essa técnica que queremos ver você aplicar.

## O que você recebe

- `Source/Main.hx` — carrega e mostra `assets/character/personagem_base.png`
  parado na tela, e um exemplo solto de animação por tempo (não resolve
  nada do desafio, só ilustra o padrão de código do projeto).
- `assets/character/personagem_base.png` — o personagem que você deve
  usar como base (não troque por outro desenho/personagem seu — a
  criatividade avaliada aqui é na **técnica**, não no design).
- Um projeto Haxe/OpenFL que já compila do jeito que está (ver
  [README.md](README.md) para pré-requisitos e comandos).

## O que você precisa entregar (obrigatório)

1. **Recortar** `personagem_base.png` em partes (cabeça, tronco, braço
   esquerdo, braço direito, perna esquerda, perna direita — pelo menos
   essas).
2. Montar uma **hierarquia de bones**: cada parte articulada com a outra
   (ex.: braço preso ao ombro do tronco), de forma que mover/girar um osso
   pai arraste os filhos junto.
3. Fazer esse esqueleto tocar uma **animação de idle em loop contínuo**
   (sem parar sozinha, sem precisar de clique nenhum pra começar).

Detalhe técnico de como abordar isso — incluindo palavras-chave pra
pesquisar se algum conceito não for familiar — está em
[docs/TECNICA_ANIMACAO.md](docs/TECNICA_ANIMACAO.md).

## Diferenciais (pontuam a mais, não são obrigatórios)

- Usar **malha/skinning de verdade** (deformação suave nas juntas, não só
  partes rígidas rotacionando).
- Resolver via **Spine** (bones + mesh no editor, exportado e carregado
  via `spine-hx`) — é a stack que a GGSoft usa em oprdução.
- Montar uma pequena **interface** ao redor da animação (ex.: um botão de
  play/pause).

## Como entregar

1. Crie um repositório **novo, público, na sua conta pessoal do GitHub**,
   com o nome `ggsoft-teste-tecnico-<seu-nome>` (ex.:
   `ggsoft-teste-tecnico-joao-silva`).
2. Suba o código-fonte completo **e** o build HTML5 compilado
   (`Export/html5/bin/`), pra quem for avaliar abrir direto no navegador
   sem precisar compilar nada.
3. Escreva um parágrafo curto no README do seu repositório contando que
   caminho você seguiu.
4. Envie o link do repositório pra quem te passou este teste.

Passo a passo completo de instalação/compilação (Windows e macOS) está em
[README.md](README.md).

Esse é o formato ideal de entrega. Mas se em algum ponto você não
conseguir deixar exatamente nesse padrão (build HTML5 versionado, nome
do repositório, etc.), não trave por causa disso — envie do jeito que
conseguir organizar, com um comentário explicando o que faltou. O que
mais importa aqui é a gente conseguir ver o que você fez.

## Critérios de avaliação

- O personagem sai do estático e passa a ter idle **em loop contínuo**,
  via recorte + hierarquia de bones (não é frame-by-frame/sprite-sheet
  pronto).
- Projeto compila e roda a partir das instruções do seu próprio README,
  sem passo escondido.
- Organização do código conta tanto quanto o resultado visual.
- Diferenciais (malha/skinning, Spine, interface) somam pontos, não são
  eliminatórios.

## Dúvidas

Qualquer dúvida sobre o enunciado, pergunte a quem te enviou este teste
antes de começar a codar.
