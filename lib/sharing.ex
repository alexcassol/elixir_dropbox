defmodule ElixirDropbox.Sharing do
 @doc """
  Create shared link

  ## Example

    ElixirDropbox.Sharing.create_shared_link client, "/Path"

  More info at: https://www.dropbox.com/developers/documentation/http/documentation#sharing-create_shared_link
  """  
  @spec create_shared_link(Client, binary) :: Map
  def create_shared_link(client, path) do
    body = %{"path" => path, "short_url" => true}
    result = to_string(Poison.Encoder.encode(body, []))
    ElixirDropbox.post(client, "/sharing/create_shared_link", result)
  end

  @spec create_shared_link_to_struct(Client, binary) :: SharedLink
  def create_shared_link_to_struct(client, path) do
    ElixirDropbox.Utils.to_struct(%ElixirDropbox.SharedLink{}, create_shared_link(client, path))
  end
end
