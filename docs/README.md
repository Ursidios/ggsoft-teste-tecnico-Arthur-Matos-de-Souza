# GGSoft — Teste Técnico: Animação de Personagem (Haxe/OpenFL)

Teste técnico simples para avaliar sua capacidade de pegar uma imagem
estática, recortá-la e transformá-la numa **animação de IDLE em loop**
usando a técnica de **bone + malha (skinning)** — a mesma abordagem usada
em jogos de verdade (inclusive os nossos).

**Leia o [ENUNCIADO.md](ENUNCIADO.md) primeiro** — é lá que está o
enunciado completo do desafio (objetivo, o que entregar, diferenciais,
critérios de avaliação). Detalhe técnico de como abordar a animação, com
palavras-chave pra estudo, está em
[docs/TECNICA_ANIMACAO.md](docs/TECNICA_ANIMACAO.md). Este README aqui é
só sobre **como preparar o ambiente, compilar e entregar**.

## O que você recebe neste pack

- Um projeto Haxe/OpenFL que já compila (`make html`) e mostra, na tela,
  o personagem estático parado + um exemplo simples e solto de animação
  por tempo (não relacionado ao desafio — só ilustra o padrão de código).
- `assets/character/personagem_base.png` — o material bruto pra você
  recortar.
- Nada mais está pronto. O recorte, o esqueleto de bones, a malha e a
  animação de idle são o que você precisa construir.

## Pré-requisitos

| Ferramenta | Para quê | Link |
|---|---|---|
| **Haxe** (compilador, 4.x) | compilar o projeto | https://haxe.org/download/ |
| **haxelib** | vem junto com o Haxe | — |
| **Lime** + **OpenFL** (haxelibs) | runtime/build do jogo | instalado via `haxelib` (passo abaixo) |
| Editor de código (recomendado: VS Code + extensão Haxe) | escrever o código | https://code.visualstudio.com/ |
| Editor de imagem (o que você já usa) | recortar `personagem_base.png` em partes | — |
| **Spine** (opcional — só se for pelo caminho do diferencial) | riggar bone+malha "de verdade" | http://esotericsoftware.com/ (tem trial) |

Não precisa instalar nada de C++/hxcpp/Visual Studio — a entrega é em
**HTML5**, que não depende de compilador nativo.

## Passo a passo para compilar e abrir o projeto

Os comandos `haxe`/`haxelib`/`lime` são **os mesmos em Windows e macOS** —
só a instalação do Haxe em si muda. Rode tudo num terminal (Windows:
PowerShell ou Prompt de Comando; macOS: Terminal.app).

### 1. Instale o Haxe

**Windows:**
1. Baixe o instalador em https://haxe.org/download/ (arquivo `.exe`,
   ex.: `HaxeSetup-4.x.x.exe`) e execute.
2. Deixe marcada a opção de adicionar ao PATH (vem marcada por padrão).
3. **Feche e abra um terminal novo** (o PATH só atualiza em janelas
   abertas depois da instalação).

**macOS:**
- Opção mais simples, se você já usa [Homebrew](https://brew.sh/):
  ```bash
  brew install haxe
  ```
- Ou baixe o instalador `.pkg` direto em https://haxe.org/download/.

**Confirme (nos dois sistemas):**
```bash
haxe -version
haxelib -version
```

### 2. Configure o haxelib e instale as libs do projeto

```bash
haxelib setup          # só na 1ª vez — aceite o caminho padrão sugerido (Enter)
haxelib install lime
haxelib install openfl
haxelib run lime setup # só na 1ª vez — configura o Lime na máquina
```

### 3. Compile para HTML5

Este pack tem um `Makefile` de atalho, mas **`make` não é obrigatório** —
no Windows puro (sem Git Bash/WSL/chocolatey) ele normalmente não existe,
então use os comandos do `lime` direto:

```bash
# com make (macOS já vem com make; Windows só se tiver instalado):
make html   # compila -> Export/html5/bin
make run    # compila e já abre no navegador

# sem make (funciona igual em Windows e macOS):
lime build html5
lime test html5
```

O build compilado fica em `Export/html5/bin/` — é essa pasta (com o
`index.html` dentro) que faz o jogo rodar sem precisar recompilar nada.

### Deu erro?

- `'haxe' não é reconhecido` / `command not found: haxe` → feche e abra o
  terminal de novo depois de instalar (o PATH não atualiza sozinho numa
  janela já aberta).
- `Before doing anything else, run haxelib setup` → rode `haxelib setup`
  (passo 2) e aceite o caminho padrão.
- `make: command not found` (comum em Windows) → ignore o `Makefile` e
  use os comandos `lime build html5` / `lime test html5` direto (passo 3).

### Testando localmente em desktop nativo (opcional)

Se quiser rodar como app nativo enquanto desenvolve (não é obrigatório):

```bash
make windows   # gera Export/windows/bin/*.exe (exige toolchain C++/hxcpp)
make macos     # gera Export/macos/bin/*.app (exige Xcode command line tools)
```

## O que entregar e como isso é avaliado

Ver [ENUNCIADO.md](ENUNCIADO.md) — seções "Como entregar" e "Critérios de
avaliação". Resumo rápido:

- Repositório público pessoal `ggsoft-teste-tecnico-<seu-nome>`, com
  código-fonte **e** o build HTML5 compilado (`Export/html5/bin/` — o
  `.gitignore` deste pack já deixa essa pasta fora do ignore de
  propósito, pra ela poder ser versionada).
- Obrigatório: idle em loop via recorte + hierarquia de bones.
- **Diferenciais** (somam pontos, não eliminam ninguém): malha/skinning
  de verdade, resolver via **Spine**, e montar uma pequena
  **interface/botão** ao redor da animação (ex.: play/pause).
