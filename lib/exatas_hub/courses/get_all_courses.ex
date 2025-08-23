defmodule ExatasHub.Courses.GetAllCourses do
  alias ExatasHub.Repo
  alias ExatasHub.Courses.Course

  def call() do
    Course
    |> Repo.all()
  end
end
