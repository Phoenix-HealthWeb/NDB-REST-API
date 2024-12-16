defmodule NdbRestApiWeb.Api.ObservationJSON do
  alias NdbRestApi.Observations.Observation

  @doc """
  Renders a list of observations.
  """
  def index(%{observations: observations}) do
    %{data: for(observation <- observations, do: data(observation))}
  end

  @doc """
  Renders a single observation.
  """
  def show(%{observation: observation}) do
    %{data: data(observation)}
  end

  defp data(%Observation{} = observation) do
    %{
      id: observation.id,
      patient: patient(observation.patient),
      practitioner: practitioner(observation.practitioner),
      ward: observation.ward,
      date_time: observation.date_time,
      result: observation.result
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
