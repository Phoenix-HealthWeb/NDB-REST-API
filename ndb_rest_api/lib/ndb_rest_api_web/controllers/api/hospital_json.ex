defmodule NdbRestApiWeb.Api.HospitalJSON do
  alias NdbRestApi.Hospitals.Hospital

  @doc """
  Renders a list of hospitals.
  """
  def index(%{hospitals: hospitals}) do
    %{data: for(hospital <- hospitals, do: data(hospital))}
  end

  @doc """
  Renders a single hospital.
  """
  def show(%{hospital: hospital}) do
    %{data: data(hospital)}
  end

  defp data(%Hospital{} = hospital) do
    %{
      id: hospital.id,
      name: hospital.name,
      address: hospital.address,
      region: hospital.region,
      notes: hospital.notes,
    }
  end
end
