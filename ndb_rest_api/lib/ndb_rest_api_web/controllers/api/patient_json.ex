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
      cf: patient.cf,
      firstname: patient.firstname,
      lastname: patient.lastname,
      gender: patient.gender.name,
      cf: patient.cf,
      date_of_birth: patient.date_of_birth,
      medication_requests: medication_requests(patient.medication_requests),
      observations: observations(patient.observations),
      conditions: conditions(patient.conditions)
    }
  end

  def medication_requests(medication_requests) do
    for medication_request <- medication_requests do
      %{
        id: medication_request.id,
        date_time: medication_request.date_time,
        expiration_date: medication_request.expiration_date,
        medication: medication_request.medication,
        posology: medication_request.posology
      }
    end
  end

  def observations(observations) do
    for observation <- observations do
      %{
        id: observation.id,
        ward: observation.ward,
        date_time: observation.date_time,
        result: observation.result
      }
    end
  end

  def conditions(conditions) do
    for condition <- conditions do
      %{
        id: condition.id,
        comment: condition.comment,
        date_time: condition.date_time
      }
    end
  end
end
