defmodule NdbRestApi.HospitalsPractitioners do
  use Ecto.Schema
  import Ecto.Changeset

  schema "hospitals_practitioners" do


    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(hospitals_practitioners, attrs) do
    hospitals_practitioners
    |> cast(attrs, [])
    |> validate_required([])
  end
end
