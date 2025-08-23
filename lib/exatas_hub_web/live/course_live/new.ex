defmodule ExatasHubWeb.CourseLive.New do
  alias ExatasHub.Universities
  use ExatasHubWeb, :live_view

  alias ExatasHub.Courses

  alias ExatasHub.Courses.Course

  def mount(_params, _session, socket) do
    course_change = Courses.get_course_changeset(%Course{}, %{})
    universities = Universities.get_all_universities()
    {:ok, assign(socket, form: to_form(course_change, as: :course), universities: universities)}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.form for={@form} phx-submit="save" phx-change="validate">
        <.input field={@form[:title]} type="text" label="Title" phx-debounce="blur" />
        <.input field={@form[:image]} type="text" label="Image" phx-debounce="blur" />
        <.input
          field={@form[:university_id]}
          type="select"
          label="University"
          phx-debounce="blur"
          options={for university <- @universities, do: {university.name, university.id}}
        />
        <.button phx-disable-with="Saving...">Save</.button>
      </.form>
    </Layouts.app>
    """
  end

  def handle_event("validate", %{"course" => course_params}, socket) do
    course_change =
      %Course{}
      |> Courses.get_course_changeset(course_params)

    {:noreply, assign(socket, form: to_form(course_change, action: :validate))}
  end

  def handle_event("save", %{"course" => course_params}, socket) do
    user_scope = socket.assigns.current_scope

    case Courses.create_course(user_scope, course_params) do
      {:ok, _course} ->
        {:noreply, redirect(socket, to: "/courses")}

      {:error, changeset} ->
        {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
    end
  end
end
