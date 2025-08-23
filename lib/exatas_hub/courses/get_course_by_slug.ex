defmodule ExatasHub.Courses.GetCourseBySlug do
  alias ExatasHub.Repo
  alias ExatasHub.Courses.Course

  def call(slug) do
    Repo.get_by(Course, slug: slug)
  end
end
