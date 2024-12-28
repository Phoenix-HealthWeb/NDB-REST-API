defmodule NdbRestApi.Repo.Migrations.AddDefaultHospitalsPractitioners do
  use Ecto.Migration

  def change do
    execute("""
    INSERT INTO hospitals_practitioners (hospital_id, practitioner_id)
    VALUES
      (1, 1),
      (1, 2),
      (2, 3),
      (2, 4),
      (3, 5),
      (3, 6),
      (4, 7),
      (4, 8),
      (5, 9),
      (5, 10),
      (6, 11),
      (6, 12),
      (7, 13),
      (7, 14),
      (8, 15),
      (8, 16),
      (9, 17),
      (9, 18),
      (10, 19),
      (10, 20);
    """)
  end
end
