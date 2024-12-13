defmodule NdbRestApiWeb.PractitionerRoleController do
  use NdbRestApiWeb, :controller

  alias NdbRestApi.PractitionerRoles
  alias NdbRestApi.PractitionerRoles.PractitionerRole

  def index(conn, _params) do
    practitioner_roles = PractitionerRoles.list_practitioner_roles()
    render(conn, :index, practitioner_roles: practitioner_roles)
  end

  def new(conn, _params) do
    changeset = PractitionerRoles.change_practitioner_role(%PractitionerRole{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"practitioner_role" => practitioner_role_params}) do
    case PractitionerRoles.create_practitioner_role(practitioner_role_params) do
      {:ok, practitioner_role} ->
        conn
        |> put_flash(:info, "Practitioner role created successfully.")
        |> redirect(to: ~p"/practitioner_roles/#{practitioner_role}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    practitioner_role = PractitionerRoles.get_practitioner_role!(id)
    render(conn, :show, practitioner_role: practitioner_role)
  end

  def edit(conn, %{"id" => id}) do
    practitioner_role = PractitionerRoles.get_practitioner_role!(id)
    changeset = PractitionerRoles.change_practitioner_role(practitioner_role)
    render(conn, :edit, practitioner_role: practitioner_role, changeset: changeset)
  end

  def update(conn, %{"id" => id, "practitioner_role" => practitioner_role_params}) do
    practitioner_role = PractitionerRoles.get_practitioner_role!(id)

    case PractitionerRoles.update_practitioner_role(practitioner_role, practitioner_role_params) do
      {:ok, practitioner_role} ->
        conn
        |> put_flash(:info, "Practitioner role updated successfully.")
        |> redirect(to: ~p"/practitioner_roles/#{practitioner_role}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, practitioner_role: practitioner_role, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    practitioner_role = PractitionerRoles.get_practitioner_role!(id)
    {:ok, _practitioner_role} = PractitionerRoles.delete_practitioner_role(practitioner_role)

    conn
    |> put_flash(:info, "Practitioner role deleted successfully.")
    |> redirect(to: ~p"/practitioner_roles")
  end
end
