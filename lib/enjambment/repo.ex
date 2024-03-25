defmodule Enjambment.Repo do
  use Ecto.Repo,
    otp_app: :enjambment,
    adapter: Ecto.Adapters.Postgres
end
