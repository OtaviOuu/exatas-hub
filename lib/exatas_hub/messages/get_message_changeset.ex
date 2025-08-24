defmodule ExatasHub.Messages.GetMessageChangeset do
  alias ExatasHub.Messages.Message

  def call(message, attrs, user_scope) do
    true = message.user_id == user_scope.user.id

    Message.changeset(message, attrs, user_scope)
  end
end
