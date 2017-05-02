defmodule Podcasts.Web.PageController do
  use Podcasts.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def podcast_information(conn, %{"cenas" => %{"url" => url}}) do
    {:ok, %HTTPoison.Response{body: body}} = HTTPoison.get(url)
    {:ok, feed} = ElixirFeedParser.parse(body)
    render conn, "index.html", feed: feed
  end

  def podcast_information_api(conn, %{"url" => url}) do
    {:ok, %HTTPoison.Response{body: body}} = HTTPoison.get(url)
    {:ok, feed} = ElixirFeedParser.parse(body)

    feed = [%{
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
    }]
    render conn, "index.json", feed: feed
  end
end
