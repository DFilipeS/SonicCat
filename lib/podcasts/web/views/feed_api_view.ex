defmodule Podcasts.Web.FeedApiView do
  use Podcasts.Web, :view

  def render("show.json", %{feed: feed}) do
    %{
      feed: feed
    }
  end
end
