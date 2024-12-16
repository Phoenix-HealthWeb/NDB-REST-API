defmodule NdbRestApiWeb.Api.MedicationRequestJSON do
  alias NdbRestApi.MedicationRequests.MedicationRequest

  @doc """
  Renders a list of medication_requests.
  """
  def index(%{medication_requests: medication_requests}) do
    %{data: for(medication_request <- medication_requests, do: data(medication_request))}
  end

  @doc """
  Renders a single medication_request.
  """
  def show(%{medication_request: medication_request}) do
    %{data: data(medication_request)}
  end

  defp data(%MedicationRequest{} = medication_request) do
    %{
      id: medication_request.id,
      date_time: medication_request.date_time,
      expiration_date: medication_request.expiration_date,
      medication: medication_request.medication,
      patient: patient(medication_request.patient),
      practitioner: practitioner(medication_request.practitioner),
      posology: medication_request.posology
    }
  end

  defp patient(patient) do
    %{
      id: patient.id,
      firstname: patient.firstname,
      lastname: patient.lastname,
      cf: patient.cf,
      date_of_birth: patient.date_of_birth,
      gender_id: patient.gender_id
    }
  end

  defp practitioner(practitioner) do
    %{
      id: practitioner.id,
      email: practitioner.email,
      forename: practitioner.forename,
      surname: practitioner.surname,
      date_of_birth: practitioner.date_of_birth,
      role_id: practitioner.role_id,
      qualification: practitioner.qualification,
      gender_id: practitioner.gender_id
    }
  end
end
