defmodule ExatasHubWeb.PageRedirectController do
  use ExatasHubWeb, :controller

  def to_courses(conn, _params) do
    redirect(conn, to: "/courses")
  end
end
