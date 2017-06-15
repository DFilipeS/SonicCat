defmodule Podcasts.Feeds do
  @moduledoc """
  The boundary for the Feeds system.
  """
  import Ecto.{Query, Changeset}, warn: false
  import SweetXml

  alias Podcasts.Repo
  alias Podcasts.Feeds.Feed

  @doc """
  Creates a feed.

  ## Examples

      iex> create_feed(%{field: value})
      {:ok, %Feed{}}

      iex> create_feed(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_feed(%{"url" => url, "user_id" => user_id} = attrs) do
    case Repo.get_by(Feed, %{url: url, user_id: user_id}) do
      nil ->
        {:ok, %HTTPoison.Response{body: body}} = HTTPoison.get(url)
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
        |> feed_changeset(attrs)
        |> Repo.insert()
      feed -> {:ok, feed}
    end
  end

  def feed_changeset(%Feed{} = feed, attrs) do
    feed
    |> cast(attrs, [:name, :image, :author, :description, :user_id, :url])
    |> validate_required([:user_id, :url])
  end
end
