defmodule NdbRestApi.Patients.Patient do
  use Ecto.Schema
  import Ecto.Changeset

  schema "patients" do
    field :cf, :string
    field :firstname, :string
    field :lastname, :string
    field :date_of_birth, :date
    # field :gender_id, :id
    belongs_to :gender, NdbRestApi.Genders.Gender
    has_many :medication_requests, NdbRestApi.MedicationRequests.MedicationRequest
    has_many :observations, NdbRestApi.Observations.Observation
    has_many :conditions, NdbRestApi.Conditions.Condition
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(patient, attrs) do
    patient
    |> cast(attrs, [:firstname, :lastname, :cf, :gender_id, :date_of_birth])
    |> validate_required([:firstname, :lastname, :cf, :gender_id, :date_of_birth])
    |> unsafe_validate_unique(:cf, NdbRestApi.Repo)
    |> unique_constraint(:cf)
  end
end
