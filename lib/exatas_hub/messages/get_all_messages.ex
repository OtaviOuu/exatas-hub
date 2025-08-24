defmodule ExatasHub.Messages.GetAllMessages do
  import Ecto.Query

  alias ExatasHub.Messages.Message
  alias ExatasHub.Repo

  def call(course_id) do
    Message
    |> where(course_id: ^course_id)
    |> preload([:user, :course])
    |> order_by(asc: :inserted_at)
    |> Repo.all()
  end
end
