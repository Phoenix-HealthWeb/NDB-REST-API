defmodule NdbRestApi.Conditions.Condition do
  use Ecto.Schema
  import Ecto.Changeset

  schema "conditions" do
    field :comment, :string
    field :date_time, :utc_datetime
    # field :patient_id, :id
    # field :practitioner_id, :id
    belongs_to :patient, NdbRestApi.Patients.Patient
    belongs_to :practitioner, NdbRestApi.Practitioners.Practitioner
    field :hospital_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(condition, attrs) do
    condition
    |> cast(attrs, [:date_time, :comment, :patient_id, :practitioner_id])
    |> validate_required([:date_time, :comment])
  end
end
