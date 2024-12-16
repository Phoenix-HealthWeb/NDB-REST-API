defmodule NdbRestApi.ObservationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `NdbRestApi.Observations` context.
  """

  @doc """
  Generate a observation.
  """
  def observation_fixture(attrs \\ %{}) do
    {:ok, observation} =
      attrs
      |> Enum.into(%{
        date_time: ~U[2024-12-15 16:57:00Z],
        result: "some result",
        ward: "some ward"
      })
      |> NdbRestApi.Observations.create_observation()

    observation
  end
end
