defmodule ExatasHub.Messages.GetAllMessages do
  import Ecto.Query

  alias ExatasHub.Messages.Message
  alias ExatasHub.Repo

  def call() do
    Message
    |> preload(:user)
    |> Repo.all()
  end
end
