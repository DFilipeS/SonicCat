defmodule Podcasts.Web.PageController do
  use Podcasts.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
