defmodule Podcasts.Web.UserController do
  use Podcasts.Web, :controller

  alias Podcasts.Accounts.User

  @doc """
  Render sign up page.
  """
  def new(conn, _params) do
    changeset = Podcasts.Accounts.change_user_registration(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  @doc """
  Processes sign up request.

  If the `user` parameter is provided with valid data, a new user account is
  created. If data in the `user` parameter is not valid, the form is rendered
  again with errors messages.
  """
  def create(conn, %{"user" => user_params}) do
    case Podcasts.Accounts.register_user(user_params) do
      {:ok, user} ->
        conn
        |> Podcasts.Web.AuthHelpers.login(user)
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: page_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
