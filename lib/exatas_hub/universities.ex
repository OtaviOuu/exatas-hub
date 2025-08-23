defmodule ExatasHub.Universities do
  alias ExatasHub.Universities.GetAllUniversities
  alias ExatasHub.Universities.GetUniversityChangeset
  alias ExatasHub.Universities.CreateUniversity

  alias ExatasHub.Universities.University

  defdelegate get_all_universities(), to: GetAllUniversities, as: :call
  defdelegate create_university(scope, attrs), to: CreateUniversity, as: :call
  defdelegate get_university_changeset(university \\ %University{}, attrs \\ %{}), to: GetUniversityChangeset, as: :call
end
