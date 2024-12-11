defmodule NdbRestApi.Genders.Gender do
  use Ecto.Schema
  import Ecto.Changeset

  schema "genders" do
    field :name, :string
    has_many :patients, NdbRestApi.Patients.Patient
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(gender, attrs) do
    gender
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
