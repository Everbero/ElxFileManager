defmodule BingImagesClient do
  alias HTTPoison.{Response}
  # vamos usar FileCrud
  alias FileCRUD

  @api_url "https://api.bing.microsoft.com/v7.0/images/search"
  @api_key System.get_env("BING_IMAGES_API_KEY") || "DEFAULT_VALUE"

  def montar_request(artigo) do
    headers = [
      {"Ocp-Apim-Subscription-Key", "#{@api_key}"}
    ]

    params = %{
      q: artigo,
      count: 10,
    }

    enviar_request(@api_url, headers, params, artigo)
  end

  defp enviar_request(url, headers, params, artigo) do
    url_encodada = "#{url}?#{params |> URI.encode_query()}"
    #get é mais facil graças ao bom Deus do elixir
    response = HTTPoison.get(url_encodada, headers)

    case response do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body, artigo}

      {:ok, %HTTPoison.Response{status_code: status, body: body}} ->
        IO.puts("Erro #{status} ao acessar a API: #{body}")

      {:error, reason} ->
        IO.puts("Erro ao fazer a requisição: #{reason}")
    end
  end
end
