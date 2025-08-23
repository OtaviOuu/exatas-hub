defmodule ExatasHub.Courses.Course do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:title, :image]

  schema "courses" do
    field :title, :string
    field :image, :string
    timestamps()
  end

  @doc false
  def changeset(course, attrs) do
    course
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
