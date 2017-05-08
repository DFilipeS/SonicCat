defmodule Podcasts.Repo.Migrations.CreateFeedsTable do
  use Ecto.Migration

  def change do
    create table(:feeds_feeds) do
      add :name, :text
      add :image, :string
      add :author, :string
      add :description, :text
      add :url, :string
      add :user_id, references(:accounts_users, on_delete: :delete_all)

      timestamps()
    end
  end
end
