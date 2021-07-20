defmodule Aluraflix.Repo do
  use Ecto.Repo,
    otp_app: :aluraflix,
    adapter: Ecto.Adapters.Postgres
end
