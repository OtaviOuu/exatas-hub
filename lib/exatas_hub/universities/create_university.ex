defmodule ExatasHub.Universities.CreateUniversity do
  alias ExatasHub.Repo
  alias ExatasHub.Universities.University
  alias ExatasHub.Accounts.Scope

  def call(%Scope{} = _scope, attrs) do
    attrs
    |> University.changeset()
    |> Repo.insert()
  end
end
