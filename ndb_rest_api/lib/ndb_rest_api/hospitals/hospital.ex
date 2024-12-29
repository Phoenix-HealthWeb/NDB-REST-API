defmodule NdbRestApi.Hospitals.Hospital do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "hospitals" do
    field :name, :string
    field :address, :string
    field :region, :string
    field :notes, :string
    field :api_key, :string
    field :api_key_not_confirmed, :string

    many_to_many :practitioners, NdbRestApi.Practitioners.Practitioner,
      join_through: "hospitals_practitioners",
      on_replace: :delete

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(hospital, attrs) do
    hospital
    |> cast(attrs, [:name, :address, :region, :notes, :api_key, :api_key_not_confirmed])
    |> validate_required([:name, :address, :region])
    |> put_assoc(:practitioners, get_practitioners(attrs))
    |> hash_api_key()
  end

  defp hash_api_key(changeset) do
    case get_change(changeset, :api_key) do
      nil -> changeset
      api_key -> put_change(changeset, :api_key, Bcrypt.hash_pwd_salt(api_key))
    end
  end

  defp get_practitioners(attrs) do
    practitioner_ids = Map.get(attrs, "practitioner_ids", [])
    NdbRestApi.Repo.all(from p in NdbRestApi.Practitioners.Practitioner, where: p.id in ^practitioner_ids)
  end
end
