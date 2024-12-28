defmodule NdbRestApiWeb.HospitalController do
  use NdbRestApiWeb, :controller

  alias NdbRestApi.Hospitals
  alias NdbRestApi.Hospitals.Hospital
  alias NdbRestApi.Practitioners
  alias NdbRestApi.Repo

  def index(conn, _params) do
    hospitals = Hospitals.list_hospitals()
                |> Repo.preload(practitioners: [:role])
    render(conn, :index, hospitals: hospitals)
  end

  def new(conn, _params) do
    changeset = Hospitals.change_hospital(%Hospital{practitioners: []})
    practitioners = Practitioners.list_practitioners() |> Repo.preload(:role)
    render(conn, :new, changeset: changeset, practitioners: practitioners)
  end

  def create(conn, %{"hospital" => hospital_params}) do
    case Hospitals.create_hospital(hospital_params) do
      {:ok, hospital} ->
        hospital = Repo.preload(hospital, practitioners: [:role])

        conn
        |> put_flash(:info, "Hospital created successfully.")
        |> redirect(to: ~p"/hospitals/#{hospital}")

      {:error, %Ecto.Changeset{} = changeset} ->
        practitioners = Practitioners.list_practitioners() |> Repo.preload(:role)
        render(conn, :new, changeset: changeset, practitioners: practitioners)
    end
  end

  def show(conn, %{"id" => id}) do
    hospital = Hospitals.get_hospital!(id)
               |> Repo.preload(practitioners: [:role])
    render(conn, :show, hospital: hospital)
  end

  def edit(conn, %{"id" => id}) do
    hospital = Hospitals.get_hospital!(id)
               |> Repo.preload(practitioners: [:role])
    changeset = Hospitals.change_hospital(hospital)
    practitioners = Practitioners.list_practitioners() |> Repo.preload(:role)
    render(conn, :edit, hospital: hospital, changeset: changeset, practitioners: practitioners)
  end

  def update(conn, %{"id" => id, "hospital" => hospital_params}) do
    hospital = Hospitals.get_hospital!(id)
               |> Repo.preload(practitioners: [:role])

    case Hospitals.update_hospital(hospital, hospital_params) do
      {:ok, hospital} ->
        conn
        |> put_flash(:info, "Hospital updated successfully.")
        |> redirect(to: ~p"/hospitals/#{hospital}")

      {:error, %Ecto.Changeset{} = changeset} ->
        practitioners = Practitioners.list_practitioners() |> Repo.preload(:role)

        render(conn, :edit,
          hospital: hospital,
          changeset: changeset,
          practitioners: practitioners
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    hospital = Hospitals.get_hospital!(id) |> Repo.preload(:practitioners)
    {:ok, _hospital} = Hospitals.delete_hospital(hospital)

    conn
    |> put_flash(:info, "Hospital deleted successfully.")
    |> redirect(to: ~p"/hospitals")
  end

  def handle_api_key(conn, %{"id" => id}) do
    hospital = Hospitals.get_hospital!(id) |> Repo.preload(:practitioners)
    api_key = Hospitals.generate_api_key()
    changeset = Hospitals.change_hospital(hospital, %{api_key: api_key})
    render(conn, :api_key_gen, hospital: hospital, api_key: api_key, changeset: changeset)
  end

  def handle_api_key(conn, %{"id" => id, "hospital" => %{"api_key" => api_key}}) do
    hospital = Hospitals.get_hospital!(id) |> Repo.preload(:practitioners)

    case Hospitals.update_hospital(hospital, %{api_key: api_key}) do
      {:ok, _hospital} ->
        conn
        |> put_flash(:info, "API key saved successfully.")
        |> redirect(to: ~p"/hospitals")
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :api_key_gen, hospital: hospital, api_key: api_key, changeset: changeset)
    end
  end
end
