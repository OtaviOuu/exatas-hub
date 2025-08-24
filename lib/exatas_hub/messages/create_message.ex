defmodule ExatasHub.Messages.CreateMessage do
  alias ExatasHub.Repo
  alias ExatasHub.Messages
  alias ExatasHub.Messages.Message

  def call(user_scope, attrs) do
    %Message{user_id: user_scope.user.id}
    |> Messages.get_message_changeset(attrs, user_scope)
    |> Repo.insert()
  end
end
