defmodule ExatasHub.Universities.University do
  use Ecto.Schema

  schema "universities" do
    field :name, :string
    field :initialism, :string
    field :logo, :string

    has_many :courses, ExatasHub.Courses.Course

    timestamps(type: :utc_datetime)
  end
end
