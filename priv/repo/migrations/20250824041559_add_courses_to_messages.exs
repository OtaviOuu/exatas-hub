defmodule ExatasHub.Repo.Migrations.AddCoursesToMessages do
  use Ecto.Migration

  def change do
    alter table(:messages) do
      add :course_id, references(:courses, on_delete: :nothing)
    end

    create index(:messages, [:course_id])
  end
end
