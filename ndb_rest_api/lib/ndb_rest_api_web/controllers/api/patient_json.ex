defmodule NdbRestApiWeb.Api.PatientJSON do
  alias NdbRestApi.Patients.Patient

  @doc """
  Renders a list of patients.
  """
  def index(%{patients: patients}) do
    %{data: for(patient <- patients, do: data(patient))}
  end

  @doc """
  Renders a single patient.
  """
  def show(%{patient: patient}) do
    %{data: data(patient)}
  end

  defp data(%Patient{} = patient) do
    %{
      id: patient.id,
      firstname: patient.firstname,
      lastname: patient.lastname,
      gender: patient.gender.name,
      date_of_birth: patient.date_of_birth
    }
  end
end
