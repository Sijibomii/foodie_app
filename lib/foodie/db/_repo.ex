defmodule Foodie.Repo do
  use Ecto.Repo,
    otp_app: :foodie,
    adapter: Ecto.Adapters.Postgres
end
