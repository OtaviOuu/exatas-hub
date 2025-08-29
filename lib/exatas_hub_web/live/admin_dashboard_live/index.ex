defmodule ExatasHubWeb.AdminDashboardLive.Index do
  use ExatasHubWeb, :live_view

  alias ExatasHub.Courses

  def mount(_params, _session, socket) do
    {:ok, stream(socket, :courses, Courses.get_all_courses())}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <div class="max-w-6xl mx-auto px-4 py-8">
        <h1 class="text-3xl font-bold mb-6">Painel Administrativo</h1>
        <.course_table courses={@streams.courses} />
      </div>
    </Layouts.app>
    """
  end

  def course_table(assigns) do
    ~H"""
    <div class="overflow-x-auto">
      <table class="table">
        <!-- head -->
        <thead>
          <tr>
            <th></th>
            <th>Data de criação</th>
            <th>videos</th>
            <th></th>
          </tr>
        </thead>
        <tbody id="course-table-body" phx-update="stream">
          <.link navigate={~p"/courses/new"} class="badge badge-accent">Criar Curso</.link>
          <tr :for={{dom_id, course} <- @courses} id={dom_id}>
            <td>
              <div class="flex items-center gap-3">
                <div class="avatar">
                  <div class="mask mask-squircle h-12 w-12">
                    <img src={course.image} />
                  </div>
                </div>
                <div>
                  <div class="font-bold">{course.title}</div>
                  <div class="text-sm opacity-50">{course.university.name}</div>
                </div>
              </div>
            </td>
            <td>
              {course.inserted_at}
            </td>
            <td>1</td>
            <th>
              <button
                class="btn btn-ghost btn-xs"
                phx-click="delete_course"
                phx-value-id={course.id}
                phx-confirm="Tem certeza?"
              >
                <.icon name="hero-trash" /> Delete
              </button>
            </th>
          </tr>
        </tbody>
      </table>
    </div>
    """
  end

  def handle_event("delete_course", %{"id" => id}, socket) do
    case Courses.delete_course(id) do
      {:ok, course} ->
        socket =
          socket
          |> stream_delete(:courses, course)
          |> put_flash(:info, "Curso deletado com sucesso!")

        {:noreply, socket}

      {:error, _reason} ->
        {:noreply, socket}
    end
  end
end
