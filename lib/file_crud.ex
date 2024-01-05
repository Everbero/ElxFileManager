# Este módulo usa File https://hexdocs.pm/elixir/1.13/File.html
# File é um módulo que fornece funções para manipular arquivos
# File já tem funções para criar, ler, atualizar e deletar arquivos
# File já tem tratamento de erros, então não precisamos nos preocupar com isso
# Porque reinventar a roda, né?

defmodule FileCRUD do
  alias RegexCleander
  # Obtém o caminho do diretório base dependendo do sistema operacional
  # Windows: C:\Users\username\Documents
  # Linux/macOS: /home/username
  # System.get_env("SYSTEM") obtém o nome do sistema operacional
  # @base_path é uma variável de módulo, que pode ser acessada por todas as funções do módulo
  # coloquei o () depois de case porque o compilador reclamou
  @base_path (case(System.get_env("SYSTEM")) do
                # Se for Windows, obtém o caminho do diretório base do usuário
                # Será que isso funciona em todas as versões do Windows? Não sei, eu uso Linux :P
                "Windows" ->
                  Path.join(System.get_env("HOMEDRIVE"), System.get_env("HOMEPATH"), "Documents")

                # Fallback para Linux/macOS, nem da pra chamar de fallback, já que a maioria dos devs usam Linux/macOS
                _ ->
                  System.get_env("HOME") || "/usr/local"
              end)

  # @path é uma variável de módulo, que pode ser acessada por todas as funções do módulo.
  # Path.join/2 concatena dois caminhos, por exemplo, poderia usar <> para concatenar strings,
  # mas Path.join/2 é mais seguro porque ele adiciona uma barra entre os dois caminhos
  # Path final onde os arquivos serão salvos
  @path Path.join(@base_path, "encantos/")

  def init do
    # botei uma acento pra confundir o compilador
    cria_a_pasta_se_não_existir()
  end

  # vamos criar o diretório caso ele não exista, desde que o usuário tenha as permissões necessárias ¯\_(ツ)_/¯
  # init é uma função especial que é executada quando o módulo é carregado
  # defp cria uma função privada :0
  defp cria_a_pasta_se_não_existir do
    # unless é uma estrutura de controle que executa o bloco de código se a condição for falsa
    # o ? serve para verificações booleanas, por exemplo, File.dir?(@path) retorna true se o caminho for um diretório
    unless File.dir?(@path) do
      File.mkdir!(@path)
    end
  end

  # Função para criar um novo arquivo com o nome e conteúdo fornecidos
  def crie(filename, content) do
    # limpa o nome do arquivo
    nome_com_extensao = RegexCleander.limpar(filename, "arquivo")
    # Cria o arquivo
    File.write!(Path.join(@path, nome_com_extensao), content)
  end

  # Função para ler o conteúdo de um arquivo com o nome fornecido
  def leia(filename) do
    File.read!(Path.join(@path, filename))
    # exibir o menu depois de ler o arquivo
  end

  # Função para atualizar o conteúdo de um arquivo existente com o novo conteúdo fornecido
  def atualize(filename, new_content) do
    File.write!(Path.join(@path, filename), new_content)
  end

  # Função para deletar um arquivo com o nome fornecido
  def apague(filename) do
    File.rm!(Path.join(@path, filename))
  end

  # função para listar todos os arquivos no diretório
  def liste() do
    File.ls!(@path)
  end

  # função para renomear um arquivo
  def renomeie(filename, new_filename) do
    File.rename!(Path.join(@path, filename), Path.join(@path, new_filename))
  end

  #essas funções são utilizadas para criar pastas e salvar arquivos dentro delas
  #o módulo de chat usa isso para salvar os arquivos de conversa em pastas separadas
  #cria uma nova pasta
  def crie_pasta(nome_da_pasta) do
    nome_higienizado = RegexCleander.limpar(nome_da_pasta, "pasta")

    #verifica se a pasta já existe
    unless File.dir?(Path.join(@path, nome_higienizado)) do
      #se não existir, cria a pasta
      File.mkdir!(Path.join(@path, nome_higienizado))
    end
    #retorna o nome da pasta
    nome_higienizado
  end

  #salva um arquivo em uma pasta
  def salve_na_pasta(nome_da_pasta, filename, content) do
    nome_com_extensao = RegexCleander.limpar(filename, "arquivo")
    File.write!(Path.join(Path.join(@path, nome_da_pasta), nome_com_extensao), [content])
    #retorna o nome do arquivo
    nome_com_extensao
  end


  #bing helper functions
  #exibe apenas os diretorios dentro de @path
  def liste_diretorios() do
    File.ls!(@path)
  end

  #verifica se existe uma pasta com o nome fornecido
  def existe_pasta?(nome_da_pasta) do
    File.dir?(Path.join(@path, nome_da_pasta))
  end
end
