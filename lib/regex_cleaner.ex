defmodule RegexCleaner do
  def limpar(texto, finalidade) do
    IO.puts("Limpando " <> texto <> " para " <> finalidade)

    # remove caracteres especiais para evitar problemas com o sistema de arquivos e outras besteiras
    nome_higienizado =
      texto
      |> String.replace(~r/[^a-zA-Z0-9.]/, "")
      |> String.trim()

    case finalidade do
      "diretorio" ->
        nome_higienizado

      "arquivo" ->
        if String.ends_with?(nome_higienizado, ".txt") do
          nome_higienizado
        else
          nome_higienizado <> ".txt"
        end

      "imagem" ->
        if String.ends_with?(nome_higienizado, ".jpg") do
          nome_higienizado
        else
          nome_higienizado <> ".jpg"
        end

      _ ->
        nome_higienizado
    end
  end
end
