defmodule LiveRushing.Repo do
  use Ecto.Repo,
    otp_app: :live_rushing,
    adapter: Ecto.Adapters.Postgres
end
