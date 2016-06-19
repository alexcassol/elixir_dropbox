defmodule ElixirDropbox.Users do

  @doc """
  Get user account by account_id

  ## Example

    ElixirDropbox.Users client, "dbid:AABYkM-pR8ynnNPIVBjMTPRrIyuT4bgtest"  

  More info at: https://www.dropbox.com/developers/documentation/http/documentation#users-get_current_account
  """  
  @spec get_account(Client, binary) :: Map
  def get_account(client, id) do
    body = %{"account_id" => id}
    result = to_string(Poison.Encoder.encode(body, []))
    ElixirDropbox.post(client, "/users/get_account", result)
  end

  @spec get_account_to_struct(Client, binary) :: Account
  def get_account_to_struct(client, id) do
    ElixirDropbox.Utils.to_struct(%ElixirDropbox.Account{}, get_account(client, id))
  end
  
  @doc """
  Get user current account

  ## Example 
      
    ElixirDropbox.Users.current_account client
 
  More info at: https://www.dropbox.com/developers/documentation/http/documentation#users-get_current_account 
  """
  @spec current_account(Client) :: Map
  def current_account(client) do
    ElixirDropbox.post(client, "/users/get_current_account", "null")
  end

  @spec current_account_to_struct(Client) :: Account
  def current_account_to_struct(client) do 
    ElixirDropbox.Utils.to_struct(%ElixirDropbox.Account{}, current_account(client))
  end
  
  @doc """
  Get user space usage

  ## Example 
      
    ElixirDropbox.Users.get_space_usage client
 
  More info at: https://www.dropbox.com/developers/documentation/http/documentation#users-get_space_usage
  """
  @spec get_space_usage(Client) :: Map
  def get_space_usage(client) do
    ElixirDropbox.post(client, "/users/get_space_usage", "null")
  end
  
  @doc """
  Get user account batch by account_ids.List of user account identifiers

  ## Example 
      
    ElixirDropbox.Users.get_account_batch client,  ["12345", "6789"]
 
  More info at: https://www.dropbox.com/developers/documentation/http/documentation#users-get_account_batch
  """
  @spec get_account_batch(Client, account_ids) :: Map
  def get_account_batch(client, account_ids) do
    body = %{"account_ids" => account_ids}
    result = to_string(Poison.Encoder.encode(body, []))
    ElixirDropbox.post(client, "/users/get_account_batch", result)
  end
end

