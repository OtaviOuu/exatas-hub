defmodule ExatasHub.Courses do
  alias ExatasHub.Courses.GetAllCourses

  defdelegate get_all_courses, to: GetAllCourses, as: :call
end
