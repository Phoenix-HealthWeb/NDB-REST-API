defmodule NdbRestApiWeb.Api.ConditionJSON do
  alias NdbRestApi.Conditions.Condition

  @doc """
  Renders a list of conditions.
  """
  def index(%{conditions: conditions}) do
    %{data: for(condition <- conditions, do: data(condition))}
  end

  @doc """
  Renders a single condition.
  """
  def show(%{condition: condition}) do
    %{data: data(condition)}
  end

  defp data(%Condition{} = condition) do
    %{
      id: condition.id,
      patient: patient(condition.patient),
      practitioner: practitioner(condition.practitioner),
      date_time: condition.date_time,
      comment: condition.comment
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
