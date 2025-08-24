defmodule ExatasHub.Messages do
  alias ExatasHub.Messages.GetMessageChangeset
  alias ExatasHub.Messages.CreateMessage
  alias ExatasHub.Messages.GetAllMessages

  defdelegate get_message_changeset(message, attrs, user_scope), to: GetMessageChangeset, as: :call
  defdelegate create_message(user_scope, attrs), to: CreateMessage, as: :call
  defdelegate get_all_messages(course_id), to: GetAllMessages, as: :call
  defdelegate subscribe(topic), to: ExatasHub.Messages.PubSub, as: :subscribe
  defdelegate broadcast(topic, message), to: ExatasHub.Messages.PubSub, as: :broadcast
end
