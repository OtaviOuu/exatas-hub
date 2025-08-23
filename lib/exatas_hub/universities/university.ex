defmodule ExatasHub.Universities.University do
  use Ecto.Schema
  import Ecto.Changeset

  schema "universities" do
    field :name, :string
    field :initialism, :string
    field :logo, :string

    has_many :courses, ExatasHub.Courses.Course

    timestamps(type: :utc_datetime)
  end

  def changeset(university \\ %__MODULE__{}, attrs) do
    university
    |> cast(attrs, [:name, :initialism, :logo])
    |> validate_required([:name, :initialism, :logo])
    |> validate_length(:name, min: 3, max: 100)
  end
end
