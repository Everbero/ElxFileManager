  #     ______                __                   _
  #    / ____/   _____  _____/ /_  ___  _________ ( )_____
  #   / __/ | | / / _ \/ ___/ __ \/ _ \/ ___/ __ \|// ___/
  #  / /___ | |/ /  __/ /  / /_/ /  __/ /  / /_/ / (__  )
  # /_____/ |___/\___/_/  /_.___/\___/_/   \____/ /____/
  # Um sistema em elixir para gerenciamento de arquivos bem basicão
  #     _______ __     __  ___
  #    / ____(_) /__  /  |/  /___ _____  ____ _____ ____  _____
  #   / /_  / / / _ \/ /|_/ / __ `/ __ \/ __ `/ __ `/ _ \/ ___/
  #  / __/ / / /  __/ /  / / /_/ / / / / /_/ / /_/ /  __/ /
  # /_/   /_/_/\___/_/  /_/\__,_/_/ /_/\__,_/\__, /\___/_/
  #                                         /____/
defmodule FileManager do
  # iniciar o programa
  def start do
    # chama a função init do módulo FileCRUD pra garantir que a pasta existe
    FileCRUD.init()
    display_menu()
  end

  # nota para mim mesmo
  # IO.puts/1: É usado para imprimir um texto ou uma representação formatada de um valor no terminal, seguido de uma nova linha.
  # IO.gets/1: É usado para obter a entrada do usuário a partir do terminal. Ele aceita um argumento opcional, a mensagem de prompt.

  # funcao que exibe o texto do menu de opções
  def display_menu do
    IO.puts("‿--------------------------------------------------‿")
    # imprime boas vindas e breve explicação
    IO.puts("Bem vindo ao gerenciador de arquivos! Escolha uma opção: ")
    IO.puts("1. Criar um arquivo")
    IO.puts("2. Ler um arquivo")
    IO.puts("3. Renomear um arquivo")
    IO.puts("4. Atualizar um arquivo")
    IO.puts("5. Apagar um arquivo")
    IO.puts("6. Listar arquivos")
    # IO.puts("7. task")
    # IO.puts("8. task")
    # IO.puts("9. task")
    # IO.puts("10. task")
    IO.puts("0. Sair")
    IO.puts("⁀--------------------------------------------------⁀")
    handle_input()
  end

  # funcao que encerra o programa
  def adios do
    IO.puts("Saindo...")
    :ok
  end

  # menu com as opções
  def handle_input do
    case IO.gets("Opção: ") |> String.trim() do
      # aqui eu preferi usar o nome do módulo pq filecrud tem nomes iguais
      # C
      "1" -> criar_arquivo()
      # R
      "2" -> ler_arquivo()
      # U
      "3" -> renomear_arquivo()
      "4" -> atualizar_arquivo()
      # D
      "5" -> apagar_arquivo()
      # L
      "6" -> listar_arquivos()
      # aqui vou taskear de alguma forma, ainda não se o que fazer
      # "7" -> task()
      # "8" -> task()
      # "9" -> task()
      # "10" -> task()
      "0" -> adios()
      _ -> IO.puts("Opção inválida")
    end
  end

  # criar um arquivo
  def criar_arquivo do
    file_name = IO.gets("Digite o nome do novo arquivo: ") |> String.trim()
    # nice
    # pega o input |> pipe serve para passar o resultado de uma função para outra função (igual o | do bash)
    # > flecha serve para passar o resultado de uma função como argumento para outra função (parecido com o > do bash)
    file_content = IO.gets("Digite o conteúdo do arquivo "<> file_name <> ": ") |> String.trim()
    # chama a função create_file do módulo FileCRUD
    FileCRUD.crie(file_name, file_content)
    IO.puts("Arquivo criado com sucesso!")
    display_menu()
  end

  # ler um arquivo
  def ler_arquivo do
    lista_informativa()
    file_name = IO.gets("Digite o nome do arquivo que deseja ler: ") |> String.trim()
    IO.puts("Conteúdo do arquivo: ")
    IO.puts(FileCRUD.leia(file_name))
    display_menu()
  end

  # renomear um arquivo
  def renomear_arquivo do
    # exibir os arquivos antes é conveniente
    lista_informativa()
    file_name = IO.gets("Digite o nome do arquivo para renomear: ") |> String.trim()
    new_file_name = IO.gets("Digite o novo nome do arquivo: ") |> String.trim()
    FileCRUD.renomeie(file_name, new_file_name)
    IO.puts("Arquivo renomeado com sucesso!")
    display_menu()
  end

  # atualizar um arquivo
  def atualizar_arquivo do
    # exibir os arquivos antes é conveniente
    lista_informativa()
    file_name = IO.gets("Digite o nome do arquivo para atualizar: ") |> String.trim()
    new_file_content = IO.gets("Digite o novo conteúdo do arquivo: ") |> String.trim()
    FileCRUD.atualize(file_name, new_file_content)
    IO.puts("Arquivo atualizado com sucesso!")
    display_menu()
  end

  # apagar um arquivo
  def apagar_arquivo do
    # exibir os arquivos antes é conveniente
    lista_informativa()
    file_name = IO.gets("Digite o nome do arquivo que deseja apagar: ") |> String.trim()
    FileCRUD.apague(file_name)
    IO.puts("Arquivo apagado com sucesso!")
    display_menu()
  end

  # lista os arquivos
  def listar_arquivos do
    #imprime uma linha
    IO.puts("‿--------------------------------------------------‿")
    IO.puts("Arquivos no diretório: ")
    IO.inspect(FileCRUD.liste())
    IO.puts("⁀--------------------------------------------------⁀")
    display_menu()
  end

  # lista os arquivos sem fazer loop
  def lista_informativa do
    IO.puts("‿--------------------------------------------------‿")
    IO.puts("Arquivos no diretório: ")
    IO.inspect(FileCRUD.liste())
    IO.puts("⁀--------------------------------------------------⁀")
  end
end