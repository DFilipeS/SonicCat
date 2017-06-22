defmodule SonicCat.Feeds do
  @moduledoc """
  The boundary for the Feeds system.
  """

  import Ecto.Query, warn: false
  import SweetXml

  alias SonicCat.Repo
  alias SonicCat.Feeds.Feed

  def list_feeds do
    Repo.all(Feed) |> Repo.preload(:user)
  end

  def get_feed!(id), do: Repo.get!(Feed, id) |> Repo.preload(:user)

  def create_feed(%{"url" => url, "user_id" => user_id} = attrs \\ %{}) do
    case Repo.get_by(Feed, %{url: url, user_id: user_id}) do
      nil ->
        with {:ok, %HTTPoison.Response{body: body}} <- HTTPoison.get(url) do
          result =
            body
            |> xmap(
              name: ~x"//rss/channel/title/text()"s,
              image: ~x"//rss/channel/itunes:image/@href"s,
              author: ~x"//rss/channel/itunes:author/text()"s,
              description: ~x"//rss/channel/description/text()"s,
            )
            |> Enum.reduce(%{}, fn({key, val}, acc) -> Map.put(acc, Atom.to_string(key), val) end)
          attrs = Map.merge(attrs, result)
          %Feed{}
          |> Feed.changeset(attrs)
          |> Repo.insert()
        else
          _err -> {:error, "Invalid URL"}
        end
      feed -> {:ok, feed}
    end
  end

  def delete_feed(%Feed{} = feed) do
    Repo.delete(feed)
  end

  def change_feed(%Feed{} = feed) do
    Feed.changeset(feed, %{})
  end
end
