defmodule RegexCleander do
  def limpar(texto, finalidade) do
    # Remove espaços e caracteres especiais do nome do arquivo usando regex
    # nao queremos que o usuário crie arquivos com nomes estranhos nem espaços
    # também nao quero ninguém criando scripts maliciosos
    nome_higienizado =
      texto
      # Permitindo ponto para a extensão, copiei o regex do stackoverflow
      |> String.replace(~r/[^a-zA-Z0-9.]/, "")
      |> String.trim()

    if finalidade == "arquivo" do
      # Adiciona a extensão .txt se não tiver
      nome_higienizado <> ".txt"
    else
      # se ja tiver a extensão, não adiciona e segue a vida
      nome_higienizado
    end
  end
end
