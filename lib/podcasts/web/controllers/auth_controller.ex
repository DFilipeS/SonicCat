defmodule Podcasts.Web.AuthController do
  @moduledoc """
  Authentication controller responsible for handling sign in and sign
  out requests.
  """

  use Podcasts.Web, :controller

  alias Podcasts.Repo
  alias Podcasts.Accounts.User

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
