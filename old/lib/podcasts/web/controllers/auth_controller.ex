defmodule Podcasts.Web.AuthController do
  @moduledoc """
  Authentication controller responsible for handling sign in and sign
  out requests.
  """
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  use Podcasts.Web, :controller

  alias Podcasts.Repo
  alias Podcasts.Accounts.User

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
        |> json %{user: user, token: jwt, exp: exp}
      user ->
        conn
        |> put_status(401)
        |> json %{message: "Could not login"}
      true ->
        dummy_checkpw()
        conn
        |> put_status(401)
        |> json %{message: "Could not login"}
    end
  end


  @doc """
  Render sign in page.
  """
  def new(conn, _params) do
    changeset = Podcasts.Accounts.change_user_registration(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  @doc """
  Processes sign in request.

  If the `auth` parameter is provided with the correct `email` and `password`,
  the user is logged in. Otherwise, the sign in form is displayed again with an
  error message.
  """
  def create(conn, %{"auth" => %{"email" => user, "password" => password}}) do
    case Podcasts.Web.AuthHelpers.login_by_email_and_pass(conn, user, password, repo: Podcasts.Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Logged in")
        |> redirect(to: "/") # TODO : Replace this by a proper route
      {:error, _reason, conn} ->
        changeset = Podcasts.Accounts.change_user_registration(%User{})
        conn
        |> put_flash(:error, "Wrong username or password")
        |> render("new.html", changeset: changeset)
    end
  end

  @doc """
  Processes sign out request.
  """
  def delete(conn, _params) do
    conn
    |> Guardian.Plug.sign_out
    |> redirect(to: "/") # TODO : Replace this by a proper route
  end

  defp random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.encode64 |> binary_part(0, length)
  end
end
