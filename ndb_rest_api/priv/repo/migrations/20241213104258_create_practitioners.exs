defmodule NdbRestApi.Repo.Migrations.CreatePractitioners do
  use Ecto.Migration

  def change do
    create table(:practitioners) do
      add :email, :string
      add :forename, :string
      add :surname, :string
      add :date_of_birth, :date
      add :qualification, :string
      add :gender_id, references(:genders, on_delete: :nothing)
      add :role_id, references(:practitioner_roles, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:practitioners, [:email])
    create index(:practitioners, [:gender_id])
    create index(:practitioners, [:role_id])
  end
end
