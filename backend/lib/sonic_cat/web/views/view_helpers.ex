defmodule SonicCat.Web.ViewHelpers do
  @moduledoc """
  General utility functions.
  """

  @doc """
  Utility function to get the current logged in user.

  If the user is logged in, returns a `%SonicCat.Accounts.User{}` struct. If not logged in,
  it returns `nil`.
  """
  def current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end

  @doc """
  Utility function to check if there is a user logged in or not. Returns a
  `boolean`.
  """
  def logged_in?(conn) do
    Guardian.Plug.authenticated?(conn)
  end
end
