defmodule NdbRestApi.Repo do
  use Ecto.Repo,
    otp_app: :ndb_rest_api,
    adapter: Ecto.Adapters.Postgres
end
