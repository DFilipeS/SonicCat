defmodule Podcasts.Web.PageView do
  use Podcasts.Web, :view

  def render("index.json", %{feed: feed}) do
    %{
      feed: feed
    }
  end
end
