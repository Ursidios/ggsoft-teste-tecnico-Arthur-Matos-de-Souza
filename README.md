# ggsoft-teste-tecnico-Arthur-Matos-de-Souza

## Sobre o projeto

Inicialmente, segui o caminho utilizando o Spine. Separei as partes do personagem, desenvolvi a malha (*mesh/skinning*), o *rigging*, os pesos dos ossos e as animações que seriam utilizadas. No entanto, a versão Trial não permitia exportar o projeto. Uma breve demonstração do trabalho realizado no Spine será enviada junto com o teste.

Por esse motivo, optei por desenvolver todos esses processos utilizando OpenFL. O resultado é um projeto com *rigging* de malha (*mesh/skinning*) com hierarquia, deformação de malha com influência múltipla de ossos, três animações, uma interação adicional e uma interface para testar todos esses recursos.

### Conteúdo

- Animação *Idle* em loop automático.
- Animação *Hand Wave* acionada por interação.
- Animação de piscar os olhos, automática e acionada por interação.
- Animação procedural dos olhos, acompanhando o movimento do mouse.
- Botão de *Play/Pause* das animações.
- Botão *Debug View* para analisar o movimento dos ossos em tempo real.

Você pode experimentá-lo diretamente pelo [link da aplicação](https://ursidios.github.io/ggsoft-teste-tecnico-Arthur-Matos-de-Souza/), sem precisar baixar o projeto nem executar os passos a seguir.

## Pré-requisitos

- Haxe instalado e disponível no PATH.
- Haxelib configurado.
- Bibliotecas `lime` e `openfl` instaladas.
- Python instalado, caso queira executar o build HTML5 por meio de um servidor local.

Confira a instalação no terminal:

```text
haxe -version
haxelib version
```

## Instalação das dependências

Execute os comandos abaixo na pasta raiz do projeto:

```text
haxelib setup
haxelib install lime
haxelib install openfl
haxelib run lime setup
```

O comando `haxelib setup` só precisa ser executado na primeira configuração do Haxelib.

## Como compilar

### HTML5

1. Abra um terminal na raiz do projeto.
2. Execute:

```text
lime build html5
```

O resultado será gerado em `Export/html5/bin/`, incluindo o arquivo `index.html`.

Em ambientes que possuem `make`, o mesmo processo pode ser executado com:

```text
make html
```

## Como executar localmente

### Opção 1: compilar e abrir automaticamente

Na raiz do projeto, execute:

```text
lime test html5
```

Esse comando compila o projeto e abre a aplicação no navegador padrão.

Com `make` instalado, o equivalente é:

```text
make run
```

### Opção 2: iniciar um servidor local manualmente

Depois de compilar o projeto com `lime build html5`, execute:

```text
python -m http.server 8000 --directory Export/html5/bin
```

Abra `http://localhost:8000` no navegador.

Não abra o `index.html` diretamente pelo Explorer. Nesse caso, o navegador usa o protocolo `file://` e pode bloquear o carregamento do manifesto e dos assets utilizados pelo runtime Lime/OpenFL.

