defmodule Podcasts.Web.FeedApiController do
  use Podcasts.Web, :controller

  alias Podcasts.Repo
  alias Podcasts.Feeds.Feed

  def show(conn, %{"id" => id}) do
    feed = Repo.get(Feed, id)
    {:ok, %HTTPoison.Response{body: body}} = HTTPoison.get(feed.url)
    {:ok, feed} = ElixirFeedParser.parse(body)

    feed = %{
      title: feed.title,
      image: feed.itunes_image,
      author: feed.itunes_author,
      description: feed.description,
      entries: Enum.map(feed.entries, fn entry ->
        %{
          title: entry.title,
          url: entry.url,
          date: entry.updated
        }
      end)
    }
    render conn, "show.json", feed: feed
  end
end
