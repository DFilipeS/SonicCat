defmodule Podcasts.Repo.Migrations.CreateEntriesTable do
  use Ecto.Migration

  def change do
    create table(:feeds_entries) do
      add :title, :text
      add :url, :string
      add :date, :utc_datetime
      add :feed_id, references(:feeds_feeds, on_delete: :delete_all)

      timestamps()
    end
  end
end
