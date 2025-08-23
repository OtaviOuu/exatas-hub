defmodule ExatasHub.Repo.Migrations.AddUniversityToCourses do
  use Ecto.Migration

  def change do
    alter table(:courses) do
      add :university_id, references(:universities, on_delete: :nothing)
    end

    create index(:courses, [:university_id])
  end
end
