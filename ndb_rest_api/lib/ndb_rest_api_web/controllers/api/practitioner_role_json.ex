defmodule NdbRestApiWeb.Api.PractitionerRoleJSON do
  alias NdbRestApi.PractitionerRoles.PractitionerRole

  @doc """
  Renders a list of practitioner_roles.
  """
  def index(%{practitioner_roles: practitioner_roles}) do
    %{data: for(practitioner_role <- practitioner_roles, do: data(practitioner_role))}
  end

  @doc """
  Renders a single practitioner_role.
  """
  def show(%{practitioner_role: practitioner_role}) do
    %{data: data(practitioner_role)}
  end

  defp data(%PractitionerRole{} = practitioner_role) do
    %{
      id: practitioner_role.id,
      name: practitioner_role.name
    }
  end
end
