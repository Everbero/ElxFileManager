# FileManager

![GitHub](https://img.shields.io/github/license/everbero/ElxFileManager)
![GitHub repo size](https://img.shields.io/github/repo-size/everbero/ElxFileManager)
![GitHub last commit](https://img.shields.io/github/last-commit/everbero/ElxFileManager)

FileManager é um programa desenvolvido em Elixir, criado exclusivamente para avaliação no curso de sistemas distribuídos.

## Pré-requisitos

Certifique-se de ter Elixir instalado. Se não tiver, você pode baixá-lo e instalá-lo em: [Elixir](https://elixir-lang.org/install.html)

Este projeto usar Rebar porque tem um ploblema com o HTTP_Poison que só resolve usando Rebar, uma gambiarra medonha que me custou horas de sono.
Você TEM QUE instalar o pandoc se não estiver no seu sistema.

Este projeto usa as API's do chatGPT e do Bing Image Search
Ambas as variáveis devem ser exportadas em ~/.bashrc e se você usa windows, se vira

## O que este projeto faz

Cria uma pasta no seus documentos chamada encantos
Você pode usar o menu para criar arquivos, as funções de 1 a 6 são apenas para isso
As funções de 7 a 10 são tasks distribuíveis
A função 7 cria um diretório com um artigo gerado pelo chatGPT
A função 8 baixa imagens do bing nesse diretório
A função 9 une o artigo e as imagens em um arquivo de markdown
A função 10 gera uma página HTML à partir do markdown usando pandocs

## Executando o programa

1. Clone o repositório:

```bash
$ git clone https://github.com/everbero/FileManager.git
$ cd FileManager
```
2. Instale as dependências:

```bash
$ sudo apt install pandoc
```

```bash
$ sudo apt install rebar
```

```bash
$ mix deps.get
```

3. Execute o programa:

```bash
$ iex -S mix
```

4. Acesse a funcao principal para ver o menu

```bash
iex> FileManagerAi.start
```

Escolha uma das opções e divirta-se
## Funcionalidades

- Criar arquivos de texto no sistema.
- Ler o conteúdo de arquivos existentes.
- Renomear arquivos.
- Apagar arquivos.
- Listar arquivos

## Contribuindo

Se você deseja contribuir, abra uma issue ou envie um pull request. Ficarei feliz em analisar suas contribuições!

## Licença

Este projeto está licenciado sob a Licença MIT - consulte o arquivo [LICENSE.md](LICENSE.md) para obter detalhes.

## Instalando

Se [disponível no Hex](https://hex.pm/docs/publish), o pacote pode ser instalado
adicionando `file_manager` à sua lista de dependências no arquivo `mix.exs`:

```elixir
def deps do
  [
    {:file_manager_ai, "~> 0.1.0"}
  ]
end
```

A documentação pode ser gerada com [ExDoc](https://github.com/elixir-lang/ex_doc)
e publicada no [HexDocs](https://hexdocs.pm). Uma vez publicada, a documentação
pode ser encontrada em [https://hexdocs.pm/file_manager](https://hexdocs.pm/file_manager).

### Sobre o elixir
Elixir é uma linguagem que pode ter uma curva de aprendizado desafiadora para alguns. Ela possui uma abordagem diferente, não utiliza a notação de ponto (dot notation) e não possui estruturas de controle como o 'while'. Para alguns programadores, a ausência desses elementos pode tornar a linguagem menos intuitiva. A documentação também pode ser extensa, o que pode demandar um esforço adicional para compreendê-la completamente. Cada um tem suas preferências e, se Elixir não se alinha com seu estilo de programação ou necessidades específicas, pode ser mais adequado explorar outras linguagens para seus projetos futuros.

<img src="https://media1.tenor.com/m/FatatgEM2FYAAAAC/crying-pepe.gif" alt="drawing" width="200"/>
