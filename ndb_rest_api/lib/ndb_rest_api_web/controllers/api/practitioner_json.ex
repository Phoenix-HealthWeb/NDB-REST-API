defmodule NdbRestApiWeb.Api.PractitionerJSON do
  alias NdbRestApi.Practitioners.Practitioner

  @doc """
  Renders a list of practitioners.
  """
  def index(%{practitioners: practitioners}) do
    %{data: for(practitioner <- practitioners, do: data(practitioner))}
  end

  @doc """
  Renders a single practitioner.
  """
  def show(%{practitioner: practitioner}) do
    %{data: data(practitioner)}
  end

  defp data(%Practitioner{} = practitioner) do
    %{
      id: practitioner.id,
      email: practitioner.email,
      forename: practitioner.forename,
      surname: practitioner.surname,
      date_of_birth: practitioner.date_of_birth,
      qualification: practitioner.qualification,
      gender: practitioner.gender.name,
      role: practitioner.role.name
    }
  end
end
