defmodule NdbRestApi.Repo.Migrations.AddDefaultPractitionerRoles do
  use Ecto.Migration

  def change do
    execute("""
    INSERT INTO practitioner_roles (id, name, inserted_at, updated_at)
    VALUES
      (1, 'Doctor', NOW(), NOW()),
      (2, 'Nurse', NOW(), NOW()),
      (3, 'Therapist', NOW(), NOW()),
      (4, 'Pharmacist', NOW(), NOW()),
      (5, 'Technician', NOW(), NOW())
    """)
  end
end
