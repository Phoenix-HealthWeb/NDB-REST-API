defmodule NdbRestApi.Repo.Migrations.AddDefaultGenders do
  use Ecto.Migration

  def change do
    execute("""
    INSERT INTO genders (id, name, inserted_at, updated_at)
    VALUES
      (1, 'Male', NOW(), NOW()),
      (2, 'Female', NOW(), NOW()),
      (3, 'Not specified', NOW(), NOW())
    """)
  end
end
