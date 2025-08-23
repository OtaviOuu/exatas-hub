defmodule ExatasHub.Courses.GetAllCourses do
  alias ExatasHub.Repo
  alias ExatasHub.Courses.Course
  import Ecto.Query

  def call() do
    Course
    |> preload(:university)
    |> Repo.all()
  end
end
