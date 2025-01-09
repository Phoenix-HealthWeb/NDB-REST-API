# FILE: lib/mix/tasks/reset_db.ex
defmodule Mix.Tasks.ResetDb do
  use Mix.Task
  alias NdbRestApi.Accounts.Admin
  alias NdbRestApi.Repo
  alias NdbRestApi.Patients.Patient
  alias NdbRestApi.Genders.Gender
  alias NdbRestApi.PractitionerRoles.PractitionerRole
  alias NdbRestApi.Practitioners.Practitioner
  alias NdbRestApi.Hospitals.Hospital
  alias NdbRestApi.HospitalsPractitioners
  import Bcrypt, only: [hash_pwd_salt: 1]

  @shortdoc "Resets the database and populates it with default patients"
  def run(_) do
    Mix.Task.run("app.start")

    # Delete all data
    Repo.delete_all(Patient)
    Repo.delete_all(Gender)
    Repo.delete_all(PractitionerRole)
    Repo.delete_all(Practitioner)
    Repo.delete_all(Hospital)
    Repo.delete_all(HospitalsPractitioners)

    insert_admin()
    insert_genders()
    insert_patients()
    insert_practitioner_roles()
    insert_practitioners()
    insert_hospitals()
    insert_hospitals_practitioners()

    IO.puts("Database reset and populated with default patients.")
  end

  defp insert_admin do
    default_admin = %Admin{
      email: "admin@gmail.com",
      hashed_password: hash_pwd_salt("qwertyuiopas")
    }

    Repo.insert!(default_admin)
  end

  defp insert_genders() do
    # Insert default genders
    default_genders = [
      %Gender{id: 1, name: "Male"},
      %Gender{id: 2, name: "Female"},
      %Gender{id: 3, name: "Not specified"}
    ]

    Enum.each(default_genders, fn gender ->
      Repo.insert!(gender)
    end)
  end

  defp insert_patients() do
    # Insert default patients
    default_patients = [
      %Patient{
        firstname: "John",
        lastname: "Doe",
        cf: "JD123456",
        date_of_birth: ~D[1980-01-01],
        gender_id: 1
      },
      %Patient{
        firstname: "Jane",
        lastname: "Smith",
        cf: "JS123456",
        date_of_birth: ~D[1985-02-02],
        gender_id: 2
      },
      %Patient{
        firstname: "Alex",
        lastname: "Taylor",
        cf: "AT123456",
        date_of_birth: ~D[1990-03-03],
        gender_id: 3
      },
      %Patient{
        firstname: "Emily",
        lastname: "Johnson",
        cf: "EJ123456",
        date_of_birth: ~D[1982-04-04],
        gender_id: 2
      },
      %Patient{
        firstname: "Michael",
        lastname: "Brown",
        cf: "MB123456",
        date_of_birth: ~D[1978-05-05],
        gender_id: 1
      },
      %Patient{
        firstname: "Sarah",
        lastname: "Davis",
        cf: "SD123456",
        date_of_birth: ~D[1992-06-06],
        gender_id: 2
      },
      %Patient{
        firstname: "David",
        lastname: "Miller",
        cf: "DM123456",
        date_of_birth: ~D[1984-07-07],
        gender_id: 1
      },
      %Patient{
        firstname: "Laura",
        lastname: "Wilson",
        cf: "LW123456",
        date_of_birth: ~D[1986-08-08],
        gender_id: 2
      },
      %Patient{
        firstname: "Robert",
        lastname: "Moore",
        cf: "RM123456",
        date_of_birth: ~D[1975-09-09],
        gender_id: 1
      },
      %Patient{
        firstname: "Sophia",
        lastname: "Taylor",
        cf: "ST123456",
        date_of_birth: ~D[1991-10-10],
        gender_id: 2
      },
      %Patient{
        firstname: "James",
        lastname: "Anderson",
        cf: "JA123456",
        date_of_birth: ~D[1983-11-11],
        gender_id: 1
      },
      %Patient{
        firstname: "Olivia",
        lastname: "Thomas",
        cf: "OT123456",
        date_of_birth: ~D[1987-12-12],
        gender_id: 2
      },
      %Patient{
        firstname: "William",
        lastname: "Jackson",
        cf: "WJ123456",
        date_of_birth: ~D[1979-01-13],
        gender_id: 1
      },
      %Patient{
        firstname: "Isabella",
        lastname: "White",
        cf: "IW123456",
        date_of_birth: ~D[1993-02-14],
        gender_id: 2
      },
      %Patient{
        firstname: "Benjamin",
        lastname: "Harris",
        cf: "BH123456",
        date_of_birth: ~D[1981-03-15],
        gender_id: 1
      },
      %Patient{
        firstname: "Mia",
        lastname: "Martin",
        cf: "MM123456",
        date_of_birth: ~D[1988-04-16],
        gender_id: 2
      },
      %Patient{
        firstname: "Lucas",
        lastname: "Thompson",
        cf: "LT123456",
        date_of_birth: ~D[1985-05-17],
        gender_id: 1
      },
      %Patient{
        firstname: "Charlotte",
        lastname: "Garcia",
        cf: "CG123456",
        date_of_birth: ~D[1990-06-18],
        gender_id: 2
      },
      %Patient{
        firstname: "Henry",
        lastname: "Martinez",
        cf: "HM123456",
        date_of_birth: ~D[1982-07-19],
        gender_id: 1
      },
      %Patient{
        firstname: "Amelia",
        lastname: "Robinson",
        cf: "AR123456",
        date_of_birth: ~D[1986-08-20],
        gender_id: 2
      },
      %Patient{
        firstname: "Alexander",
        lastname: "Clark",
        cf: "AC123456",
        date_of_birth: ~D[1978-09-21],
        gender_id: 1
      },
      %Patient{
        firstname: "Evelyn",
        lastname: "Rodriguez",
        cf: "ER123456",
        date_of_birth: ~D[1991-10-22],
        gender_id: 2
      },
      %Patient{
        firstname: "Daniel",
        lastname: "Lewis",
        cf: "DL123456",
        date_of_birth: ~D[1984-11-23],
        gender_id: 1
      },
      %Patient{
        firstname: "Harper",
        lastname: "Lee",
        cf: "HL123456",
        date_of_birth: ~D[1987-12-24],
        gender_id: 2
      },
      %Patient{
        firstname: "Matthew",
        lastname: "Walker",
        cf: "MW123456",
        date_of_birth: ~D[1979-01-25],
        gender_id: 1
      },
      %Patient{
        firstname: "Ella",
        lastname: "Hall",
        cf: "EH123456",
        date_of_birth: ~D[1993-02-26],
        gender_id: 2
      },
      %Patient{
        firstname: "Grace",
        lastname: "Scott",
        cf: "GS123456",
        date_of_birth: ~D[1991-10-03],
        gender_id: 2
      },
      %Patient{
        firstname: "Christopher",
        lastname: "Green",
        cf: "CG123457",
        date_of_birth: ~D[1984-11-04],
        gender_id: 1
      },
      %Patient{
        firstname: "Chloe",
        lastname: "Adams",
        cf: "CA123456",
        date_of_birth: ~D[1987-12-05],
        gender_id: 2
      },
      %Patient{
        firstname: "Joshua",
        lastname: "Baker",
        cf: "JB123456",
        date_of_birth: ~D[1979-01-06],
        gender_id: 1
      },
      %Patient{
        firstname: "Lily",
        lastname: "Gonzalez",
        cf: "LG123456",
        date_of_birth: ~D[1993-02-07],
        gender_id: 2
      },
      %Patient{
        firstname: "Andrew",
        lastname: "Nelson",
        cf: "AN123456",
        date_of_birth: ~D[1981-03-08],
        gender_id: 1
      },
      %Patient{
        firstname: "Zoey",
        lastname: "Carter",
        cf: "ZC123456",
        date_of_birth: ~D[1988-04-09],
        gender_id: 2
      },
      %Patient{
        firstname: "Joseph",
        lastname: "Allen",
        cf: "JA123457",
        date_of_birth: ~D[1981-03-27],
        gender_id: 1
      },
      %Patient{
        firstname: "Avery",
        lastname: "Young",
        cf: "AY123456",
        date_of_birth: ~D[1988-04-28],
        gender_id: 2
      },
      %Patient{
        firstname: "Samuel",
        lastname: "Hernandez",
        cf: "SH123456",
        date_of_birth: ~D[1985-05-29],
        gender_id: 1
      },
      %Patient{
        firstname: "Scarlett",
        lastname: "King",
        cf: "SK123456",
        date_of_birth: ~D[1990-06-30],
        gender_id: 2
      },
      %Patient{
        firstname: "Gabriel",
        lastname: "Wright",
        cf: "GW123456",
        date_of_birth: ~D[1982-07-31],
        gender_id: 1
      },
      %Patient{
        firstname: "Victoria",
        lastname: "Lopez",
        cf: "VL123456",
        date_of_birth: ~D[1986-08-01],
        gender_id: 2
      },
      %Patient{
        firstname: "Anthony",
        lastname: "Hill",
        cf: "AH123456",
        date_of_birth: ~D[1978-09-02],
        gender_id: 1
      },
      %Patient{
        firstname: "Ryan",
        lastname: "Mitchell",
        cf: "RM123457",
        date_of_birth: ~D[1985-05-10],
        gender_id: 1
      },
      %Patient{
        firstname: "Hannah",
        lastname: "Perez",
        cf: "HP123456",
        date_of_birth: ~D[1990-06-11],
        gender_id: 2
      },
      %Patient{
        firstname: "Jack",
        lastname: "Roberts",
        cf: "JR123456",
        date_of_birth: ~D[1982-07-12],
        gender_id: 1
      },
      %Patient{
        firstname: "Lillian",
        lastname: "Turner",
        cf: "LT123457",
        date_of_birth: ~D[1986-08-13],
        gender_id: 2
      },
      %Patient{
        firstname: "Dylan",
        lastname: "Phillips",
        cf: "DP123456",
        date_of_birth: ~D[1978-09-14],
        gender_id: 1
      },
      %Patient{
        firstname: "Addison",
        lastname: "Campbell",
        cf: "AC123457",
        date_of_birth: ~D[1991-10-15],
        gender_id: 2
      },
      %Patient{
        firstname: "Nathan",
        lastname: "Parker",
        cf: "NP123456",
        date_of_birth: ~D[1984-11-16],
        gender_id: 1
      },
      %Patient{
        firstname: "Aubrey",
        lastname: "Evans",
        cf: "AE123456",
        date_of_birth: ~D[1987-12-17],
        gender_id: 2
      },
      %Patient{
        firstname: "Isaac",
        lastname: "Edwards",
        cf: "IE123456",
        date_of_birth: ~D[1979-01-18],
        gender_id: 1
      },
      %Patient{
        firstname: "Eleanor",
        lastname: "Collins",
        cf: "EC123456",
        date_of_birth: ~D[1993-02-19],
        gender_id: 2
      }
    ]

    Enum.each(default_patients, fn patient ->
      Repo.insert!(patient)
    end)
  end

  defp insert_practitioner_roles do
    roles = [
      %PractitionerRole{id: 1, name: "Doctor"},
      %PractitionerRole{id: 2, name: "Nurse"},
      %PractitionerRole{id: 3, name: "Therapist"},
      %PractitionerRole{id: 4, name: "Pharmacist"},
      %PractitionerRole{id: 5, name: "Technician"}
    ]

    Enum.each(roles, &Repo.insert!(&1))
  end

  defp insert_practitioners do
    practitioners = [
      %Practitioner{forename: "John", surname: "Doe", email: "john.doe@example.com", gender_id: 1, role_id: 1, date_of_birth: ~D[1980-01-01], qualification: "MD"},
      %Practitioner{forename: "Jane", surname: "Smith", email: "jane.smith@example.com", gender_id: 2, role_id: 1, date_of_birth: ~D[1985-02-02], qualification: "RN"},
      %Practitioner{forename: "Alex", surname: "Taylor", email: "alex.taylor@example.com", gender_id: 3, role_id: 2, date_of_birth: ~D[1990-03-03], qualification: "PT"},
      %Practitioner{forename: "Emily", surname: "Johnson", email: "emily.johnson@example.com", gender_id: 2, role_id: 2, date_of_birth: ~D[1982-04-04], qualification: "PharmD"},
      %Practitioner{forename: "Michael", surname: "Brown", email: "michael.brown@example.com", gender_id: 1, role_id: 2, date_of_birth: ~D[1978-05-05], qualification: "Tech"},
      %Practitioner{forename: "Sarah", surname: "Davis", email: "sarah.davis@example.com", gender_id: 2, role_id: 1, date_of_birth: ~D[1992-06-06], qualification: "MD"},
      %Practitioner{forename: "David", surname: "Miller", email: "david.miller@example.com", gender_id: 1, role_id: 1, date_of_birth: ~D[1984-07-07], qualification: "RN"},
      %Practitioner{forename: "Laura", surname: "Wilson", email: "laura.wilson@example.com", gender_id: 2, role_id: 3, date_of_birth: ~D[1986-08-08], qualification: "PT"},
      %Practitioner{forename: "Robert", surname: "Moore", email: "robert.moore@example.com", gender_id: 1, role_id: 1, date_of_birth: ~D[1975-09-09], qualification: "PharmD"},
      %Practitioner{forename: "Sophia", surname: "Taylor", email: "sophia.taylor@example.com", gender_id: 2, role_id: 5, date_of_birth: ~D[1991-10-10], qualification: "Tech"},
      %Practitioner{forename: "James", surname: "Anderson", email: "james.anderson@example.com", gender_id: 1, role_id: 1, date_of_birth: ~D[1983-11-11], qualification: "MD"},
      %Practitioner{forename: "Olivia", surname: "Thomas", email: "olivia.thomas@example.com", gender_id: 2, role_id: 2, date_of_birth: ~D[1987-12-12], qualification: "RN"},
      %Practitioner{forename: "William", surname: "Jackson", email: "william.jackson@example.com", gender_id: 1, role_id: 3, date_of_birth: ~D[1979-01-13], qualification: "PT"},
      %Practitioner{forename: "Isabella", surname: "White", email: "isabella.white@example.com", gender_id: 2, role_id: 4, date_of_birth: ~D[1993-02-14], qualification: "PharmD"},
      %Practitioner{forename: "Benjamin", surname: "Harris", email: "benjamin.harris@example.com", gender_id: 1, role_id: 5, date_of_birth: ~D[1981-03-15], qualification: "Tech"},
      %Practitioner{forename: "Mia", surname: "Martin", email: "mia.martin@example.com", gender_id: 2, role_id: 1, date_of_birth: ~D[1988-04-16], qualification: "MD"},
      %Practitioner{forename: "Lucas", surname: "Thompson", email: "lucas.thompson@example.com", gender_id: 1, role_id: 1, date_of_birth: ~D[1985-05-17], qualification: "RN"},
      %Practitioner{forename: "Charlotte", surname: "Garcia", email: "charlotte.garcia@example.com", gender_id: 2, role_id: 3, date_of_birth: ~D[1990-06-18], qualification: "PT"},
      %Practitioner{forename: "Henry", surname: "Martinez", email: "henry.martinez@example.com", gender_id: 1, role_id: 4, date_of_birth: ~D[1982-07-19], qualification: "PharmD"},
      %Practitioner{forename: "Amelia", surname: "Robinson", email: "amelia.robinson@example.com", gender_id: 2, role_id: 5, date_of_birth: ~D[1986-08-20], qualification: "Tech"}
    ]

    Enum.each(practitioners, &Repo.insert!(&1))
  end

  defp insert_hospitals do
    hospitals = [
      %Hospital{name: "Ospedale Maggiore Policlinico", address: "Via Francesco Sforza, 35, Milano", region: "Lombardia", notes: "Struttura di alta specializzazione"},
      %Hospital{name: "Ospedale Niguarda", address: "Piazza Ospedale Maggiore, 3, Milano", region: "Lombardia", notes: "Eccellenza per emergenze-urgenze"},
      %Hospital{name: "Policlinico Gemelli", address: "Largo Agostino Gemelli, 8, Roma", region: "Lazio", notes: "Istituto di ricerca e cura"},
      %Hospital{name: "Ospedale Sant Andrea", address: "Via di Grottarossa, 1035, Roma", region: "Lazio", notes: "Struttura universitaria"},
      %Hospital{name: "Ospedale Santa Maria Nuova", address: "Piazza Santa Maria Nuova, 1, Firenze", region: "Toscana", notes: "Fondato nel 1288"},
      %Hospital{name: "Ospedale Careggi", address: "Viale Pieraccini, 17, Firenze", region: "Toscana", notes: "Azienda ospedaliero-universitaria"},
      %Hospital{name: "Ospedale San Martino", address: "Largo Rosanna Benzi, 10, Genova", region: "Liguria", notes: "Tra i più grandi d Europa"},
      %Hospital{name: "Ospedale Papa Giovanni XXIII", address: "Piazza OMS, 1, Bergamo", region: "Lombardia", notes: "Struttura all avanguardia"},
      %Hospital{name: "Ospedale Cardarelli", address: "Via Antonio Cardarelli, 9, Napoli", region: "Campania", notes: "Tra i più grandi del Sud Italia"},
      %Hospital{name: "Policlinico di Bari", address: "Piazza Giulio Cesare, 11, Bari", region: "Puglia", notes: "Struttura di formazione e ricerca"}
    ]

    Enum.each(hospitals, &Repo.insert!(&1))
  end

  defp insert_hospitals_practitioners do
    relationships = [
      %HospitalsPractitioners{hospital_id: 1, practitioner_id: 1},
      %HospitalsPractitioners{hospital_id: 1, practitioner_id: 2},
      %HospitalsPractitioners{hospital_id: 2, practitioner_id: 3},
      %HospitalsPractitioners{hospital_id: 2, practitioner_id: 4},
      %HospitalsPractitioners{hospital_id: 3, practitioner_id: 5},
      %HospitalsPractitioners{hospital_id: 3, practitioner_id: 6},
      %HospitalsPractitioners{hospital_id: 4, practitioner_id: 7},
      %HospitalsPractitioners{hospital_id: 4, practitioner_id: 8},
      %HospitalsPractitioners{hospital_id: 5, practitioner_id: 9},
      %HospitalsPractitioners{hospital_id: 5, practitioner_id: 10},
      %HospitalsPractitioners{hospital_id: 6, practitioner_id: 11},
      %HospitalsPractitioners{hospital_id: 6, practitioner_id: 12},
      %HospitalsPractitioners{hospital_id: 7, practitioner_id: 13},
      %HospitalsPractitioners{hospital_id: 7, practitioner_id: 14},
      %HospitalsPractitioners{hospital_id: 8, practitioner_id: 15},
      %HospitalsPractitioners{hospital_id: 8, practitioner_id: 16},
      %HospitalsPractitioners{hospital_id: 9, practitioner_id: 17},
      %HospitalsPractitioners{hospital_id: 9, practitioner_id: 18},
      %HospitalsPractitioners{hospital_id: 10, practitioner_id: 19},
      %HospitalsPractitioners{hospital_id: 10, practitioner_id: 20}
    ]

    Enum.each(relationships, &Repo.insert!(&1))
  end
end
