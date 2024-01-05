defmodule ChatGptClient do
  # este módulo utiliza o HTTPoison para fazer requests http
  # documentação disponível em https://hexdocs.pm/httpoison/readme.html
  # essa notação é para importar apenas o Response do HTTPoison
  alias HTTPoison.{Response}
  # vamos usar FileCrud
  alias FileCRUD

  # define uma variavel de módulo para a url da api
  @api_url "https://api.openai.com/v1/completions"
  # define uma variavel de módulo para chave, por segurança a chave foi definida em uma váriável de ambiente no meu sistema
  # usuários linux devem usar export CHATGPT_API_KEY="sua chave" em ~/.bashrc
  # usuários windows devem usar [Environment]::SetEnvironmentVariable("CHATGPT_API_KEY", "SUA_CHAVE_DE_API_AQUI", "User") no powershell
  @api_key System.get_env("CHATGPT_API_KEY") || "DEFAULT_VALUE"

  # define uma função para fazer requests para a api
  # \\ é usado para definir um valor padrão para o parâmetro
  def montar_request(prompt) do
    # define os cabeçalhos da requisição
    headers = [
      {"Content-type", "application/json"},
      {"Authorization", "Bearer #{@api_key}"}
    ]

    # define o corpo da requisição
    # %{chave: valor} é a notação para mapas em elixir, um mapa é uma estrutura de dados que associa chaves a valores, igual a um dicionário em python ou um objeto em javascript
    body = %{
      # model é o modelo que a api deve usar para gerar o texto, no caso, o modelo davinci-002 é o modelo mais avançado da openai
      model: "gpt-3.5-turbo-instruct",
      # prompt é o texto que será enviado para a api
      prompt: "Escreva um artigo com começo meio e fim sobre " <> prompt <> " formatado em markdown",
      # max_tokens é o número máximo de tokens que a api pode retornar
      max_tokens: 1000,
      # temperature é um parâmetro que controla a aleatoriedade das respostas, quanto maior o valor, mais aleatórias as respostas
      # minimo de 0.0 e máximo de 1.0
      temperature: 0.3,
      # top_p é um parâmetro que controla a aleatoriedade das respostas, quanto maior o valor, mais aleatórias as respostas
      top_p: 1,
      # n é o número de respostas que a api deve retornar
      n: 1,
      # frequency_penalty é um parâmetro que controla a repetição de palavras, quanto maior o valor, menos repetição
      # minimo de 0.0 e máximo de 1.0
      frequency_penalty: 0.5,
      # presence_penalty é um parâmetro que controla a repetição de frases, quanto maior o valor, menos repetição
      # minimo de 0.0 e máximo de 1.0
      presence_penalty: 0.5,
    }

    # finalmente, faz a requisição para a api
    enviar_request(@api_url, headers, body, prompt)
  end

  # define uma função privada que envia a requisição para a api
  defp enviar_request(url, headers, body, prompt) do
    options = [timeout: 10_000, recv_timeout: 15_000]
    # a função request é definida no módulo HTTPoison.Base
    # ela recebe a url, os cabeçalhos e o corpo da requisição
    # ela retorna um struct do tipo HTTPoison.Response
    # um struct é uma estrutura de dados que contém campos com valores parecido com um objeto em javascript
    case HTTPoison.post(url, Poison.encode!(body), headers, options) do
      # se a requisição for bem sucedida, retorna o struct
      # %Response{status_code: 200, body: body} é a notação para um struct em elixir
      # o % é usado para definir um struct, Response é o nome do struct, status_code e body são os campos do struct
      # esse struct faz parte do módulo HTTPoison
      # -> é usado para retornar um valor, é equivalente ao return em outras linguagens
      # {} -> {} é usado para definir uma tupla, uma tupla é uma estrutura de dados que contém valores, igual a uma lista em python ou um array em javascript
      {:ok, %Response{status_code: 200, body: body}} ->
        {:ok, body, prompt}

      # se a requisição falhar, retorna um erro
      {:ok, %HTTPoison.Response{status_code: status, body: body}} ->
        {:error, "Erro #{status} ao fazer request para a api: #{body}"}

      # trata os erros
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, "Erro ao fazer request para a api: #{reason}"}

      _ ->
        {:error, "Erro desconhecido ao fazer request para a api"}
    end
  end
end
