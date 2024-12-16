defmodule NdbRestApi.Repo.Migrations.CreateConditions do
  use Ecto.Migration

  def change do
    create table(:conditions) do
      add :date_time, :utc_datetime
      add :comment, :text
      add :patient_id, references(:patients, on_delete: :nothing)
      add :practitioner_id, references(:practitioners, on_delete: :nothing)
      add :hospital_id, references(:hospitals, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:conditions, [:patient_id])
    create index(:conditions, [:practitioner_id])
    create index(:conditions, [:hospital_id])
  end
end
