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
    with {:ok, %Patient{} = patient} <- Patients.create_patient(patient_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/patients/#{patient}")
      |> render(:show, patient: patient)
    end
  end

  def show(conn, %{"id" => id}) do
    all_params = conn.params
    method = Map.get(all_params, "method")
    IO.inspect(method)

    patient =
      case method do
        "cf" -> get_by_cf(id)
        "id" -> get_by_id(id)
        _ -> get_by_id(id)
      end

    render(conn, :show, patient: patient)
  end

  def get_by_id(id) do
    Patients.get_patient!(id)
    |> Repo.preload([:gender, :medication_requests, :observations, :conditions])
  end

  def get_by_cf(cf) do
    Patients.find_patient_by_cf!(cf)
    |> Repo.preload([:gender, :medication_requests, :observations, :conditions])
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
