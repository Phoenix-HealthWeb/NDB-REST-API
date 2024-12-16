defmodule NdbRestApi.Observations.Observation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "observations" do
    field :result, :string
    field :ward, :string
    field :date_time, :utc_datetime
    # field :patient_id, :id
    # field :practitioner_id, :id
    belongs_to :patient, NdbRestApi.Patients.Patient
    belongs_to :practitioner, NdbRestApi.Practitioners.Practitioner
    field :hospital_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(observation, attrs) do
    observation
    |> cast(attrs, [:ward, :date_time, :result, :patient_id, :practitioner_id])
    |> validate_required([:ward, :date_time, :result])
  end
end
