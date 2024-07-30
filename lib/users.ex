defmodule ElixirDropbox.Users do
  @moduledoc """
  This namespace contains endpoints and data types for user management.
  """
  import ElixirDropbox
  import ElixirDropbox.Utils

  @doc """
  Get user account by account_id

  ## Example

    ElixirDropbox.Users client, "TOKEN"

  More info at: https://www.dropbox.com/developers/documentation/http/documentation#users-get_current_account
  """
  @spec get_account(Client, binary) :: any
  def get_account(client, id) do
    body = %{"account_id" => id}
    # result = to_string(Jason.encoder().encode(body, []))
    post(client, "/users/get_account", body)
  end

  @spec get_account_to_struct(Client, binary) :: Account | any
  def get_account_to_struct(client, id) do
    case get_account(client, id) do
      {:ok, response} -> to_struct(%ElixirDropbox.Account{}, response)
      {err, _} -> elem(err, 1)
    end
  end

  @doc """
  Get user current account

  ## Example

    ElixirDropbox.Users.current_account client

  More info at: https://www.dropbox.com/developers/documentation/http/documentation#users-get_current_account
  """
  @spec current_account(Client) :: any
  def current_account(client) do
    case post(client, "/users/get_current_account", "null") do
      {:ok, response} -> response
      {err, _} -> elem(err, 1)
    end
  end

  @spec current_account_to_struct(Client) :: Account
  def current_account_to_struct(client) do
    to_struct(%ElixirDropbox.Account{}, current_account(client))
  end

  @doc """
  Get user space usage

  ## Example

    ElixirDropbox.Users.get_space_usage client

  More info at: https://www.dropbox.com/developers/documentation/http/documentation#users-get_space_usage
  """
  @spec get_space_usage(Client) :: any
  def get_space_usage(client) do
    case post(client, "/users/get_space_usage", "null") do
      {:ok, response} -> response
      {err, _} -> elem(err, 1)
    end
  end

  def get_space_usage_to_struct(client) do
    to_struct(%ElixirDropbox.SpaceUsage{}, get_space_usage(client))
  end

  @doc """
  Get user account batch by account_ids.List of user account identifiers

  ## Example

    ElixirDropbox.Users.get_account_batch client,  ["12345", "6789"]

  More info at: https://www.dropbox.com/developers/documentation/http/documentation#users-get_account_batch
  """
  @spec get_account_batch(Client, binary) :: any
  def get_account_batch(client, account_ids) do
    body = %{"account_ids" => account_ids}
    # result = to_string(Jason.encoder().encode(body, []))
    case post(client, "/users/get_account_batch", body) do
      {:ok, response} -> response
      {err, _} -> elem(err, 1)
    end
  end
end
