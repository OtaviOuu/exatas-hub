defmodule ExatasHubWeb.CourseLive.Playlist do
  use ExatasHubWeb, :live_view
  alias ExatasHub.Youtube

  def mount(%{"id" => playlist_id, "slug" => playlist_slug}, _session, socket) do
    socket =
      socket
      |> assign(:playlist_id, playlist_id)
      |> assign(:playlist_slug, playlist_slug)
      |> assign_async(:videos, fn ->
        videos = Youtube.get_all_videos_from_playlist()
        {:ok, %{videos: videos}}
      end)

    {:ok, socket}
  end

  def handle_params(%{"video" => video_id}, _uri, socket) do
    socket =
      socket
      |> assign(:video_id, video_id)

    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app_sidebar
      current_scope={@current_scope}
      flash={@flash}
      videos={@videos}
      playlist_id={@playlist_id}
      course={@playlist_slug}
    >
      <iframe
        class="w-full aspect-video"
        src={"https://www.youtube.com/embed/#{@video_id}"}
        title="YouTube video player"
        frameborder="0"
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
        allowfullscreen
      >
      </iframe>
    </Layouts.app_sidebar>
    """
  end

  def handle_event("select_video", %{"video-id" => video_id}, socket) do
    slug = socket.assigns.playlist_slug
    playlist_id = socket.assigns.playlist_id

    {:noreply,
     push_patch(socket,
       to: ~p"/courses/#{slug}/playlist/#{playlist_id}/?video=#{video_id}"
     )}
  end
end
