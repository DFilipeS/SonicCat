defmodule Podcasts.Accounts.User do
  use Ecto.Schema

  @timestamps_opts [usec: false] # Disables microsecond precision
  @derive {Poison.Encoder, only: [:email, :name]}
  schema "accounts_users" do
    field :email, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    has_many :feeds, Podcasts.Feeds.Feed

    timestamps()
  end
end
