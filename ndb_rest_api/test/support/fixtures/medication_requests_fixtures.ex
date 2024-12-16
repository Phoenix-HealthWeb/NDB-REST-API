defmodule NdbRestApi.MedicationRequestsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `NdbRestApi.MedicationRequests` context.
  """

  @doc """
  Generate a medication_request.
  """
  def medication_request_fixture(attrs \\ %{}) do
    {:ok, medication_request} =
      attrs
      |> Enum.into(%{
        date_time: ~U[2024-12-15 14:56:00Z],
        expiration_date: ~D[2024-12-15],
        medication: "some medication",
        posology: "some posology"
      })
      |> NdbRestApi.MedicationRequests.create_medication_request()

    medication_request
  end
end
