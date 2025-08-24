defmodule ExatasHub.Repo.Migrations.CreateMessagesTable do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :text, :text
      add :user_id, :integer
      timestamps()
    end
  end
end
