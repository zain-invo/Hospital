defmodule Hospital.Repo do
  use Ecto.Repo,
    otp_app: :hospital,
    adapter: Ecto.Adapters.Postgres
end
