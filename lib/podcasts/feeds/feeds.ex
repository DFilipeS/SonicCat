defmodule Podcasts.Feeds do
  @moduledoc """
  The boundary for the Feeds system.
  """
  import Ecto.{Query, Changeset}, warn: false

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
  def create_feed(%{"url" => url} = attrs) do
    {:ok, %HTTPoison.Response{body: body}} = HTTPoison.get(url)
    {:ok, feed} = ElixirFeedParser.parse(body)
    attrs = Map.merge(attrs, %{
      "name" => feed.title,
      "image" => feed.itunes_image,
      "author" => feed.itunes_author,
      "description" => feed.description
    })
    %Feed{}
    |> feed_changeset(attrs)
    |> Repo.insert()
  end

  def feed_changeset(%Feed{} = feed, attrs) do
    feed
    |> cast(attrs, [:name, :image, :author, :description, :user_id, :url])
    |> validate_required([:user_id, :url])
  end
end
