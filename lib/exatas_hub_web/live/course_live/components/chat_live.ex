defmodule ExatasHubWeb.CourseLive.Components.ChatLive do
  use ExatasHubWeb, :live_component

  alias ExatasHub.Messages
  alias ExatasHub.Messages.Message

  def update(assigns, socket) do
    course = assigns.course
    if connected?(socket), do: Messages.subscribe("course:#{course.id}")

    current_scope = assigns.current_scope

    message_change = Messages.get_message_changeset(%Message{user_id: current_scope.user.id}, %{}, current_scope)

    socket =
      socket
      |> assign(form: to_form(message_change))
      |> assign(component_id: assigns.id)
      |> assign(course_messages: assigns.messages)
      |> assign(current_scope: current_scope)
      |> assign(course: course)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="card w-full bg-base-100 shadow-xl border border-base-300" id={@component_id}>
      <div class="card-body p-5">
        <div class="flex items-center justify-between mb-2">
          <h2 class="card-title text-primary font-bold flex items-center gap-2">
            <.icon name="hero-chat-bubble-left-right" class="h-5 w-5" /> Comentários
          </h2>
          <span class="badge badge-primary badge-sm">Online</span>
        </div>
        <div class="flex-1 overflow-y-auto max-h-96 pr-2">
          <.message :for={message <- @course_messages} message={message} />
        </div>
        <.form for={@form} phx-submit="send_message" phx-target={@myself} phx-change="validate">
          <.input field={@form[:text]} type="textarea" placeholder="Escreva uma mensagem..." phx-debounce="500" />
          <.button type="submit">Enviar</.button>
        </.form>
      </div>
    </div>
    """
  end

  def handle_event("validate", %{"message" => message_params}, socket) do
    scope = socket.assigns.current_scope

    message_change =
      Messages.get_message_changeset(
        %Message{user_id: scope.user.id},
        message_params,
        scope
      )

    {:noreply, assign(socket, form: to_form(message_change, action: :validate))}
  end

  def handle_event("send_message", %{"message" => message_params}, socket) do
    scope = socket.assigns.current_scope

    message_params =
      message_params
      |> Map.put("course_id", socket.assigns.course.id)

    case Messages.create_message(scope, message_params) do
      {:ok, _message} ->
        {:noreply,
         assign(socket, form: to_form(Messages.get_message_changeset(%Message{user_id: scope.user.id}, %{}, scope)))}

      {:error, changeset} ->
        {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
    end
  end

  def message(assigns) do
    ~H"""
    <div class="chat chat-start mb-3">
      <div class="chat-header text-xs flex items-center mb-1">
        <span class="font-medium text-info">{@message.user.email}</span>
        <span class="text-xs opacity-60 ml-2">
          • {@message.inserted_at |> Calendar.strftime("%d/%m/%Y %H:%M")}
        </span>
      </div>
      <div class="chat-bubble chat-bubble-info">{@message.text}</div>
    </div>
    """
  end
end
