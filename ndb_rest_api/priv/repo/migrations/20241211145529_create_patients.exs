defmodule NdbRestApi.Repo.Migrations.CreatePatients do
  use Ecto.Migration

  def change do
    create table(:patients) do
      add :firstname, :string
      add :lastname, :string
      add :cf, :string
      add :date_of_birth, :date
      add :gender_id, references(:genders, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:patients, [:gender_id])
  end
end
