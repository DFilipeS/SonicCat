defmodule Podcasts.Feeds.Feed do
  use Ecto.Schema

  @timestamps_opts [usec: false] # Disables microsecond precision

  schema "feeds_feeds" do
    field :name, :string
    field :image, :string
    field :author, :string
    field :description, :string
    field :url, :string
    belongs_to :user, Podcasts.Accounts.User, foreign_key: :user_id

    timestamps()
  end
end
