defmodule Podcasts.Accounts.User do
  use Ecto.Schema

  @timestamps_opts [usec: false] # Disables microsecond precision

  schema "accounts_users" do
    field :email, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end
end
