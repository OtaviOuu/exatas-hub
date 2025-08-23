defmodule ExatasHub.Universities do
  alias ExatasHub.Universities.GetAllUniversities

  defdelegate get_all_universities(), to: GetAllUniversities, as: :call
end
