defmodule NdbRestApi.HospitalsPractitioners do
  use Ecto.Schema
  import Ecto.Changeset

  schema "hospitals_practitioners" do
    field :hospital_id, :id
    field :practitioner_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(hospitals_practitioners, attrs) do
    hospitals_practitioners
    |> cast(attrs, [:hospital_id, :practitioner_id])
    |> validate_required([:hospital_id, :practitioner_id])
  end
end
