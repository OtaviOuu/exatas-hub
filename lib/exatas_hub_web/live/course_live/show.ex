defmodule ExatasHubWeb.CourseLive.Show do
  use ExatasHubWeb, :live_view

  alias ExatasHub.Courses
  alias ExatasHubWeb.CourseLive.Components.ChatLive
  alias ExatasHub.Messages

  def mount(params, _session, socket) do
    course = Courses.get_course_by_slug(params["slug"])
    course_messages = Messages.get_all_messages(course.id)

    socket =
      socket
      |> assign(course: course)
      |> assign(course_messages: course_messages)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <section class="max-w-6xl mx-auto mt-10 px-2 md:px-0">
        <div class="flex flex-col md:flex-row gap-8">
          <!-- Esquerda: Detalhes do curso -->
          <div class="flex-1 min-w-0">
            <h1 class="text-3xl md:text-4xl font-bold text-base-content mb-4">{@course.title}</h1>
            <div class="flex items-center gap-3 mb-6">
              <img
                src={@course.university.logo}
                alt="Universidade"
                class="w-10 h-10 rounded bg-base-100 border-2 border-base-200 shadow"
              />
              <span class="text-base-content font-medium text-lg">Universidade</span>
            </div>
            <div class="mb-8">
              <span class="inline-block bg-primary/10 text-primary text-xs font-semibold mr-2 px-2.5 py-0.5 rounded">
                Novo
              </span>
              <span class="inline-block bg-success/10 text-success text-xs font-semibold mr-2 px-2.5 py-0.5 rounded">
                100% online
              </span>
            </div>
            <div class="prose max-w-none mb-8 text-base-content">
              <h2 class="text-xl font-semibold mb-2">Sobre o curso</h2>
              Adicione aqui uma descrição detalhada do curso, conteúdos, objetivos e diferenciais.
            </div>
            <ul class="mb-8 space-y-2">
              <li class="flex items-center text-base-content">
                <svg
                  class="w-5 h-5 mr-2 text-primary"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="2"
                  viewBox="0 0 24 24"
                >
                  <path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7" />
                </svg>
                Certificado de conclusão
              </li>
              <li class="flex items-center text-base-content">
                <svg
                  class="w-5 h-5 mr-2 text-primary"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="2"
                  viewBox="0 0 24 24"
                >
                  <path stroke-linecap="round" stroke-linejoin="round" d="M12 8v4l3 3" />
                </svg>
                Acesso vitalício
              </li>
              <li class="flex items-center text-base-content">
                <svg
                  class="w-5 h-5 mr-2 text-primary"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="2"
                  viewBox="0 0 24 24"
                >
                  <circle cx="12" cy="12" r="10" /><path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    d="M12 6v6l4 2"
                  />
                </svg>
                Carga horária: 40h
              </li>
            </ul>

            <div class="mb-10">
              <h2 class="text-2xl font-bold mb-6 flex items-center gap-2">
                <.icon name="hero-play-circle" class="w-6 h-6 text-primary" /> Playlist do Curso
              </h2>

              <div class="grid grid-cols-1 gap-4 h-96 overflow-y-auto p-2 space-y-2">
                <.link
                  :for={_1 <- 1..10}
                  navigate={~p"/courses/#{@course.slug}/playlist/"}
                  class="card bg-base-100 border border-base-300 shadow-sm hover:shadow-md hover:border-primary/50 transition-all "
                >
                  <div class="card-body p-4">
                    <div class="flex gap-3">
                      <div class="relative w-32 h-20 flex-shrink-0 bg-base-300 rounded-lg overflow-hidden">
                        <div class="absolute inset-0 flex items-center justify-center bg-black/10">
                          <.icon name="hero-play" class="w-8 h-8 text-white/80 drop-shadow-md" />
                        </div>
                        <div class="absolute bottom-1 right-1 bg-black/70 text-white text-xs px-1 rounded">
                          18:45
                        </div>
                      </div>
                      <div class="flex-1">
                        <h3 class="font-semibold text-base-content">2. Fundamentos Teóricos</h3>
                        <p class="text-sm text-base-content/70">Conceitos básicos e terminologia</p>
                        <div class="flex items-center mt-2 text-xs text-base-content/60">
                          <.icon name="hero-clock" class="w-4 h-4 mr-1" /> Pendente
                        </div>
                      </div>
                    </div>
                  </div>
                </.link>
              </div>
            </div>
          </div>
          
    <!-- Direita: Card de inscrição -->
          <div class="w-full md:w-96 flex-shrink-0">
            <div class="bg-base-100 rounded-xl shadow-lg border border-base-200 overflow-hidden">
              <img src={@course.image} alt={@course.title} class="w-full h-48 object-cover border-b" />
              <div class="p-6 flex flex-col gap-4">
                <button class="w-full py-3 px-4 rounded-lg bg-primary hover:bg-primary-focus text-primary-content font-semibold text-lg transition">
                  Acessar
                </button>
              </div>
            </div>
            <div class="my-8">
              <.live_component
                module={ChatLive}
                id="chat"
                current_scope={@current_scope}
                course={@course}
                messages={@course_messages}
              />
            </div>
          </div>
        </div>
      </section>
    </Layouts.app>
    """
  end

  def handle_info({:new_message, message}, socket) do
    new_messages = socket.assigns.course_messages ++ [message]

    {:noreply, update(socket, :course_messages, fn _ -> new_messages end)}
  end
end
