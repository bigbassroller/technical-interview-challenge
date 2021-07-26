defmodule VetspireApp.Repo do
  use Ecto.Repo,
    otp_app: :vetspire_app,
    adapter: Ecto.Adapters.Postgres
end
