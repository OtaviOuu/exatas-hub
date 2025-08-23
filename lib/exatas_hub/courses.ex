defmodule ExatasHub.Courses do
  alias ExatasHub.Courses.GetAllCourses
  alias ExatasHub.Courses.GetCourseBySlug
  alias ExatasHub.Courses.CreateCourse
  defdelegate get_all_courses(), to: GetAllCourses, as: :call
  defdelegate get_course_by_slug(slug), to: GetCourseBySlug, as: :call
  defdelegate create_course(attrs), to: CreateCourse, as: :call
end
