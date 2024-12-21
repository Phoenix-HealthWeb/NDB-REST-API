defmodule NdbRestApi.Practitioners.Practitioner do
  use Ecto.Schema
  import Ecto.Changeset

  schema "practitioners" do
    field :email, :string
    field :forename, :string
    field :surname, :string
    field :date_of_birth, :date
    field :qualification, :string

    belongs_to :gender, NdbRestApi.Genders.Gender
    belongs_to :role, NdbRestApi.PractitionerRoles.PractitionerRole
    many_to_many :hospitals, NdbRestApi.Hospitals.Hospital, join_through: "hospitals_practitioners", on_replace: :delete

    timestamps(type: :utc_datetime)
  end

  @spec changeset(
          {map(),
           %{
             optional(atom()) =>
               atom()
               | {:array | :assoc | :embed | :in | :map | :parameterized | :supertype | :try,
                  any()}
           }}
          | %{
              :__struct__ => atom() | %{:__changeset__ => any(), optional(any()) => any()},
              optional(atom()) => any()
            },
          :invalid | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: Ecto.Changeset.t()
  @spec changeset(
          {map(),
           %{
             optional(atom()) =>
               atom()
               | {:array | :assoc | :embed | :in | :map | :parameterized | :supertype | :try,
                  any()}
           }}
          | %{
              :__struct__ => atom() | %{:__changeset__ => any(), optional(any()) => any()},
              optional(atom()) => any()
            },
          :invalid | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: Ecto.Changeset.t()
  @doc false
  def changeset(practitioner, attrs) do
    practitioner
    |> cast(attrs, [:email, :forename, :surname, :date_of_birth, :qualification, :gender_id, :role_id])
    |> validate_required([:email, :forename, :surname, :date_of_birth, :qualification, :gender_id, :role_id])
    |> unique_constraint(:email)
    |> put_assoc(:hospitals, get_hospitals(attrs))
  end

  defp get_hospitals(%{"hospital_ids" => hospital_ids}) when is_list(hospital_ids) do
    hospital_ids
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(&NdbRestApi.Hospitals.get_hospital!/1)
  end
  defp get_hospitals(_), do: []
end
