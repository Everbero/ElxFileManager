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


    if finalidade == "diretorio" do
       nome_higienizado
    end

    if finalidade == "arquivo" do
      # Adiciona a extensão .txt se não tiver
      if String.ends_with?(nome_higienizado, ".txt") do
        nome_higienizado
      else
        nome_higienizado <> ".txt"
      end
    end

    if finalidade == "imagem" do
      # Adiciona a extensão .txt se não tiver
      if String.ends_with?(nome_higienizado, ".jpg") do
        nome_higienizado
      else
        nome_higienizado <> ".jpg"
      end
    end
  end
end
