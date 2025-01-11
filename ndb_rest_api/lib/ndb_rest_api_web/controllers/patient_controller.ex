defmodule NdbRestApiWeb.PatientController do
  use NdbRestApiWeb, :controller

  alias NdbRestApi.Patients
  alias NdbRestApi.Patients.Patient
  alias NdbRestApi.Genders
  alias NdbRestApi.Repo

  def index(conn, _params) do
    patients = Patients.list_patients() |> Repo.preload(:gender)
    render(conn, :index, patients: patients)
  end

  def new(conn, _params) do
    changeset = Patients.change_patient(%Patient{})
    genders = Genders.list_genders()
    render(conn, :new, changeset: changeset, genders: genders)
  end

  def create(conn, %{"patient" => patient_params}) do
    case Patients.create_patient(patient_params) do
      {:ok, patient} ->
        conn
        |> put_flash(:info, "Patient created successfully.")
        |> redirect(to: ~p"/patients/#{patient}")

      {:error, %Ecto.Changeset{} = changeset} ->
        genders = Genders.list_genders()
        render(conn, :new, changeset: changeset, genders: genders)
    end
  end

  def show(conn, %{"id" => id}) do
    patient = Patients.get_patient!(id) |> Repo.preload(:gender)
    render(conn, :show, patient: patient)
  end

  def edit(conn, %{"id" => id}) do
    patient = Patients.get_patient!(id)
    changeset = Patients.change_patient(patient)
    genders = Genders.list_genders()
    render(conn, :edit, patient: patient, changeset: changeset, genders: genders)
  end

  def update(conn, %{"id" => id, "patient" => patient_params}) do
    patient = Patients.get_patient!(id)

    case Patients.update_patient(patient, patient_params) do
      {:ok, patient} ->
        conn
        |> put_flash(:info, "Patient updated successfully.")
        |> redirect(to: ~p"/patients/#{patient}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, patient: patient, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    patient = Patients.get_patient!(id)
    {:ok, _patient} = Patients.delete_patient(patient)

    conn
    |> put_flash(:info, "Patient deleted successfully.")
    |> redirect(to: ~p"/patients")
  end
end
