# FileManager

![GitHub](https://img.shields.io/github/license/everbero/ElxFileManager)
![GitHub repo size](https://img.shields.io/github/repo-size/everbero/ElxFileManager)
![GitHub last commit](https://img.shields.io/github/last-commit/everbero/ElxFileManager)

FileManager é um programa desenvolvido em Elixir, criado exclusivamente para avaliação no curso de sistemas distribuídos.

## Pré-requisitos

Certifique-se de ter Elixir instalado. Se não tiver, você pode baixá-lo e instalá-lo em: [Elixir](https://elixir-lang.org/install.html)

## Executando o programa

1. Clone o repositório:

```bash
git clone https://github.com/everbero/FileManager.git
cd FileManager
```

2. Execute o programa:

```bash
iex -S mix
```

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
    {:file_manager, "~> 0.1.0"}
  ]
end
```

A documentação pode ser gerada com [ExDoc](https://github.com/elixir-lang/ex_doc)
e publicada no [HexDocs](https://hexdocs.pm). Uma vez publicada, a documentação
pode ser encontrada em [https://hexdocs.pm/file_manager](https://hexdocs.pm/file_manager).