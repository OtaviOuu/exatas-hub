defmodule ExatasHubWeb.UniversityLive.New do
  use ExatasHubWeb, :live_view

  alias ExatasHub.Universities
  alias ExatasHub.Universities.University

  def mount(_params, _session, socket) do
    university = Universities.get_university_changeset()
    {:ok, assign(socket, form: to_form(university))}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.form for={@form} phx-submit="save" phx-change="validate">
        <.input field={@form[:name]} type="text" label="Name" phx-debounce="blur" />
        <.input field={@form[:logo]} type="text" label="Logo" phx-debounce="blur" />
        <.input field={@form[:initialism]} type="text" label="Initialism" phx-debounce="blur" />
        <.button phx-disable-with="Saving...">Save</.button>
      </.form>
    </Layouts.app>
    """
  end

  def handle_event("validate", %{"university" => university_params}, socket) do
    university_change =
      %University{}
      |> Universities.get_university_changeset(university_params)

    {:noreply, assign(socket, form: to_form(university_change, action: :validate))}
  end

  def handle_event("save", %{"university" => university_params}, socket) do
    user_scope = socket.assigns.current_scope

    case Universities.create_university(user_scope, university_params) do
      {:ok, _university} ->
        {:noreply, redirect(socket, to: "/universities")}

      {:error, changeset} ->
        {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
    end
  end
end
