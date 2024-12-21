defmodule NdbRestApi.Hospitals.Hospital do
  use Ecto.Schema
  import Ecto.Changeset

  schema "hospitals" do
    field :name, :string
    field :address, :string
    field :region, :string
    field :notes, :string
    field :api_key, :string

    many_to_many :practitioners, NdbRestApi.Practitioners.Practitioner, join_through: "hospitals_practitioners", on_replace: :delete

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(hospital, attrs) do
    hospital
    |> cast(attrs, [:name, :address, :region, :notes, :api_key])
    |> validate_required([:name, :address, :region, :notes, :api_key])
    |> put_assoc(:practitioners, get_practitioners(attrs))
  end

  defp get_practitioners(%{"practitioner_ids" => practitioner_ids}) when is_list(practitioner_ids) do
    practitioner_ids
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(&NdbRestApi.Practitioners.get_practitioner!/1)
  end
  defp get_practitioners(_), do: []
end
