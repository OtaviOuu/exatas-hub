defmodule ExatasHub.Repo do
  use Ecto.Repo,
    otp_app: :exatas_hub,
    adapter: Ecto.Adapters.SQLite3
end
