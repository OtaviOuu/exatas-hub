defmodule ExatasHub.Courses.Course do
  use Ecto.Schema
  import Ecto.Changeset
  @create_fields [:title, :image, :slug, :university_id, :playlist_link]

  schema "courses" do
    field :title, :string
    field :image, :string
    field :slug, :string
    field :playlist_link, :string
    has_many :messages, ExatasHub.Messages.Message, on_delete: :delete_all
    belongs_to :university, ExatasHub.Universities.University
    timestamps()
  end

  @doc false

  def changeset(course \\ %__MODULE__{}, attrs) do
    course
    |> cast(attrs, @create_fields)
    |> generate_slug()
    |> validate_required(@create_fields)
    |> validate_length(:title, min: 3, max: 100)
    |> check_constraint(:slug, name: :slug_not_nil, message: "Slug cannot be null")
  end

  defp generate_slug(changeset) do
    title = get_field(changeset, :title)

    case title do
      nil ->
        changeset

      _ ->
        slug =
          title
          |> String.downcase()
          |> String.replace(~r/[^\w]+/, "-")

        put_change(changeset, :slug, slug)
    end
  end
end
