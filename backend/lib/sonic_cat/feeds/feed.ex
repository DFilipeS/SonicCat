defmodule SonicCat.Feeds.Feed do
  use Ecto.Schema

  import Ecto.Changeset

  alias SonicCat.Feeds.Feed
  alias SonicCat.Accounts.User

  @timestamps_opts [usec: false] # Disables microsecond precision
  @derive {Poison.Encoder, only: [:id, :author, :description, :image, :name, :url, :user_id]}
  schema "feeds_feeds" do
    field :author, :string
    field :description, :string
    field :image, :string
    field :name, :string
    field :url, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%Feed{} = feed, attrs) do
    feed
    |> cast(attrs, [:name, :image, :author, :description, :url, :user_id])
    |> validate_required([:name, :image, :author, :description, :url, :user_id])
  end
end
