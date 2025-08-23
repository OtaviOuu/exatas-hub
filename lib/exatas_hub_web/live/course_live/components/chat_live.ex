defmodule ExatasHubWeb.CourseLive.Components.ChatLive do
  use ExatasHubWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="card w-full bg-base-100 shadow-xl border border-base-300">
      <div class="card-body p-5">
        <div class="flex items-center justify-between mb-2">
          <h2 class="card-title text-primary font-bold flex items-center gap-2">
            <.icon name="hero-chat-bubble-left-right" class="h-5 w-5" /> Comentários
          </h2>
          <span class="badge badge-primary badge-sm">Online</span>
        </div>
        <div class="flex-1 overflow-y-auto max-h-96 pr-2">
          <.message :for={_i <- 1..30} />
        </div>
      </div>
    </div>
    """
  end

  def message(assigns) do
    ~H"""
    <div class="chat chat-start mb-3">
      <div class="chat-header text-xs flex items-center mb-1">
        <span class="font-medium text-info">coordenador@exatas.edu</span>
        <span class="text-xs opacity-60 ml-2">• 10 min atrás</span>
      </div>
      <div class="chat-bubble chat-bubble-info">Lembrem-se de entregar as atividades até sexta!</div>
    </div>
    """
  end
end
