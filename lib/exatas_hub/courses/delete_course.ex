defmodule ExatasHub.Courses.DeleteCourse do
  alias ExatasHub.Repo
  alias ExatasHub.Courses.Course

  def call(id) do
    Repo.delete(Repo.get!(Course, id))
  end
end
