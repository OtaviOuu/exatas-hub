defmodule ExatasHub.Courses.GetCourseBySlug do
  alias ExatasHub.Repo
  alias ExatasHub.Courses.Course
  import Ecto.Query

  def call(slug) do
    Course
    |> where(slug: ^slug)
    |> preload(:university)
    |> Repo.one()
  end
end
