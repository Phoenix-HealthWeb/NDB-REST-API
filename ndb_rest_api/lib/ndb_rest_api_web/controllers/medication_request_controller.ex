defmodule NdbRestApiWeb.MedicationRequestController do
  use NdbRestApiWeb, :controller

  alias NdbRestApi.MedicationRequests
  alias NdbRestApi.MedicationRequests.MedicationRequest
  alias NdbRestApi.Repo
  alias NdbRestApi.Patients
  alias NdbRestApi.Practitioners

  def index(conn, _params) do
    medication_requests =
      MedicationRequests.list_medication_requests()
      |> Repo.preload(:patient)
      |> Repo.preload(:practitioner)

    IO.inspect(medication_requests)
    render(conn, :index, medication_requests: medication_requests)
  end

  def new(conn, _params) do
    changeset = MedicationRequests.change_medication_request(%MedicationRequest{})
    patients = Patients.list_patients()
    practitioners = Practitioners.list_practitioners()
    render(conn, :new, changeset: changeset, patients: patients, practitioners: practitioners)
  end

  def create(conn, %{"medication_request" => medication_request_params}) do
    case MedicationRequests.create_medication_request(medication_request_params) do
      {:ok, medication_request} ->
        conn
        |> put_flash(:info, "Medication request created successfully.")
        |> redirect(to: ~p"/medication_requests/#{medication_request}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    medication_request =
      MedicationRequests.get_medication_request!(id)
      |> Repo.preload(:patient)
      |> Repo.preload(:practitioner)

    render(conn, :show, medication_request: medication_request)
  end

  def edit(conn, %{"id" => id}) do
    medication_request = MedicationRequests.get_medication_request!(id)
    patients = Patients.list_patients()
    practitioners = Practitioners.list_practitioners()
    changeset = MedicationRequests.change_medication_request(medication_request)

    render(conn, :edit,
      medication_request: medication_request,
      changeset: changeset,
      patients: patients,
      practitioners: practitioners
    )
  end

  def update(conn, %{"id" => id, "medication_request" => medication_request_params}) do
    medication_request = MedicationRequests.get_medication_request!(id)

    case MedicationRequests.update_medication_request(
           medication_request,
           medication_request_params
         ) do
      {:ok, medication_request} ->
        conn
        |> put_flash(:info, "Medication request updated successfully.")
        |> redirect(to: ~p"/medication_requests/#{medication_request}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, medication_request: medication_request, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    medication_request = MedicationRequests.get_medication_request!(id)
    {:ok, _medication_request} = MedicationRequests.delete_medication_request(medication_request)

    conn
    |> put_flash(:info, "Medication request deleted successfully.")
    |> redirect(to: ~p"/medication_requests")
  end
end
