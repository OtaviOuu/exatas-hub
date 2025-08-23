defmodule ExatasHubWeb.CourseLive.Index do
  use ExatasHubWeb, :live_view

  alias ExatasHub.Courses

  def mount(_params, _session, socket) do
    courses = Courses.get_all_courses()
    socket = assign(socket, :courses, courses)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Courses</h1>
    <.course_card :for={course <- @courses} course={course} />
    """
  end

  def course_card(assigns) do
    ~H"""
    <div class="course-card">
      <h2>{@course.title}</h2>
    </div>
    """
  end
end
