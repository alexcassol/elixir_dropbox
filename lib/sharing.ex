defmodule ElixirDropbox.Sharing do
  @moduledoc """
  """
  alias ElixirDropbox.Client
  import ElixirDropbox
  import ElixirDropbox.Utils

  @doc """
  Create shared link returns map

  ## Example

    ElixirDropbox.Sharing.create_shared_link client, "/Path"

  More info at: https://www.dropbox.com/developers/documentation/http/documentation#sharing-create_shared_link
  """
  @spec create_shared_link(Client, binary) :: any
  def create_shared_link(client, path) do
    body = %{"path" => path, "short_url" => true}
    # result = to_string(Jason.encoder().encode(body, []))
    post(client, "/sharing/create_shared_link", body)
  end

  @doc """
  Create shared link returns SharedLink struct

  ## Example

    ElixirDropbox.Sharing.create_shared_link_to_struct client, "/Path"
  """
  @spec create_shared_link_to_struct(Client, binary) :: SharedLink | any
  def create_shared_link_to_struct(client, path) do
    case create_shared_link(client, path) do
      {:ok, response} -> to_struct(%ElixirDropbox.SharedLink{}, response)
      {err, _} -> elem(err, 1)
    end
  end
end
