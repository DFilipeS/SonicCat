defmodule SonicCat.Repo.Migrations.CreateSonicCat.Feeds.Feed do
  use Ecto.Migration

  def change do
    create table(:feeds_feeds) do
      add :name, :string
      add :image, :string
      add :author, :string
      add :description, :string
      add :url, :string
      add :user_id, references(:accounts_users, on_delete: :nothing)

      timestamps()
    end

    create index(:feeds_feeds, [:user_id])
  end
end
