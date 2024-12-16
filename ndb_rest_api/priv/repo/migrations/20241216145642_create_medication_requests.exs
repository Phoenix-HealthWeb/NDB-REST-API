defmodule NdbRestApi.Repo.Migrations.CreateMedicationRequests do
  use Ecto.Migration

  def change do
    create table(:medication_requests) do
      add :date_time, :utc_datetime
      add :expiration_date, :date
      add :medication, :string
      add :posology, :text
      add :patient_id, references(:patients, on_delete: :nothing)
      add :practitioner_id, references(:practitioners, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:medication_requests, [:patient_id])
    create index(:medication_requests, [:practitioner_id])
  end
end
