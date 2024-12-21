defmodule NdbRestApiWeb.PractitionerController do
  use NdbRestApiWeb, :controller

  alias NdbRestApi.Practitioners
  alias NdbRestApi.Practitioners.Practitioner
  alias NdbRestApi.Genders
  alias NdbRestApi.PractitionerRoles
  alias NdbRestApi.Hospitals
  alias NdbRestApi.Repo

  def index(conn, _params) do
    practitioners = Practitioners.list_practitioners() |> Repo.preload([:gender, :role, :hospitals])
    render(conn, :index, practitioners: practitioners)
  end

  def new(conn, _params) do
    changeset = Practitioners.change_practitioner(%Practitioner{hospitals: []})
    genders = Genders.list_genders()
    roles = PractitionerRoles.list_practitioner_roles()
    hospitals = Hospitals.list_hospitals()
    render(conn, :new, changeset: changeset, genders: genders, roles: roles, hospitals: hospitals)
  end

  def create(conn, %{"practitioner" => practitioner_params}) do
    case Practitioners.create_practitioner(practitioner_params) do
      {:ok, practitioner} ->
        practitioner = Repo.preload(practitioner, :hospitals)
        conn
        |> put_flash(:info, "Practitioner created successfully.")
        |> redirect(to: ~p"/practitioners/#{practitioner}")

      {:error, %Ecto.Changeset{} = changeset} ->
        genders = Genders.list_genders()
        roles = PractitionerRoles.list_practitioner_roles()
        hospitals = Hospitals.list_hospitals()
        render(conn, :new, changeset: changeset, genders: genders, roles: roles, hospitals: hospitals)
    end
  end

  def show(conn, %{"id" => id}) do
    practitioner = Practitioners.get_practitioner!(id) |> Repo.preload([:gender, :role, :hospitals])
    hospitals = practitioner.hospitals
    render(conn, :show, practitioner: practitioner)
  end

  def edit(conn, %{"id" => id}) do
    practitioner = Practitioners.get_practitioner!(id) |> Repo.preload([:gender, :role, :hospitals])
    changeset = Practitioners.change_practitioner(practitioner)
    genders = Genders.list_genders()
    roles = PractitionerRoles.list_practitioner_roles()
    hospitals = Hospitals.list_hospitals()
    render(conn, :edit, practitioner: practitioner, changeset: changeset, genders: genders, roles: roles, hospitals: hospitals)
  end

  @spec update(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def update(conn, %{"id" => id, "practitioner" => practitioner_params}) do
    practitioner = Practitioners.get_practitioner!(id) |> Repo.preload([:gender, :role, :hospitals])

    case Practitioners.update_practitioner(practitioner, practitioner_params) do
      {:ok, practitioner} ->
        conn
        |> put_flash(:info, "Practitioner updated successfully.")
        |> redirect(to: ~p"/practitioners/#{practitioner}")

      {:error, %Ecto.Changeset{} = changeset} ->
        genders = Genders.list_genders()
        roles = PractitionerRoles.list_practitioner_roles()
        hospitals = Hospitals.list_hospitals()
        render(conn, :edit, practitioner: practitioner, changeset: changeset, genders: genders, roles: roles, hospitals: hospitals)
    end
  end

  def delete(conn, %{"id" => id}) do
    practitioner = Practitioners.get_practitioner!(id) |> Repo.preload([:gender, :role, :hospitals])
    {:ok, _practitioner} = Practitioners.delete_practitioner(practitioner)

    conn
    |> put_flash(:info, "Practitioner deleted successfully.")
    |> redirect(to: ~p"/practitioners")
  end
end
