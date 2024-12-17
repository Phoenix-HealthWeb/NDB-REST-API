defmodule NdbRestApi.Repo.Migrations.CreateHospitals do
  use Ecto.Migration

  def change do
    create table(:hospitals) do
      add :name, :string
      add :address, :string
      add :region, :string
      add :notes, :string
      add :api_key, :string

      timestamps(type: :utc_datetime)
    end
  end
end
