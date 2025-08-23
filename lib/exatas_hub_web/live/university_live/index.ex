defmodule ExatasHubWeb.UniversityLive.Index do
  use ExatasHubWeb, :live_view

  alias ExatasHub.Universities

  def mount(_params, _session, socket) do
    universities = Universities.get_all_universities()

    socket =
      socket
      |> stream(:universities, universities)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <section
        class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6 mt-6"
        id="universities-grid"
        phx-update="stream"
      >
        <.university_card :for={{dom_id, university} <- @streams.universities} university={university} id={dom_id} />
      </section>
    </Layouts.app>
    """
  end

  def university_card(assigns) do
    ~H"""
    <div class="card bg-base-100 w-96 shadow-sm" id={@id}>
      <figure class="h-40 w-full overflow-hidden">
        <img
          src={@university.logo}
          alt={@university.name}
          class="w-full h-full object-cover"
        />
      </figure>
      <div class="card-body">
        <h2 class="card-title">{@university.name}</h2>
      </div>
    </div>
    """
  end
end
