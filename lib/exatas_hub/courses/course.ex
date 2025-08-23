defmodule ExatasHub.Courses.Course do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExatasHub.Courses.Course
  @create_fields [:title, :image, :university_logo, :slug]

  schema "courses" do
    field :title, :string
    field :image, :string
    field :university_logo, :string
    field :slug, :string
    timestamps()
  end

  @doc false

  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @create_fields)
    |> put_change(:slug, generate_slug(attrs.title))
    |> validate_required(@create_fields)
    |> check_constraint(:slug, name: :slug_not_nil, message: "Slug cannot be null")
  end

  defp generate_slug(title) when not is_nil(title) do
    title
    |> String.downcase()
    |> String.replace(~r/[^\w]+/, "-")
  end
end
