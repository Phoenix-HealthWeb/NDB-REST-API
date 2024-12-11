defmodule NdbRestApi.PatientsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `NdbRestApi.Patients` context.
  """

  @doc """
  Generate a patient.
  """
  def patient_fixture(attrs \\ %{}) do
    {:ok, patient} =
      attrs
      |> Enum.into(%{
        cf: "some cf",
        date_of_birth: ~D[2024-12-10],
        firstname: "some firstname",
        lastname: "some lastname"
      })
      |> NdbRestApi.Patients.create_patient()

    patient
  end
end
