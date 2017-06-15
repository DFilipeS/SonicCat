defmodule Podcasts.Web.FeedApiController do
  use Podcasts.Web, :controller

  import SweetXml

  alias Podcasts.Repo
  alias Podcasts.Feeds.Feed

  def index(conn, _args) do
    feeds = Repo.all(Feed)
    json conn, %{feeds: feeds}
  end

  def create(conn, params) do
    {:ok, feed} = Podcasts.Feeds.create_feed(Map.put(params, "user_id", Podcasts.Web.ViewHelpers.current_user(conn).id))
    json conn, %{feed: feed}
  end

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
          url: ~x"./guid/text()"s,
          date: ~x"./pubDate/text()"s,
        ]
      )
      |> Enum.reduce(%{}, fn({key, val}, acc) -> Map.put(acc, Atom.to_string(key), val) end)

    feed = Map.put(feed, "entries", Enum.map(Map.get(feed, "entries"), fn (entry) ->
      case Timex.parse(Map.get(entry, :date), "{RFC1123}") do
        {:ok, date} -> Map.put(entry, "date", date)
        {:error, _} -> Map.put(entry, "date", Timex.parse!(Map.get(entry, :date), "%a, %d %b %Y %k:%M:%S %z", :strftime))
      end
    end))

    render conn, "show.json", feed: feed
  end
end
