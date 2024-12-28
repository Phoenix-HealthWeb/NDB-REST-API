defmodule NdbRestApi.Repo.Migrations.AddDefaultPatients do
  use Ecto.Migration

  def change do
    execute("""
    INSERT INTO patients (firstname, lastname, cf, date_of_birth, gender_id, inserted_at, updated_at)
    VALUES
      ('John', 'Doe', 'JD123456', '1980-01-01', 1, NOW(), NOW()),
      ('Jane', 'Smith', 'JS123456', '1985-02-02', 2, NOW(), NOW()),
      ('Alex', 'Taylor', 'AT123456', '1990-03-03', 3, NOW(), NOW()),
      ('Emily', 'Johnson', 'EJ123456', '1982-04-04', 2, NOW(), NOW()),
      ('Michael', 'Brown', 'MB123456', '1978-05-05', 1, NOW(), NOW()),
      ('Sarah', 'Davis', 'SD123456', '1992-06-06', 2, NOW(), NOW()),
      ('David', 'Miller', 'DM123456', '1984-07-07', 1, NOW(), NOW()),
      ('Laura', 'Wilson', 'LW123456', '1986-08-08', 2, NOW(), NOW()),
      ('Robert', 'Moore', 'RM123456', '1975-09-09', 1, NOW(), NOW()),
      ('Sophia', 'Taylor', 'ST123456', '1991-10-10', 2, NOW(), NOW()),
      ('James', 'Anderson', 'JA123456', '1983-11-11', 1, NOW(), NOW()),
      ('Olivia', 'Thomas', 'OT123456', '1987-12-12', 2, NOW(), NOW()),
      ('William', 'Jackson', 'WJ123456', '1979-01-13', 1, NOW(), NOW()),
      ('Isabella', 'White', 'IW123456', '1993-02-14', 2, NOW(), NOW()),
      ('Benjamin', 'Harris', 'BH123456', '1981-03-15', 1, NOW(), NOW()),
      ('Mia', 'Martin', 'MM123456', '1988-04-16', 2, NOW(), NOW()),
      ('Lucas', 'Thompson', 'LT123456', '1985-05-17', 1, NOW(), NOW()),
      ('Charlotte', 'Garcia', 'CG123456', '1990-06-18', 2, NOW(), NOW()),
      ('Henry', 'Martinez', 'HM123456', '1982-07-19', 1, NOW(), NOW()),
      ('Amelia', 'Robinson', 'AR123456', '1986-08-20', 2, NOW(), NOW()),
      ('Alexander', 'Clark', 'AC123456', '1978-09-21', 1, NOW(), NOW()),
      ('Evelyn', 'Rodriguez', 'ER123456', '1991-10-22', 2, NOW(), NOW()),
      ('Daniel', 'Lewis', 'DL123456', '1984-11-23', 1, NOW(), NOW()),
      ('Harper', 'Lee', 'HL123456', '1987-12-24', 2, NOW(), NOW()),
      ('Matthew', 'Walker', 'MW123456', '1979-01-25', 1, NOW(), NOW()),
      ('Ella', 'Hall', 'EH123456', '1993-02-26', 2, NOW(), NOW()),
      ('Joseph', 'Allen', 'JA123457', '1981-03-27', 1, NOW(), NOW()),
      ('Avery', 'Young', 'AY123456', '1988-04-28', 2, NOW(), NOW()),
      ('Samuel', 'Hernandez', 'SH123456', '1985-05-29', 1, NOW(), NOW()),
      ('Scarlett', 'King', 'SK123456', '1990-06-30', 2, NOW(), NOW()),
      ('Gabriel', 'Wright', 'GW123456', '1982-07-31', 1, NOW(), NOW()),
      ('Victoria', 'Lopez', 'VL123456', '1986-08-01', 2, NOW(), NOW()),
      ('Anthony', 'Hill', 'AH123456', '1978-09-02', 1, NOW(), NOW()),
      ('Grace', 'Scott', 'GS123456', '1991-10-03', 2, NOW(), NOW()),
      ('Christopher', 'Green', 'CG123457', '1984-11-04', 1, NOW(), NOW()),
      ('Chloe', 'Adams', 'CA123456', '1987-12-05', 2, NOW(), NOW()),
      ('Joshua', 'Baker', 'JB123456', '1979-01-06', 1, NOW(), NOW()),
      ('Lily', 'Gonzalez', 'LG123456', '1993-02-07', 2, NOW(), NOW()),
      ('Andrew', 'Nelson', 'AN123456', '1981-03-08', 1, NOW(), NOW()),
      ('Zoey', 'Carter', 'ZC123456', '1988-04-09', 2, NOW(), NOW()),
      ('Ryan', 'Mitchell', 'RM123457', '1985-05-10', 1, NOW(), NOW()),
      ('Hannah', 'Perez', 'HP123456', '1990-06-11', 2, NOW(), NOW()),
      ('Jack', 'Roberts', 'JR123456', '1982-07-12', 1, NOW(), NOW()),
      ('Lillian', 'Turner', 'LT123457', '1986-08-13', 2, NOW(), NOW()),
      ('Dylan', 'Phillips', 'DP123456', '1978-09-14', 1, NOW(), NOW()),
      ('Addison', 'Campbell', 'AC123457', '1991-10-15', 2, NOW(), NOW()),
      ('Nathan', 'Parker', 'NP123456', '1984-11-16', 1, NOW(), NOW()),
      ('Aubrey', 'Evans', 'AE123456', '1987-12-17', 2, NOW(), NOW()),
      ('Isaac', 'Edwards', 'IE123456', '1979-01-18', 1, NOW(), NOW()),
      ('Eleanor', 'Collins', 'EC123456', '1993-02-19', 2, NOW(), NOW())
    """)
  end
end
