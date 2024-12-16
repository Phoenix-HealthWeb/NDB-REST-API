defmodule NdbRestApi.ConditionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `NdbRestApi.Conditions` context.
  """

  @doc """
  Generate a condition.
  """
  def condition_fixture(attrs \\ %{}) do
    {:ok, condition} =
      attrs
      |> Enum.into(%{
        comment: "some comment",
        date_time: ~U[2024-12-15 16:33:00Z]
      })
      |> NdbRestApi.Conditions.create_condition()

    condition
  end
end
