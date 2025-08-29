defmodule ExatasHub.Courses do
  alias ExatasHub.Courses.GetAllCourses
  alias ExatasHub.Courses.GetCourseBySlug
  alias ExatasHub.Courses.CreateCourse
  alias ExatasHub.Courses.GetCourseChangeset
  alias ExatasHub.Courses.DeleteCourse

  defdelegate get_all_courses(), to: GetAllCourses, as: :call
  defdelegate get_course_by_slug(slug), to: GetCourseBySlug, as: :call
  defdelegate create_course(scope, attrs), to: CreateCourse, as: :call
  defdelegate get_course_changeset(course, attrs), to: GetCourseChangeset, as: :call
  defdelegate delete_course(id), to: DeleteCourse, as: :call
end
