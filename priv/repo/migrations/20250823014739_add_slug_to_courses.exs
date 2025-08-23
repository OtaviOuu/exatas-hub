defmodule ExatasHub.Repo.Migrations.AddSlugToCourses do
  use Ecto.Migration

  def change do
    alter table(:courses) do
      add :slug, :string
    end

    create unique_index(:courses, [:slug])

    constraint(:courses, :slug_not_nil, check: "slug IS NOT NULL")
  end
end
