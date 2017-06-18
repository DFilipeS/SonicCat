defmodule SonicCat.Web.AuthHelpers do
  @moduledoc """
  General purpose functions for authentication.
  """

  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  @doc """
  Signs in the provided user.
  """
  def login(conn, user) do
    Guardian.Plug.sign_in(conn, user, :access)
  end

  @doc """
  Signs in a user with given `email` and `given_pass` credentials in the given
  `repo` in the `opts`.
  """
  def login_by_email_and_pass(conn, email, given_pass, opts) do
    repo = Keyword.fetch!(opts, :repo)
    user = repo.get_by(SonicCat.Accounts.User, email: email)

    cond do
      user && user.password_hash && checkpw(given_pass, user.password_hash) ->
        {:ok, login(conn, user)}
      user ->
        {:error, :unauthorized, conn}
      true ->
        dummy_checkpw()
        {:error, :not_found, conn}
    end
  end
end
