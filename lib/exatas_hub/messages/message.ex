defmodule ExatasHub.Messages.Message do
  use Ecto.Schema

  import Ecto.Changeset

  schema "messages" do
    field :text, :string
    belongs_to :course, ExatasHub.Courses.Course
    belongs_to :user, ExatasHub.Accounts.User
    timestamps()
  end

  def changeset(message \\ %__MODULE__{}, attrs \\ %{}, user_scope)

  def changeset(message, attrs, user_scope) do
    message
    |> cast(attrs, [:text, :user_id, :course_id])
    |> validate_required([:text, :user_id, :course_id])
    |> validate_length(:text, min: 1, max: 300)
    |> put_change(:user_id, user_scope.user.id)
  end
end
