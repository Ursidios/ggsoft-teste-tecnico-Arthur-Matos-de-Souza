# O desafio

Você recebeu `assets/character/personagem_base.png`: um personagem parado,
numa imagem só, sem nenhum corte. `Source/Main.hx` apenas carrega e exibe
essa imagem — nada mais.

**Sua tarefa:** transformar esse personagem estático numa animação de
**IDLE em LOOP** (a pose de "parado, respirando/balançando", que um
personagem de jogo fica repetindo enquanto espera o jogador fazer algo),
usando a técnica de **bone + malha (skinning)** — não frame-by-frame.

Isso significa, na prática:

1. **Recortar** a imagem em partes (cabeça, tronco, braço esquerdo, braço
   direito, perna esquerda, perna direita — pelo menos essas).
2. Montar uma **hierarquia de bones** (ossos): cada parte é filha de outra
   num esqueleto (ex.: mão → antebraço → braço → tronco), de forma que
   girar/mover um osso pai arrasta os filhos junto — é isso que dá o efeito
   orgânico do idle, e não um sprite-sheet com frames prontos.
3. Fazer esse esqueleto tocar uma animação simples (respiração, leve
   balanço) **em loop contínuo**.
4. (Opcional, mas ideal) usar **malha (mesh/skinning)** de verdade — não só
   rotação de retângulos rígidos — pra deformar as partes de forma mais
   suave nas juntas.

## Duas formas válidas de resolver

Você pode escolher qualquer uma das duas (ou outra, se souber justificar):

### A. Na mão, só com `openfl.display` (baseline, sem diferencial)

Cortar a imagem original em `BitmapData` menores (`BitmapData.copyPixels`
ou já exportando as partes separadas de um editor de imagem), colocar cada
pedaço num `Sprite`/`Bitmap`, e montar a hierarquia manualmente com
`addChild` aninhado (cada "osso" é um `Sprite` pai de outro). Animar
girando/transladando esses `Sprite`s ao longo do tempo — reaproveite o
padrão de `haxe.Timer` + delta-time que já está em `Main.hx`
(`onDemoTick`), é o mesmo usado em produção neste projeto. Não tem malha
de verdade aqui (as partes continuam rígidas), só a hierarquia de bones.

### B. Com Spine — DIFERENCIAL

Se você tiver (ou instalar) o [Spine](http://esotericsoftware.com/), pode
riggar o personagem lá de verdade: recortar as partes, montar o esqueleto
com bones, pintar a malha (mesh/skinning) pra deformação suave, criar a
animação "idle" em loop, e exportar (atlas + JSON). Pra carregar isso no
projeto, descomente a linha do `spine-hx` no `project.xml` — é a mesma
biblioteca de runtime Spine que a GGSoft usa em produção (puro
`spine-hx`, sem `openfl-spine`/`zygameui`). Como carregar um skeleton
Spine com essa lib é algo que você pesquisa/resolve — não tem exemplo
pronto neste pack de propósito.

Usar Spine (opção B) conta como diferencial na avaliação. A opção A
sozinha já atende ao requisito mínimo do teste.

## Outro diferencial: interface/botões ao redor da animação

O mínimo do teste é só o personagem animando sozinho na tela. Como
diferencial extra (não obrigatório), você pode montar uma pequena
**interface** ao redor — por exemplo, um botão (ou mais de um) que
inicia/pausa a animação, ou que troca entre o idle e alguma outra pose
que você tenha criado. Não precisa ser bonito nem seguir nenhum design
específico — o que conta aqui é mostrar que você sabe estruturar código
de UI (um `Sprite`/`Shape` clicável, `MouseEvent.CLICK`, estado do que
está tocando) de forma organizada, separado da lógica da animação em si.

## O que NÃO precisa

- Não precisa de física, colisão, input do jogador, nem nada de
  gameplay — só a animação de idle rodando em loop, sozinha na tela.

## Use o personagem que te demos

Use `assets/character/personagem_base.png` como base — não troque por
outro personagem/desenho seu. A criatividade que queremos ver aqui é na
**técnica** (como você recorta, articula e anima essa imagem específica),
não no design do personagem em si.

## Palavras-chave para pesquisar

Se algum termo acima não for familiar, pesquisar por estes conceitos deve
te levar direto ao caminho certo — na ordem que costuma fazer mais
sentido estudar:

**Conceito (independente de ferramenta/engine):**
- `skeletal animation` / `animação esquelética`
- `2D bone rigging`
- `bone hierarchy` / `parent-child bone` (osso pai arrastando osso filho)
- `sprite cutting` / `recorte de sprite em partes`
- `mesh deformation` / `skinning` (a malha "colando" na pele/textura)
- `inverse kinematics (IK)` (opcional, avançado — não é obrigatório aqui)
- `idle animation` / `breathing animation loop`
- `easing` / `sine wave animation` (pro balanço ficar suave, não linear)

**Se for pelo caminho "na mão" (opção A), específico de OpenFL/Haxe:**
- `openfl BitmapData copyPixels` (recortar regiões de uma imagem)
- `openfl nested DisplayObjectContainer` / `addChild` aninhado (como
  simular hierarquia de bones com Sprites pai/filho)
- `openfl Sprite rotation pivot` / `registration point` (girar uma parte
  a partir do ponto certo — o "ombro", não o centro do braço)
- `haxe.Timer delta time animation` (o mesmo padrão já usado em
  `Main.hx`/`onDemoTick`)

**Se for pelo caminho Spine (opção B, diferencial):**
- `Spine 2D bones and slots`
- `Spine mesh / weighted mesh (skinning)`
- `Spine animation timeline loop`
- `spine-hx haxelib` (o runtime Haxe que a GGSoft usa em produção)

**Se for fazer o diferencial de interface/botão:**
- `openfl MouseEvent.CLICK`
- `openfl buttonMode` / `openfl Sprite as button`
- `openfl.display.Shape` vs `Sprite` (quando usar cada um pra um botão simples)
- `state machine simples` (pra controlar "tocando" vs "pausado" sem gambiarra)

## Referências públicas

Material oficial/público pra estudar, sem precisar ficar só pesquisando
por palavra-chave solta:

**Fundamentos de animação (vale pra qualquer opção, A ou B):**
- [12 Princípios da Animação — Alan Becker](https://www.youtube.com/watch?v=uDqjIdI4bF4)
  (a base de squash/stretch/easing que faz um idle parecer vivo, não robótico)
- [Guia de Easing & Curvas de Animação](https://youtu.be/n0pYHWcEEW8)

**Spine (documentação oficial, se for pela opção B):**
- [Site oficial (PT)](https://pt.esotericsoftware.com/)
- [Guia de usuário oficial (PT)](https://pt.esotericsoftware.com/spine-user-guide)
- [Spine 2D — rigging, malha e pesos passo a passo](https://www.youtube.com/watch?v=nzyGBx1vVBg)
- [Documentação de Runtimes (integração com engines)](https://pt.esotericsoftware.com/spine-runtimes)

**Integração Spine + Haxe, especificamente:**
- [Runtime oficial spine-haxe (GitHub)](https://github.com/EsotericSoftware/spine-runtimes/tree/4.2/spine-haxe)
  — não é o `spine-hx` que este pack usa (que é comunitário), mas é uma
  referência oficial de como o protocolo Spine mapeia pra Haxe.
- [HaxeFlixel + Spine — guia de integração](https://haxeflixel.com/documentation/spine/)
  — outra engine Haxe, mas o conceito de carregar atlas+skeleton+animação
  é o mesmo.
