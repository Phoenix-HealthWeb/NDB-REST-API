defmodule NdbRestApiWeb.Api.GenderJSON do
  alias NdbRestApi.Genders.Gender

  @doc """
  Renders a list of genders.
  """
  def index(%{genders: genders}) do
    %{data: for(gender <- genders, do: data(gender))}
  end

  @doc """
  Renders a single gender.
  """
  def show(%{gender: gender}) do
    %{data: data(gender)}
  end

  defp data(%Gender{} = gender) do
    %{
      id: gender.id,
      name: gender.name
    }
  end
end
