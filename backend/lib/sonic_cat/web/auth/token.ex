defmodule SonicCat.Web.Auth.Token do
  use SonicCat.Web, :controller

  def unauthenticated(conn, _params) do
    conn
    |> put_status(401)
    |> json(%{error: "Unauthenticated request.", code: 401})
  end

  def unauthorized(conn, _params) do
    conn
    |> put_status(403)
    |> json(%{error: "Unauthorized request.", code: 403})
  end
end
