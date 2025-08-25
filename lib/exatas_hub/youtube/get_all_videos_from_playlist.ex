defmodule ExatasHub.Youtube.GetAllVideosFromPlaylist do
  @api_key System.fetch_env!("YOUTUBE_API_KEY")
  def call() do
    IO.inspect(@api_key, label: "API KEY")

    Req.get!(playlist_api("PLIEzh1OveCVczEZAjhVIVd7Qs-X8ILgnI")).body["items"]
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
