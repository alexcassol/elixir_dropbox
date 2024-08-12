defmodule ElixirDropbox.Users do
  @moduledoc """
  This namespace contains endpoints and data types for user management.
  """
  alias ElixirDropbox.Client
  alias ElixirDropbox.Account
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
      response when is_binary(response) -> to_struct(%ElixirDropbox.Account{}, response)
      error -> error
    end

    case get_account(client, id) do
      {{:status_code, status_code}, body} -> {:error, {status_code, body}}
      response -> to_struct(%ElixirDropbox.Account{}, response)
    end
  end

  @doc """
  Get user current account

  ## Example

    ElixirDropbox.Users.current_account client

  More info at: https://www.dropbox.com/developers/documentation/http/documentation#users-get_current_account
  """
  @spec current_account(Client) :: String | Tuple
  def current_account(client) do
    post(client, "/users/get_current_account") do
      {:ok, response} -> response
      {{:status_code, status_code}, body} -> {:error, {status_code, body}}
    end
  end

  @spec current_account_to_struct(String | Tuple) :: Account
  def current_account_to_struct(client) do
    case current_account(client) do
      response when is_binary(response) -> to_struct(%ElixirDropbox.Account{}, response)
      error -> error
    end
  end

  @doc """
  Get user space usage

  ## Example

    ElixirDropbox.Users.get_space_usage client

  More info at: https://www.dropbox.com/developers/documentation/http/documentation#users-get_space_usage
  """
  @spec get_space_usage(Client) :: any
  def get_space_usage(client) do
    case post(client, "/users/get_space_usage") do
      {:ok, response} -> response
      {{:status_code, status_code}, body} -> {:error, {status_code, body}}
    end
  end

  def get_space_usage_to_struct(client) do
    case get_space_usage(client) do
      response when is_binary(response) -> to_struct(%ElixirDropbox.SpaceUsage{}, response)
      error -> error
    end
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
      {{:status_code, status_code}, body} -> {:error, {status_code, body}}
    end
  end
end
