defmodule ExatasHub.Youtube.GetAllVideosFromPlaylist do
  @api_key Application.get_env(:exatas_hub, :youtube_api_key)

  def call(playlist_link) do
    IO.inspect(playlist_link, label: "Playlist Link")

    playlist_id =
      playlist_link
      |> String.split("?list=")
      |> List.last()

    IO.inspect(playlist_id, label: "Playlist ID")

    Req.get!(playlist_api(playlist_id)).body["items"]
    |> usefull_data()
  end

  defp usefull_data(json) do
    videos =
      json
      |> Enum.map(fn item ->
        %{
          title: item["snippet"]["title"],
          description: item["snippet"]["description"],
          published_at: item["snippet"]["publishedAt"],
          channel_title: item["snippet"]["channelTitle"],
          position: item["snippet"]["position"],
          thumbnail: item["snippet"]["thumbnails"]["high"]["url"],
          video_id: item["snippet"]["resourceId"]["videoId"]
        }
      end)

    videos
  end

  defp playlist_api(id) do
    "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=#{id}&maxResults=50&key=#{@api_key}"
  end
end
