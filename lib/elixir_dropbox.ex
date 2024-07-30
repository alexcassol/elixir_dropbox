defmodule ElixirDropbox do
  @moduledoc """
  ElixirDropbox is a wrapper for Dropbox API V2
  """

  @type response :: {any, any}

  @base_url Application.compile_env(:elixir_dropbox, :base_url)

  def post(client, url, body \\ "") do
    new_req(client, headers: json_headers())
    |> post_request(url, body)

    # post_request(client, "#{@base_url}#{url}", body, headers)
  end

  def post_url(client, base_url, url, body \\ "") do
    new_req(client, base_url: base_url, headers: json_headers())
    |> post_request(url, body)
  end

  @spec process_response(Req.Response.t()) :: response
  def process_response(%Req.Response{status: 200, body: body}), do: {:ok, body}

  def process_response(%Req.Response{status: status_code, body: body}) do
    cond do
      status_code in 400..599 ->
        {{:status_code, status_code}, body}
    end
  end

  @spec download_response(Req.Response.t()) :: response
  def download_response(%Req.Response{status: 200, body: body, headers: headers}),
    do: %{body: body, headers: headers}

  def download_response(%Req.Response{status: status_code, body: body}) do
    cond do
      status_code in 400..599 ->
        {{:status_code, status_code}, body}
    end
  end

  def post_request(req, url, body, headers \\ []) do
    Req.post!(req, url: url, json: body, headers: headers)
    |> process_response

    # HTTPoison.post!(url, body, headers) |> process_response
  end

  def upload_request(client, base_url, url, data, headers) do
    new_req(client, base_url: base_url, headers: headers)
    |> post_request(url, {:file, data})

    # post_request(client, "#{base_url}#{url}", {:file, data}, headers)
  end

  def download_request(client, base_url, url, data, headers) do
    new_req(client, base_url: base_url, headers: headers)
    |> Req.post!(url: url, body: data)
    |> download_response

    # headers = Map.merge(headers, headers(client))
    # HTTPoison.post!("#{base_url}#{url}", data, headers) |> download_response
  end

  def new_req(client, opts \\ []) do
    base_url = Keyword.get(opts, :base_url, @base_url)
    headers = Keyword.get(opts, :headers, [])

    Req.new(base_url: base_url, headers: headers, auth: {:bearer, client.access_token})

    # %{"Authorization" => "Bearer #{client.access_token}"}
  end

  def json_headers do
    [
      {:content_type, "application/json"}
    ]
  end
end
