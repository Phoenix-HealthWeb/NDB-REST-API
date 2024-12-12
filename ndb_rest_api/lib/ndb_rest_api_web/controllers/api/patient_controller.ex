defmodule NdbRestApiWeb.Api.PatientController do
  use NdbRestApiWeb, :controller

  alias NdbRestApi.Patients
  alias NdbRestApi.Patients.Patient
  alias NdbRestApi.Genders
  alias NdbRestApi.Repo

  action_fallback NdbRestApiWeb.FallbackController

  def index(conn, _params) do
    patients = Patients.list_patients() |> Repo.preload(:gender)
    IO.inspect(patients)
    render(conn, :index, patients: patients)
  end

  def create(conn, %{"patient" => patient_params}) do
    with {:ok, %Patient{} = patient} <- Patients.create_patient(patient_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/api/patients/#{patient}")
      |> render(:show, patient: patient)
    end
  end

  def show(conn, %{"id" => id}) do
    patient = Patients.get_patient!(id) |> Repo.preload(:gender)
    render(conn, :show, patient: patient)
  end

  def update(conn, %{"id" => id, "patient" => patient_params}) do
    patient = Patients.get_patient!(id)

    with {:ok, %Patient{} = patient} <- Patients.update_patient(patient, patient_params) do
      render(conn, :show, patient: patient)
    end
  end

  def delete(conn, %{"id" => id}) do
    patient = Patients.get_patient!(id)

    with {:ok, %Patient{}} <- Patients.delete_patient(patient) do
      send_resp(conn, :no_content, "")
    end
  end
end
