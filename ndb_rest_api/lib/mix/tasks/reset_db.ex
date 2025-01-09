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
  require CSV

  @shortdoc "Resets the database and populates it with default patients"
  def run(_) do
    Mix.Task.run("app.start")

    # Delete all data
    Repo.delete_all(HospitalsPractitioners)
    Repo.delete_all(Hospital)
    Repo.delete_all(Practitioner)
    Repo.delete_all(PractitionerRole)
    Repo.delete_all(Patient)
    Repo.delete_all(Gender)
    Repo.delete_all(Admin)

    # Insert default data from CSV files
    insert_admin()
    insert_genders()
    insert_patients()
    insert_practitioner_roles()
    insert_practitioners()
    insert_hospitals()
    insert_hospitals_practitioners()

    IO.puts("Database reset and populated with default data.")
  end

  defp insert_admin do
    "priv/repo/seeds/admins.csv"
    |> File.stream!()
    |> CSV.decode(headers: true)
    |> Enum.each(fn {:ok, %{"username" => email, "password" => password}} ->
      %Admin{email: email, hashed_password: hash_pwd_salt(password)}
      |> Repo.insert!()
    end)
  end

  defp insert_genders do
    "priv/repo/seeds/genders.csv"
    |> File.stream!()
    |> CSV.decode(headers: true)
    |> Enum.each(fn {:ok, %{"id" => id, "name" => name}} ->
      %Gender{id: String.to_integer(id), name: name}
      |> Repo.insert!()
    end)
  end

  defp insert_patients do
    "priv/repo/seeds/patients.csv"
    |> File.stream!()
    |> CSV.decode(headers: true)
    |> Enum.each(fn {:ok, %{"firstname" => firstname, "lastname" => lastname, "cf" => cf, "date_of_birth" => date_of_birth, "gender_id" => gender_id}} ->
      %Patient{
        firstname: firstname,
        lastname: lastname,
        cf: cf,
        date_of_birth: Date.from_iso8601!(date_of_birth),
        gender_id: String.to_integer(gender_id)
      }
      |> Repo.insert!()
    end)
  end

  defp insert_practitioner_roles do
    "priv/repo/seeds/practitioner_roles.csv"
    |> File.stream!()
    |> CSV.decode(headers: true)
    |> Enum.each(fn {:ok, %{"name" => name}} ->
      %PractitionerRole{name: name}
      |> Repo.insert!()
    end)
  end

  defp insert_practitioners do
    "priv/repo/seeds/practitioners.csv"
    |> File.stream!()
    |> CSV.decode(headers: true)
    |> Enum.each(fn {:ok, %{"forename" => forename, "surname" => surname, "email" => email, "gender_id" => gender_id, "role_id" => role_id, "date_of_birth" => date_of_birth, "qualification" => qualification}} ->
      %Practitioner{
        forename: forename,
        surname: surname,
        email: email,
        gender_id: String.to_integer(gender_id),
        role_id: String.to_integer(role_id),
        date_of_birth: Date.from_iso8601!(date_of_birth),
        qualification: qualification
      }
      |> Repo.insert!()
    end)
  end

  defp insert_hospitals do
    "priv/repo/seeds/hospitals.csv"
    |> File.stream!()
    |> CSV.decode(headers: true)
    |> Enum.each(fn {:ok, %{"name" => name, "address" => address, "region" => region, "notes" => notes}} ->
      %Hospital{
        name: name,
        address: address,
        region: region,
        notes: notes
      }
      |> Repo.insert!()
    end)
  end

  defp insert_hospitals_practitioners do
    "priv/repo/seeds/hospitals_practitioners.csv"
    |> File.stream!()
    |> CSV.decode(headers: true)
    |> Enum.each(fn {:ok, %{"hospital_id" => hospital_id, "practitioner_id" => practitioner_id}} ->
      %HospitalsPractitioners{
        hospital_id: String.to_integer(hospital_id),
        practitioner_id: String.to_integer(practitioner_id)
      }
      |> Repo.insert!()
    end)
  end
end
