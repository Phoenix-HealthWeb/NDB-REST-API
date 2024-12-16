defmodule NdbRestApi.Practitioners.Practitioner do
  use Ecto.Schema
  import Ecto.Changeset

  schema "practitioners" do
    field :email, :string
    field :forename, :string
    field :surname, :string
    field :date_of_birth, :date
    field :qualification, :string
    field :gender_id, :id
    field :role_id, :id
    has_many :medication_requests, NdbRestApi.MedicationRequests.MedicationRequest
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(practitioner, attrs) do
    practitioner
    |> cast(attrs, [:email, :forename, :surname, :date_of_birth, :qualification])
    |> validate_required([:email, :forename, :surname, :date_of_birth, :qualification])
    |> unique_constraint(:email)
  end
end
