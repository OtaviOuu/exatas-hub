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
    <Layouts.app current_scope={@current_scope} flash={@flash}>
      <h1>Courses</h1>
      <section
        class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6 mt-6"
        id="courses-grid"
        phx-update="stream"
      >
        <.course_card :for={{dom_id, course} <- @streams.courses} course={course} id={dom_id} />
      </section>
    </Layouts.app>
    """
  end

  def course_card(assigns) do
    ~H"""
    <div
      class="card w-80 bg-base-100 shadow-md rounded-xl transition-transform duration-300 hover:scale-105 hover:shadow-xl"
      id={@id}
    >
      <figure class="relative w-full aspect-video overflow-hidden rounded-t-xl">
        <.link navigate={~p"/courses/#{@course.slug}"}>
          <img
            src={@course.image}
            alt={@course.title}
            class="object-cover w-full h-full transition-transform duration-300 hover:scale-110"
          />
        </.link>
      </figure>
      <div class="card-body p-4 space-y-2">
        <div class="flex items-center gap-3">
          <img
            src={@course.university.logo}
            alt="Universidade"
            class="w-7 h-7 rounded bg-base-200 border"
          />
          <h2 class="card-title text-base font-semibold leading-snug flex-1 truncate">
            {@course.title}
          </h2>
        </div>
        <p class="text-sm text-gray-600 line-clamp-2">
          A card component has a figure, a body part, and inside body there are title and actions parts
        </p>
      </div>
    </div>
    """
  end
end
