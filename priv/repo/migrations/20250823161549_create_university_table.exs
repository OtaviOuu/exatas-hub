defmodule ExatasHub.Repo.Migrations.CreateUniversityTable do
  use Ecto.Migration

  def change do
    create table(:universities) do
      add :name, :string, null: false
      add :initialism, :string, null: false
      add :logo, :string, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
