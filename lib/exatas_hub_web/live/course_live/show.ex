defmodule ExatasHubWeb.CourseLive.Show do
  use ExatasHubWeb, :live_view

  alias ExatasHub.Courses

  def mount(params, _session, socket) do
    course = Courses.get_course_by_slug(params["slug"])

    socket =
      socket
      |> assign(course: course)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <section class="max-w-6xl mx-auto mt-10 px-2 md:px-0">
        <div class="flex flex-col md:flex-row gap-8">
          <!-- Esquerda: Detalhes do curso -->
          <div class="flex-1 min-w-0">
            <h1 class="text-3xl md:text-4xl font-bold text-base-content mb-4">{@course.title}</h1>
            <div class="flex items-center gap-3 mb-6">
              <img
                src={@course.university_logo}
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
          </div>
        </div>
      </section>
    </Layouts.app>
    """
  end
end
