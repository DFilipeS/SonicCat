defmodule Podcasts.Feeds.Feed do
  use Ecto.Schema

  @timestamps_opts [usec: false] # Disables microsecond precision
  @derive {Poison.Encoder, only: [:id, :name, :image, :author, :description, :url]}
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
