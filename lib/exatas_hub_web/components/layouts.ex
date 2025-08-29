defmodule ExatasHubWeb.Layouts do
  @moduledoc """
  This module holds layouts and related functionality
  used by your application.
  """
  use ExatasHubWeb, :html

  # Embed all files in layouts/* within this module.
  # The default root.html.heex file contains the HTML
  # skeleton of your application, namely HTML headers
  # and other static content.
  embed_templates "layouts/*"

  @doc """
  Renders your app layout.

  This function is typically invoked from every template,
  and it often contains your application menu, sidebar,
  or similar.

  ## Examples

      <Layouts.app flash={@flash}>
        <h1>Content</h1>
      </Layouts.app>

  """
  attr :flash, :map, required: true, doc: "the map of flash messages"

  attr :current_scope, :map,
    default: nil,
    doc: "the current [scope](https://hexdocs.pm/phoenix/scopes.html)"

  slot :inner_block, required: true

  def app(assigns) do
    ~H"""
    <header class="navbar bg-base-100 shadow-sm px-4 sm:px-6 lg:px-8 sticky top-0 z-50">
      <div class="flex-1">
        <.link navigate="/" class="flex items-center gap-2 hover:opacity-80 transition">
          <img src={~p"/images/logo.svg"} width="36" />
          <span class="text-base font-bold">ExatasHub</span>
        </.link>
      </div>

      <nav class="hidden md:flex items-center space-x-4">
        <%= if @current_scope do %>
          <span class="text-sm text-gray-600">{@current_scope.user.email}</span>
          <.link :if={@current_scope.user.admin?} navigate={~p"/admin"} class="btn btn-ghost btn-sm">Admin</.link>
          <.link navigate={~p"/users/settings"} class="btn btn-ghost btn-sm">Settings</.link>
          <.link href={~p"/users/log-out"} method="delete" class="btn btn-ghost btn-sm">Log out</.link>
        <% else %>
          <.link navigate={~p"/users/register"} class="btn btn-ghost btn-sm">Register</.link>
          <.link navigate={~p"/users/log-in"} class="btn btn-ghost btn-sm">Log in</.link>
        <% end %>
        <.link navigate={~p"/courses"} class="btn btn-ghost btn-sm">Courses</.link>
        <.link navigate={~p"/universities"} class="btn btn-ghost btn-sm">Universities</.link>
      </nav>

      <div class="md:hidden">
        <details class="dropdown dropdown-end">
          <summary class="btn btn-ghost btn-sm">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
            </svg>
          </summary>
          <ul class="menu menu-sm dropdown-content mt-2 p-2 shadow bg-base-100 rounded-box w-52 space-y-1">
            <%= if @current_scope do %>
              <li class="text-sm px-2 py-1 text-gray-600">{@current_scope.user.email}</li>
              <li><.link navigate={~p"/users/settings"}>Settings</.link></li>
              <li><.link href={~p"/users/log-out"} method="delete">Log out</.link></li>
            <% else %>
              <li><.link navigate={~p"/users/register"}>Register</.link></li>
              <li><.link navigate={~p"/users/log-in"}>Log in</.link></li>
            <% end %>
            <li><.link navigate={~p"/courses"}>Courses</.link></li>
            <li><.link navigate={~p"/universities"}>Universities</.link></li>
          </ul>
        </details>
      </div>
    </header>

    <main class="container mx-auto px-4 py-6 md:py-10">
      {render_slot(@inner_block)}
    </main>

    <.flash_group flash={@flash} />
    """
  end

  def app_sidebar(assigns) do
    ~H"""
    <div class="flex">
      <aside
        id="default-sidebar"
        class="fixed top-0 left-0 z-40 w-64 h-screen transition-transform -translate-x-full sm:translate-x-0"
        aria-label="Sidenav"
      >
        <div class="overflow-y-auto py-5 px-3 h-full bg-white border-r border-gray-200 dark:bg-gray-800 dark:border-gray-700">
          <h2 class="top-0 bg-white dark:bg-gray-800 z-50 py-2 mb-4 border-b border-gray-200 dark:border-gray-700 ">
            <div class="flex justify-start items-center">
              <.link
                navigate={~p"/courses/#{@slug}"}
                class="flex items-center gap-2 w-fit text-gray-700 dark:text-gray-200 hover:text-primary transition-colors duration-300 transform hover:translate-x-1"
              >
                <.icon name="hero-arrow-left" class="w-5 h-5" /> Voltar
              </.link>
            </div>
          </h2>

          <ul class="space-y-2">
            <.async_result :let={videos} assign={@videos}>
              <:loading>
                <div class="flex justify-center items-center h-32">
                  <span class="loading loading-spinner text-success"></span>
                </div>
              </:loading>
              <:failed :let={_failure}>there was an error loading the videos</:failed>
              <%= if videos do %>
                <li :for={video <- videos}>
                  <div
                    phx-click="select_video"
                    phx-value-video-id={video.video_id}
                    class="flex items-center p-2 text-base font-normal text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700 group cursor-pointer "
                  >
                    <span class="ml-3">
                      <.icon name="hero-video-camera" class="w-5 h-5 text-gray-600 mr-3" />{video.title}
                    </span>
                  </div>
                </li>
              <% else %>
                Playlist sem vídeos
              <% end %>
            </.async_result>
          </ul>
        </div>
      </aside>
      <!-- Conteúdo principal -->
      <main class="flex-1 ml-64 p-6">
        {render_slot(@inner_block)}
        <.flash_group flash={@flash} />
      </main>
    </div>
    """
  end

  @doc """
  Shows the flash group with standard titles and content.

  ## Examples

      <.flash_group flash={@flash} />
  """
  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :id, :string, default: "flash-group", doc: "the optional id of flash container"

  def flash_group(assigns) do
    ~H"""
    <div id={@id} aria-live="polite">
      <.flash kind={:info} flash={@flash} />
      <.flash kind={:error} flash={@flash} />

      <.flash
        id="client-error"
        kind={:error}
        title={gettext("We can't find the internet")}
        phx-disconnected={show(".phx-client-error #client-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#client-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>

      <.flash
        id="server-error"
        kind={:error}
        title={gettext("Something went wrong!")}
        phx-disconnected={show(".phx-server-error #server-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#server-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>
    </div>
    """
  end

  @doc """
  Provides dark vs light theme toggle based on themes defined in app.css.

  See <head> in root.html.heex which applies the theme before page load.
  """
  def theme_toggle(assigns) do
    ~H"""
    <div class="card relative flex flex-row items-center border-2 border-base-300 bg-base-300 rounded-full">
      <div class="absolute w-1/3 h-full rounded-full border-1 border-base-200 bg-base-100 brightness-200 left-0 [[data-theme=light]_&]:left-1/3 [[data-theme=dark]_&]:left-2/3 transition-[left]" />

      <button
        class="flex p-2 cursor-pointer w-1/3"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="system"
      >
        <.icon name="hero-computer-desktop-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>

      <button
        class="flex p-2 cursor-pointer w-1/3"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="light"
      >
        <.icon name="hero-sun-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>

      <button
        class="flex p-2 cursor-pointer w-1/3"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="dark"
      >
        <.icon name="hero-moon-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>
    </div>
    """
  end
end
