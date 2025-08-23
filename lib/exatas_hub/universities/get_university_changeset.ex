defmodule ExatasHub.Universities.GetUniversityChangeset do
  alias ExatasHub.Universities.University

  def call(university \\ %University{}, attrs \\ %{}) do
    university
    |> University.changeset(attrs)
  end
end
