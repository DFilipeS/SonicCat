defmodule SonicCat.Web.FeedView do
  use SonicCat.Web, :view
  alias SonicCat.Web.FeedView

  def render("index.json", %{feeds: feeds}) do
    %{data: render_many(feeds, FeedView, "feed.json")}
  end

  def render("show.json", %{feed: feed}) do
    %{data: render_one(feed, FeedView, "feed.json")}
  end

  def render("feed.json", %{feed: feed}) do
    %{
      id: feed.id,
      name: feed.name,
      image: feed.image,
      author: feed.author,
      description: feed.description,
      url: feed.url,
      user: feed.user
    }
  end
end
