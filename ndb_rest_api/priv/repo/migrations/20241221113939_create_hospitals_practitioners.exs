defmodule NdbRestApi.Repo.Migrations.CreateHospitalsPractitioners do
  use Ecto.Migration

  def change do
    create table(:hospitals_practitioners, primary_key: false) do
      add :hospital_id, references(:hospitals, on_delete: :nothing), primary_key: true
      add :practitioner_id, references(:practitioners, on_delete: :nothing), primary_key: true
    end

    create index(:hospitals_practitioners, [:hospital_id])
    create index(:hospitals_practitioners, [:practitioner_id])
  end
end
