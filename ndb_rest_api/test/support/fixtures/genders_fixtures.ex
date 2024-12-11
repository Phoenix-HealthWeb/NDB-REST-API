defmodule NdbRestApi.GendersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `NdbRestApi.Genders` context.
  """

  @doc """
  Generate a gender.
  """
  def gender_fixture(attrs \\ %{}) do
    {:ok, gender} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> NdbRestApi.Genders.create_gender()

    gender
  end
end
