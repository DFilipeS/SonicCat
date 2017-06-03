defmodule Podcasts.Feeds.Entry do
  use Ecto.Schema

  @timestamps_opts [usec: false] # Disables microsecond precision

  schema "feeds_entries" do
    field :title, :string
    field :url, :string
    field :date, :utc_datetime
    belongs_to :feed, Podcasts.Feeds.Feed, foreign_key: :feed_id

    timestamps()
  end
end
