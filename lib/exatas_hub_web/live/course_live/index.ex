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
      <h1 class="text-2xl font-bold text-base-content mb-4">Courses</h1>
      <section
        class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6 mt-6 px-3 sm:px-0"
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
      id={@id}
      class="card w-full sm:w-auto bg-base-100 shadow-md rounded-xl transition-transform duration-300 hover:scale-105 hover:shadow-xl"
    >
      <!-- Imagem -->
      <figure class="relative w-full aspect-video overflow-hidden rounded-t-xl">
        <.link navigate={~p"/courses/#{@course.slug}"}>
          <img
            src={@course.image}
            alt={@course.title}
            class="object-cover w-full h-full transition-transform duration-300 hover:scale-110"
          />
        </.link>
      </figure>
      
    <!-- Conteúdo -->
      <div class="card-body p-3 sm:p-4 space-y-2">
        <div class="flex items-center gap-3">
          <img
            src={@course.university.logo}
            alt="Universidade"
            class="w-6 h-6 sm:w-7 sm:h-7 rounded bg-base-200 border"
          />
          <h2 class="card-title text-sm sm:text-base font-semibold leading-snug flex-1 truncate">
            {@course.title}
          </h2>
        </div>
        <p class="text-xs sm:text-sm text-gray-600 line-clamp-2">
          A card component has a figure, a body part, and inside body there are title and actions parts
        </p>
      </div>
    </div>
    """
  end
end
