defmodule NdbRestApi.Repo.Migrations.CreatePractitionerRoles do
  use Ecto.Migration

  def change do
    create table(:practitioner_roles) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
