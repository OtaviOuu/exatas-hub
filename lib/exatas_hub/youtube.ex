defmodule ExatasHub.Youtube do
  defdelegate get_all_videos_from_playlist(), to: ExatasHub.Youtube.GetAllVideosFromPlaylist, as: :call
end
