defmodule NdbRestApi.PractitionersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `NdbRestApi.Practitioners` context.
  """

  @doc """
  Generate a unique practitioner email.
  """
  def unique_practitioner_email, do: "some email#{System.unique_integer([:positive])}"

  @doc """
  Generate a practitioner.
  """
  def practitioner_fixture(attrs \\ %{}) do
    {:ok, practitioner} =
      attrs
      |> Enum.into(%{
        date_of_birth: ~D[2024-12-16],
        email: unique_practitioner_email(),
        forename: "some forename",
        qualification: "some qualification",
        surname: "some surname"
      })
      |> NdbRestApi.Practitioners.create_practitioner()

    practitioner
  end
end
