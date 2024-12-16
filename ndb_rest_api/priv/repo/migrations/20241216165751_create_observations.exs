defmodule NdbRestApi.Repo.Migrations.CreateObservations do
  use Ecto.Migration

  def change do
    create table(:observations) do
      add :ward, :text
      add :date_time, :utc_datetime
      add :result, :text
      add :patient_id, references(:patients, on_delete: :nothing)
      add :practitioner_id, references(:practitioners, on_delete: :nothing)
      add :hospital_id, references(:hospitals, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:observations, [:patient_id])
    create index(:observations, [:practitioner_id])
    create index(:observations, [:hospital_id])
  end
end
