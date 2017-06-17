defmodule SonicCat.Web.PageController do
  use SonicCat.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
