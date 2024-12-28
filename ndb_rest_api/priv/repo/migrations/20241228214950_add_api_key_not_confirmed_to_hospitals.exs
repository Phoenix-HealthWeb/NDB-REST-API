defmodule YourApp.Repo.Migrations.AddApiKeyNotConfirmedToHospitals do
  use Ecto.Migration

  def change do
    alter table(:hospitals) do
      add :api_key_not_confirmed, :string
    end
  end
end
