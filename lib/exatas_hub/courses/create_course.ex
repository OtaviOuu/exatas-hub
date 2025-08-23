defmodule ExatasHub.Courses.CreateCourse do
  alias ExatasHub.Repo
  alias ExatasHub.Courses.Course
  alias ExatasHub.Accounts.Scope

  def call(%Scope{} = scope, attrs) do
    if scope.user.admin? do
      attrs
      |> Course.changeset()
      |> Repo.insert()
    else
      {:error, :unauthorized}
    end
  end
end
