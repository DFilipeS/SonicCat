defmodule SonicCat.Web.AuthController do
  @moduledoc """
  Authentication controller responsible for handling sign in and sign
  out requests.
  """
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  use SonicCat.Web, :controller

  alias SonicCat.Repo
  alias SonicCat.Accounts.User

  def login(conn, %{"email" => email, "password" => password}) do
    user = Repo.get_by(User, email: email)

    cond do
      user && user.password_hash && checkpw(password, user.password_hash) ->
        new_conn = Guardian.Plug.api_sign_in(conn, user)
        jwt = Guardian.Plug.current_token(new_conn)
        {:ok, claims} = Guardian.Plug.claims(new_conn)
        exp = Map.get(claims, "exp")

        new_conn
        |> put_resp_header("authorization", "Bearer #{jwt}")
        |> put_resp_header("x-expires", "#{exp}")
        |> json(%{user: user, token: jwt, exp: exp})
      user ->
        conn
        |> put_status(401)
        |> json(%{message: "Could not login"})
      true ->
        dummy_checkpw()
        conn
        |> put_status(401)
        |> json(%{message: "Could not login"})
    end
  end

  def register(conn, params) do
    case SonicCat.Accounts.register_user(params) do
      {:ok, user} ->
        new_conn = Guardian.Plug.api_sign_in(conn, user)
        jwt = Guardian.Plug.current_token(new_conn)
        {:ok, claims} = Guardian.Plug.claims(new_conn)
        exp = Map.get(claims, "exp")

        new_conn
        |> put_resp_header("authorization", "Bearer #{jwt}")
        |> put_resp_header("x-expires", "#{exp}")
        |> json(%{user: user, token: jwt, exp: exp})
      {:error, changeset} ->
        errors = Enum.reduce(changeset.errors, %{}, fn ({field, {message, _}}, acc) ->
          Map.put(acc, field, message)
        end)
        json conn, %{status: 422, errors: errors}
    end
  end
end
