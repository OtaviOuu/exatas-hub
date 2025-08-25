defmodule ExatasHub.Repo.Migrations.AddPlaylistLinkToCourses do
  use Ecto.Migration

  def change do
    alter table(:courses) do
      add :playlist_link, :string
    end
  end
end
