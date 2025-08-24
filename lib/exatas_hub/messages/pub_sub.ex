defmodule ExatasHub.Messages.PubSub do
  alias Phoenix.PubSub

  def subscribe(topic) do
    PubSub.subscribe(ExatasHub.PubSub, topic)
  end

  def broadcast(topic, message) do
    PubSub.broadcast(ExatasHub.PubSub, topic, message)
  end
end
