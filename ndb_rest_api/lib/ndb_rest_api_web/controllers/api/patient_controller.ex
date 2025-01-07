defmodule NdbRestApiWeb.Api.PatientController do
  use NdbRestApiWeb, :controller

  alias NdbRestApi.Patients
  alias NdbRestApi.Patients.Patient
  alias NdbRestApi.Repo

  action_fallback NdbRestApiWeb.FallbackController

  def index(conn, _params) do
    patients =
      Patients.list_patients()
      |> Repo.preload([:gender, :medication_requests, :observations, :conditions])

    render(conn, :index, patients: patients)
  end

  def create(conn, %{"patient" => patient_params}) do
    # Gender is passed as its name, so we need to retrieve the gender id
    gender = NdbRestApi.Genders.get_by_name!(Map.fetch!(patient_params, "gender"))

    full_patient = patient_params
      |> Map.put("gender_id", gender.id)
      |> Map.delete("gender")

    with {:ok, %Patient{} = patient} <- Patients.create_patient(full_patient)
       do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/patients/#{patient}")
      |> render(:show, patient:
        patient
        |> Repo.preload([:gender, :medication_requests, :observations, :conditions])
      )
    end
  end

  def show(conn, %{"id" => id}) do
    patient =
      Patients.get_patient!(id)
      |> Repo.preload([:gender, :medication_requests, :observations, :conditions])

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
