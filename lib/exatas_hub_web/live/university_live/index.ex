defmodule ExatasHubWeb.UniversityLive.Index do
  use ExatasHubWeb, :live_view

  alias ExatasHub.Universities

  def mount(_params, _session, socket) do
    univerisities = Universities.get_all_universities()

    {:ok, assign(socket, universities: univerisities)}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <section class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6 mt-6">
        <img
          :for={university <- @universities}
          class="mx-auto"
          src={university.logo}
          alt={university.name}
        />
      </section>
    </Layouts.app>
    """
  end
end
