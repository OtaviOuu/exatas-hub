defmodule ExatasHub.Courses.CreateCourse do
  alias ExatasHub.Repo
  alias ExatasHub.Courses.Course

  def call(attrs) do
    attrs
    |> Course.changeset()
    |> Repo.insert()
  end
end
