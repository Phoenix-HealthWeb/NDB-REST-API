defmodule NdbRestApi.MedicationRequests.MedicationRequest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "medication_requests" do
    field :date_time, :utc_datetime
    field :expiration_date, :date
    field :medication, :string
    field :posology, :string
    # field :patient_id, :id
    # field :practitioner_id, :id
    belongs_to :patient, NdbRestApi.Patients.Patient
    belongs_to :practitioner, NdbRestApi.Practitioners.Practitioner
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(medication_request, attrs) do
    medication_request
    |> cast(attrs, [
      :date_time,
      :expiration_date,
      :medication,
      :posology,
      :patient_id,
      :practitioner_id
    ])
    |> validate_required([:date_time, :expiration_date, :medication, :posology])
  end
end
