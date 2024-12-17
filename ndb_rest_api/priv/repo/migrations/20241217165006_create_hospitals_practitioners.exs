defmodule NdbRestApi.Repo.Migrations.CreateHospitalsPractitioners do
  use Ecto.Migration

  def change do
    create table(:hospitals_practitioners) do
      add :hospital_id, references(:hospitals, on_delete: :delete_all)
      add :practitioner_id, references(:practitioners, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:hospitals_practitioners, [:hospital_id])
    create index(:hospitals_practitioners, [:practitioner_id])
    create unique_index(:hospitals_practitioners, [:hospital_id, :practitioner_id])
  end
end
