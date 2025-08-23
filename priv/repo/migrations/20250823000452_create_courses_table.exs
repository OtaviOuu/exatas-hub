defmodule ExatasHub.Repo.Migrations.CreateCoursesTable do
  use Ecto.Migration

  def change do
    create table(:courses) do
      add :title, :string
      add :image, :string
      timestamps()
    end
  end
end
