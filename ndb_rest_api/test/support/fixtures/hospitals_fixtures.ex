defmodule NdbRestApi.HospitalsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `NdbRestApi.Hospitals` context.
  """

  @doc """
  Generate a hospital.
  """
  def hospital_fixture(attrs \\ %{}) do
    {:ok, hospital} =
      attrs
      |> Enum.into(%{
        address: "some address",
        api_key: "some api_key",
        name: "some name",
        notes: "some notes",
        region: "some region"
      })
      |> NdbRestApi.Hospitals.create_hospital()

    hospital
  end
end
