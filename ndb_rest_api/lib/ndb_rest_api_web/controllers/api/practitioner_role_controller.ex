defmodule NdbRestApiWeb.Api.PractitionerRoleController do
  use NdbRestApiWeb, :controller

  alias NdbRestApi.PractitionerRoles
  alias NdbRestApi.PractitionerRoles.PractitionerRole

  action_fallback NdbRestApiWeb.FallbackController

  def index(conn, _params) do
    practitioner_roles = PractitionerRoles.list_practitioner_roles()
    render(conn, :index, practitioner_roles: practitioner_roles)
  end

  def create(conn, %{"practitioner_role" => practitioner_role_params}) do
    with {:ok, %PractitionerRole{} = practitioner_role} <- PractitionerRoles.create_practitioner_role(practitioner_role_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/api/practitioner_roles/#{practitioner_role}")
      |> render(:show, practitioner_role: practitioner_role)
    end
  end

  def show(conn, %{"id" => id}) do
    practitioner_role = PractitionerRoles.get_practitioner_role!(id)
    render(conn, :show, practitioner_role: practitioner_role)
  end

  def update(conn, %{"id" => id, "practitioner_role" => practitioner_role_params}) do
    practitioner_role = PractitionerRoles.get_practitioner_role!(id)

    with {:ok, %PractitionerRole{} = practitioner_role} <- PractitionerRoles.update_practitioner_role(practitioner_role, practitioner_role_params) do
      render(conn, :show, practitioner_role: practitioner_role)
    end
  end

  def delete(conn, %{"id" => id}) do
    practitioner_role = PractitionerRoles.get_practitioner_role!(id)

    with {:ok, %PractitionerRole{}} <- PractitionerRoles.delete_practitioner_role(practitioner_role) do
      send_resp(conn, :no_content, "")
    end
  end
end
