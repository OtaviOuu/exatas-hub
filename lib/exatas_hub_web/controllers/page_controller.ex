defmodule ExatasHubWeb.PageController do
  use ExatasHubWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
