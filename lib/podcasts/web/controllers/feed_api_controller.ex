defmodule Podcasts.Web.FeedApiController do
  use Podcasts.Web, :controller

  import SweetXml

  alias Podcasts.Repo
  alias Podcasts.Feeds.Feed

  def show(conn, %{"id" => id}) do
    feed = Repo.get(Feed, id)
    {:ok, %HTTPoison.Response{body: body}} = HTTPoison.get(feed.url)
    feed =
      body
      |> xmap(
        name: ~x"//rss/channel/title/text()"s,
        image: ~x"//rss/channel/itunes:image/@href"s,
        author: ~x"//rss/channel/itunes:author/text()"s,
        description: ~x"//rss/channel/description/text()"s,
        entries: [
          ~x"//rss/channel/item"l,
          title: ~x"./title/text()"s,
          url: ~x"./link/text()"s,
          date: ~x"./pubDate/text()"s,
        ]
      )
      |> Enum.reduce(%{}, fn({key, val}, acc) -> Map.put(acc, Atom.to_string(key), val) end)

    feed = Map.put(feed, "entries", Enum.map(Map.get(feed, "entries"), fn (entry) ->
      {:ok, date} = Timex.parse(Map.get(entry, :date), "{RFC1123}")
      Map.put(entry, "date", date)
    end))
    
    render conn, "show.json", feed: feed
  end
end
