# este módulo é responsável por iniciar o supervisor e os workers
# o supervisor é o responsável por iniciar os workers e reiniciá-los caso eles falhem
# um worker é uma tarefa que é executada em paralelo com o resto do programa
defmodule FileManagerAiTaskSupervisor do
  use Supervisor
  alias FileCRUD
  alias FileManagerAi

  # primeiro definimos uma função para iniciar o supervisor
  def start_link do
    # iniciamos o supervisor com o módulo atual e uma lista vazia de argumentos
    Supervisor.start_link(__MODULE__, [])
  end

  # depois definimos uma função para iniciar os workers
  def init(_) do
    # aqui definimos uma lista de workers
    # cada worker é um mapa com dois campos: id e start
    # o id é um identificador único para o worker
    # o start é uma função que inicia o worker
    children = [
      %{
        id: :chat_gpt_task,
        start: {Task, :start_link, [fn -> chamar_openai() end]}
      },
      %{
        id: :bing_images_task,
        start: {Task, :start_link, [fn -> chamar_bing() end]}
      },
      %{
        id: :articuloso_task,
        start: {Task, :start_link, [fn -> chamar_articuloso() end]}
      },
      %{
        id: :pandoc_task,
        start: {Task, :start_link, [fn -> chamar_pandoc() end]}
      }
    ]

    # aqui iniciamos o supervisor com a lista de workers e a estratégia de reinicialização
    # a estratégia de reinicialização define como o supervisor deve reiniciar os workers caso eles falhem
    Supervisor.init(children, strategy: :one_for_one)
  end

  # aqui definimos a função que será executada pelo worker
  # esta função chama a api da openai e retorna o resultado
  def chamar_openai do
    prompt = IO.gets("Digite o tema do seu artigo: ") |> String.trim()
    task = Task.async(fn -> ChatGptClient.montar_request(prompt) end)

    case Task.await(task, 10000) do
      # se a tarefa for bem sucedida, imprimo o resultado
      {:ok, result, prompt} ->
        IO.puts(result)

        {_, list} = JSON.decode(result)

        [cabeca | _] = list["choices"]

        {_, texto} = Map.fetch(cabeca, "text")

        pasta = FileCRUD.crie_pasta(prompt)

        FileCRUD.salve_na_pasta(pasta, prompt, texto)
    end
  end

  def chamar_bing do
    # exibe apenas os diretorios dentro de @path
    FileManagerAi.lista_informativa()
    prompt = IO.gets("Escolha o nome do artigo: ") |> String.trim()
    # enquanto nao digitar um nome de pasta valido, pede para digitar novamente ou sair
    if !FileCRUD.existe_pasta?(prompt) do
      IO.puts("Este não é um artigo válido")
      FileManagerAi.display_menu()
    end

    task = Task.async(fn -> BingImagesClient.montar_request(prompt) end)

    case Task.await(task, 10000) do
      # se a tarefa for bem sucedida, imprimo o resultado
      {:ok, result, artigo} ->
        IO.puts("Resposta da API recebida")
        {_, list} = JSON.decode(result)

        #itera sobre a lista de resultados e salva cada um na pasta
        Enum.each(list["value"], fn item ->
          #url da imagem
          {_, url} = Map.fetch(item, "thumbnailUrl")
          #nome da imagem
          {_, nome} = Map.fetch(item, "name")
          FileCRUD.baixar_imagem(artigo, url, nome)
        end)

        # [cabeca | _] = list["value"]

        # IO.inspect(cabeca)
        # {_, texto} = Map.fetch(cabeca, "text")

        # pasta = FileCRUD.crie_pasta(prompt)

        # FileCRUD.salve_na_pasta(pasta, prompt, texto)
    end
  end



  #chama a função une_imagens_ao_artigo do módulo Articuloso
  def chamar_articuloso do
    FileManagerAi.lista_informativa()
    artigo = IO.gets("Digite o nome do artigo que deseja adicionar fotos: ") |> String.trim()
    #se o artigo for um diretorio continua
    if FileCRUD.existe_pasta?(artigo) do
      #chama a função une_imagens_ao_artigo do módulo Articuloso de forma assincrona
      task = Task.async(fn -> Articuloso.une_imagens_ao_artigo(artigo) end)
      #espera a tarefa terminar
      Task.await(task, 10000)
      IO.puts("Imagens adicionadas ao artigo com sucesso!")
    else
      IO.puts("Artigo não encontrado")
    end
  end

  #chama a funcao de criar pagina do pandoc
  def chamar_pandoc do
    FileManagerAi.lista_informativa()
    artigo = IO.gets("Digite o nome do artigo que deseja criar a página: ") |> String.trim()
    #se o artigo for um diretorio continua
    if FileCRUD.existe_pasta?(artigo) do
      #chama a função une_imagens_ao_artigo do módulo Articuloso de forma assincrona
      task = Task.async(fn -> PandocClient.cria_html(artigo) end)
      #espera a tarefa terminar
      Task.await(task, 10000)
      IO.puts("Página criada com sucesso!")
    else
      IO.puts("Artigo não encontrado")
    end
  end
end
