defmodule NdbRestApi.Repo.Migrations.AddDefaultPractitioners do
  use Ecto.Migration

  def change do
    execute("""
    INSERT INTO practitioners (forename, surname, email, gender_id, role_id, date_of_birth, qualification, inserted_at, updated_at)
    VALUES
      ('John', 'Doe', 'john.doe@example.com', 1, 1, '1980-01-01', 'MD', NOW(), NOW()),
      ('Jane', 'Smith', 'jane.smith@example.com', 2, 1, '1985-02-02', 'RN', NOW(), NOW()),
      ('Alex', 'Taylor', 'alex.taylor@example.com', 3, 2, '1990-03-03', 'PT', NOW(), NOW()),
      ('Emily', 'Johnson', 'emily.johnson@example.com', 2, 2, '1982-04-04', 'PharmD', NOW(), NOW()),
      ('Michael', 'Brown', 'michael.brown@example.com', 1, 2, '1978-05-05', 'Tech', NOW(), NOW()),
      ('Sarah', 'Davis', 'sarah.davis@example.com', 2, 1, '1992-06-06', 'MD', NOW(), NOW()),
      ('David', 'Miller', 'david.miller@example.com', 1, 1, '1984-07-07', 'RN', NOW(), NOW()),
      ('Laura', 'Wilson', 'laura.wilson@example.com', 2, 3, '1986-08-08', 'PT', NOW(), NOW()),
      ('Robert', 'Moore', 'robert.moore@example.com', 1, 1, '1975-09-09', 'PharmD', NOW(), NOW()),
      ('Sophia', 'Taylor', 'sophia.taylor@example.com', 2, 5, '1991-10-10', 'Tech', NOW(), NOW()),
      ('James', 'Anderson', 'james.anderson@example.com', 1, 1, '1983-11-11', 'MD', NOW(), NOW()),
      ('Olivia', 'Thomas', 'olivia.thomas@example.com', 2, 2, '1987-12-12', 'RN', NOW(), NOW()),
      ('William', 'Jackson', 'william.jackson@example.com', 1, 3, '1979-01-13', 'PT', NOW(), NOW()),
      ('Isabella', 'White', 'isabella.white@example.com', 2, 4, '1993-02-14', 'PharmD', NOW(), NOW()),
      ('Benjamin', 'Harris', 'benjamin.harris@example.com', 1, 5, '1981-03-15', 'Tech', NOW(), NOW()),
      ('Mia', 'Martin', 'mia.martin@example.com', 2, 1, '1988-04-16', 'MD', NOW(), NOW()),
      ('Lucas', 'Thompson', 'lucas.thompson@example.com', 1, 1, '1985-05-17', 'RN', NOW(), NOW()),
      ('Charlotte', 'Garcia', 'charlotte.garcia@example.com', 2, 3, '1990-06-18', 'PT', NOW(), NOW()),
      ('Henry', 'Martinez', 'henry.martinez@example.com', 1, 4, '1982-07-19', 'PharmD', NOW(), NOW()),
      ('Amelia', 'Robinson', 'amelia.robinson@example.com', 2, 5, '1986-08-20', 'Tech', NOW(), NOW())
    """)
  end
end
