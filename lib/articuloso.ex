defmodule Articuloso do
  # monta uma matéria adicionando fotos ao artigo
  def une_imagens_ao_artigo(artigo) do
    # pega a lista de imagens no diretorio do artigo
    imagens = FileCRUD.lista_arquivos_no_diretorio(artigo)
    FileCRUD.cria_md(artigo)
    # pega a lista de imagens no diretorio do artigo e adiciona no começo do arquivo homonimo
    for imagem <- imagens do
      # conteudo_da_imagem = FileCRUD.leia(nome_da_imagem)
      # adiciona o conteudo da imagem no começo do arquivo
      # verifica se o arquivo é uma imagem terminada em jpg
      if String.ends_with?(imagem, ".jpg") do
        # pega o nome da imagem
        path_imagem = Path.basename(imagem)
        imagem_sem_extensao = RegexCleaner.limpar(imagem, "diretorio")
        # pega o path da imagem e converte em notação de markdown.md
        # exemplo: ![alt text for screen readers](/path/to/image.png "Text to show on mouseover")
        conteudo_da_imagem = "\n - ![" <> imagem_sem_extensao <> "](./" <> imagem <> ") \n"
        FileCRUD.adiciona_imagens_md(artigo, conteudo_da_imagem)
      end
    end
  end
end
