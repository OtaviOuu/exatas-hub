defmodule ExatasHubWeb.CourseLive.Index do
  use ExatasHubWeb, :live_view
  alias ExatasHubWeb.Layouts
  alias ExatasHub.Courses

  def mount(_params, _session, socket) do
    courses = Courses.get_all_courses()

    socket =
      socket
      |> stream(:courses, courses, limit: 30)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <h1>Courses</h1>
      <div
        class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6 mt-6"
        id="courses-grid"
        phx-update="stream"
      >
        <.course_card :for={{dom_id, course} <- @streams.courses} course={course} id={dom_id} />
      </div>
    </Layouts.app>
    """
  end

  def course_card(assigns) do
    ~H"""
    <div
      class="card card-lg bg-base-100 w-96 shadow-sm rounded-md transition-transform duration-200 ease-in-out hover:scale-105 hover:shadow-md"
      id={@id}
    >
      <figure>
        <.link navigate={~p"/courses/#{@course.slug}"}>
          <img
            src={@course.image}
            alt={@course.title}
          />
        </.link>
      </figure>
      <div class="card-body">
        <div class="flex items-center gap-2 mb-2">
          <span class="inline-block text-primary">
            <img
              src={@course.university_logo}
              alt="Universidade"
              class="w-6 h-6 rounded-sm bg-base-200"
            />
          </span>
          <h2 class="card-title mb-0">{@course.title}</h2>
        </div>
        <span>
          A card component has a figure, a body part, and inside body there are title and actions parts
        </span>
      </div>
    </div>
    """
  end
end
