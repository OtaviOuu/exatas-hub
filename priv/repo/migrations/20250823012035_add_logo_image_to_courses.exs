defmodule ExatasHub.Repo.Migrations.AddLogoImageToCourses do
  use Ecto.Migration

  def change do
    alter table(:courses) do
      add :university_logo, :string
    end
  end
end
