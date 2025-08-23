defmodule ExatasHub.Universities.GetAllUniversities do
  alias ExatasHub.Repo
  alias ExatasHub.Universities.University

  def call() do
    University
    |> Repo.all()
  end
end
