defmodule ExatasHubWeb.CourseLive.Playlist do
  use ExatasHubWeb, :live_view

  def render(assigns) do
    ~H"""
    <Layouts.app_sidebar current_scope={@current_scope} flash={@flash}>
      <iframe
        class="w-full aspect-video"
        src="https://www.youtube.com/embed/3SaZj8LzHCI"
        title="YouTube video player"
        frameborder="0"
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
        allowfullscreen
      >
      </iframe>
    </Layouts.app_sidebar>
    """
  end
end
