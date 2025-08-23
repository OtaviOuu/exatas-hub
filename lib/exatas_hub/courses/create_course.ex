defmodule ExatasHub.Courses.CreateCourse do
  alias ExatasHub.Repo
  alias ExatasHub.Courses.Course
  alias ExatasHub.Accounts.Scope

  def call(%Scope{} = _scope, attrs) do
    attrs
    |> Course.changeset()
    |> Repo.insert()
  end
end
