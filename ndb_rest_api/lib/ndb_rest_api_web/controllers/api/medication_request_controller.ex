defmodule NdbRestApiWeb.Api.MedicationRequestController do
  use NdbRestApiWeb, :controller

  alias NdbRestApi.MedicationRequests
  alias NdbRestApi.MedicationRequests.MedicationRequest
  alias NdbRestApi.Repo
  alias NdbRestApi.Patients
  alias NdbRestApi.Practitioners

  action_fallback NdbRestApiWeb.FallbackController

  def index(conn, _params) do
    medication_requests =
      MedicationRequests.list_medication_requests()
      |> Repo.preload(:patient)
      |> Repo.preload(:practitioner)

    render(conn, :index, medication_requests: medication_requests)
  end

  def create(conn, %{"medication_request" => medication_request_params}) do
    with {:ok, %MedicationRequest{} = medication_request} <-
           MedicationRequests.create_medication_request(medication_request_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/api/medication_requests/#{medication_request}")
      |> render(:show, medication_request: medication_request)
    end
  end

  def show(conn, %{"id" => id}) do
    medication_request =
      MedicationRequests.get_medication_request!(id)
      |> Repo.preload(:patient)
      |> Repo.preload(:practitioner)
      |> Repo.preload(:gender)

    IO.inspect(medication_request)
    render(conn, :show, medication_request: medication_request)
  end

  def update(conn, %{"id" => id, "medication_request" => medication_request_params}) do
    medication_request = MedicationRequests.get_medication_request!(id)

    with {:ok, %MedicationRequest{} = medication_request} <-
           MedicationRequests.update_medication_request(
             medication_request,
             medication_request_params
           ) do
      render(conn, :show, medication_request: medication_request)
    end
  end

  def delete(conn, %{"id" => id}) do
    medication_request = MedicationRequests.get_medication_request!(id)

    with {:ok, %MedicationRequest{}} <-
           MedicationRequests.delete_medication_request(medication_request) do
      send_resp(conn, :no_content, "")
    end
  end
end
