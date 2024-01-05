defmodule PandocClient do
  #adiciona Pandex
  import Pandex

  #cria uma página html à partir de um .md usando panpipe.pandoc
  def cria_html(filename) do
    # pega o nome do arquivo
    nome_do_arquivo = Path.basename(filename)
    # pega o nome do arquivo sem extensão
    nome_do_arquivo_sem_extensao = RegexCleaner.limpar(nome_do_arquivo, "diretorio")
    # pega o conteudo do arquivo
    conteudo_do_arquivo = FileCRUD.leia_md(filename)
    # pega o conteudo do arquivo e converte em html
    {_, conteudo_do_arquivo_em_html} = markdown_to_html(conteudo_do_arquivo)
    # escreve o arquivo destino dentro do diretorio homonimo
    FileCRUD.cria_html(conteudo_do_arquivo_em_html, nome_do_arquivo, nome_do_arquivo_sem_extensao)
  end
end
