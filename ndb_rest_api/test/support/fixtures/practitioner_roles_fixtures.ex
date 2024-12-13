defmodule NdbRestApi.PractitionerRolesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `NdbRestApi.PractitionerRoles` context.
  """

  @doc """
  Generate a practitioner_role.
  """
  def practitioner_role_fixture(attrs \\ %{}) do
    {:ok, practitioner_role} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> NdbRestApi.PractitionerRoles.create_practitioner_role()

    practitioner_role
  end
end
