defmodule ExatasHub.Courses.GetCourseChangeset do
  alias ExatasHub.Courses.Course

  def call(course \\ %Course{}, attrs \\ %{}) do
    course
    |> Course.changeset(attrs)
  end
end
