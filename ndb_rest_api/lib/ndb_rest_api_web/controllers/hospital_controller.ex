defmodule NdbRestApiWeb.HospitalController do
  use NdbRestApiWeb, :controller

  alias NdbRestApi.Hospitals
  alias NdbRestApi.Hospitals.Hospital
  alias NdbRestApi.Practitioners
  alias NdbRestApi.Repo

  def index(conn, _params) do
    hospitals = Hospitals.list_hospitals() |> Repo.preload(:practitioners)
    render(conn, :index, hospitals: hospitals)
  end

  def new(conn, _params) do
    changeset = Hospitals.change_hospital(%Hospital{})
    practitioners = Practitioners.list_practitioners()
    render(conn, :new, changeset: changeset, practitioners: practitioners)
  end

  def create(conn, %{"hospital" => hospital_params}) do
    case Hospitals.create_hospital(hospital_params) do
      {:ok, hospital} ->
        conn
        |> put_flash(:info, "Hospital created successfully.")
        |> redirect(to: ~p"/hospitals/#{hospital}")

      {:error, %Ecto.Changeset{} = changeset} ->
        practitioners = Practitioners.list_practitioners()
        render(conn, :new, changeset: changeset, practitioners: practitioners)
    end
  end

  def show(conn, %{"id" => id}) do
    hospital = Hospitals.get_hospital!(id) |> Repo.preload(:practitioners)
    render(conn, :show, hospital: hospital)
  end

  def edit(conn, %{"id" => id}) do
    hospital = Hospitals.get_hospital!(id) |> Repo.preload(:practitioners)
    changeset = Hospitals.change_hospital(hospital)
    practitioners = Practitioners.list_practitioners()
    render(conn, :edit, hospital: hospital, changeset: changeset, practitioners: practitioners)
  end

  def update(conn, %{"id" => id, "hospital" => hospital_params}) do
    hospital = Hospitals.get_hospital!(id) |> Repo.preload(:practitioners)

    case Hospitals.update_hospital(hospital, hospital_params) do
      {:ok, hospital} ->
        conn
        |> put_flash(:info, "Hospital updated successfully.")
        |> redirect(to: ~p"/hospitals/#{hospital}")

      {:error, %Ecto.Changeset{} = changeset} ->
        practitioners = Practitioners.list_practitioners()
        render(conn, :edit, hospital: hospital, changeset: changeset, practitioners: practitioners)
    end
  end

  def delete(conn, %{"id" => id}) do
    hospital = Hospitals.get_hospital!(id)
    {:ok, _hospital} = Hospitals.delete_hospital(hospital)

    conn
    |> put_flash(:info, "Hospital deleted successfully.")
    |> redirect(to: ~p"/hospitals")
  end
end
