defmodule ElixirDropbox do
  @moduledoc """
  ElixirDropbox is a wrapper for Dropbox API V2
  """

  @type response :: {:ok, String.t()} | {{:status_code, integer()}, String.t()}

  @type response_download ::
          %{body: String.t(), headers: list()} | {{:status_code, integer()}, String.t()}

  @base_url Application.compile_env(:elixir_dropbox, :base_url)
  def post(client, url, body \\ "")

  def post(client, url, body) when byte_size(body) > 0 do
    new_req(client, headers: json_headers())
    |> post_request(url, body)
  end

  def post(client, url, body) do
    new_req(client)
    |> post_request(url, body)
  end

  def post_url(client, base_url, url, body \\ "") do
    new_req(client, base_url: base_url, headers: json_headers())
    |> post_request(url, body)
  end

  @spec process_response(Req.Response.t()) :: response
  def process_response(%Req.Response{status: 200, body: body}), do: {:ok, body}

  def process_response(%Req.Response{status: status_code, body: body} = resp) do
    #  IO.inspect(resp, label: "resp, status_code: #{status_code}")

    cond do
      status_code in 400..599 ->
        {{:status_code, status_code}, body}
    end
  end

  @spec download_response(Req.Response.t()) :: response_download
  def download_response(%Req.Response{status: 200, body: body, headers: headers}),
    do: %{body: body, headers: headers}

  def download_response(%Req.Response{status: status_code, body: body}) do
    cond do
      status_code in 400..599 ->
        {{:status_code, status_code}, body}
    end
  end

  def post_request(req, url, body \\ "", headers \\ []) do
    json_opt =
      if body == "" do
        []
      else
        [json: body]
      end

    Req.post!(req, [url: url, headers: headers] ++ json_opt)
    |> process_response()
  end

  def upload_request(client, base_url, url, data, headers) do
    new_req(client, base_url: base_url, headers: headers)
    |> post_request(url, {:file, data})
  end

  def download_request(client, base_url, url, data, headers) do
    new_req(client, base_url: base_url, headers: headers)
    |> Req.post!(url: url, body: data)
    |> download_response
  end

  def new_req(client, opts \\ []) do
    base_url = Keyword.get(opts, :base_url, @base_url)
    headers = Keyword.get(opts, :headers, [])

    Req.new(base_url: base_url, headers: headers, auth: {:bearer, client.access_token})
  end

  def json_headers do
    [
      {:content_type, "application/json"}
    ]
  end
end
