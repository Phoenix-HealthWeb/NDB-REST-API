defmodule NdbRestApi.PractitionerRoles.PractitionerRole do
  use Ecto.Schema
  import Ecto.Changeset

  schema "practitioner_roles" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(practitioner_role, attrs) do
    practitioner_role
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
