defmodule NdbRestApi.Hospitals do
  @moduledoc """
  The Hospitals context.
  """

  import Ecto.Query, warn: false
  alias NdbRestApi.Repo

  alias NdbRestApi.Hospitals.Hospital

  @doc """
  Returns the list of hospitals.

  ## Examples

      iex> list_hospitals()
      [%Hospital{}, ...]

  """
  def list_hospitals do
    from(h in Hospital, order_by: [asc: :name])
    |> Repo.all()
  end

  @doc """
  Gets a single hospital.

  Raises `Ecto.NoResultsError` if the Hospital does not exist.

  ## Examples

      iex> get_hospital!(123)
      %Hospital{}

      iex> get_hospital!(456)
      ** (Ecto.NoResultsError)

  """
  def get_hospital!(id), do: Repo.get!(Hospital, id)

  @doc """
  Gets a single hospital.

  Returns `nil` if the Hospital does not exist.

  ## Examples

      iex> get_hospital(123)
      %Hospital{}

      iex> get_hospital(456)
      nil

  """
  def get_hospital(id) do
    Repo.get(Hospital, id)
  end

  @doc """
  Creates a hospital.

  ## Examples

      iex> create_hospital(%{field: value})
      {:ok, %Hospital{}}

      iex> create_hospital(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_hospital(attrs \\ %{}) do
    %Hospital{}
    |> Hospital.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a hospital.

  ## Examples

      iex> update_hospital(hospital, %{field: new_value})
      {:ok, %Hospital{}}

      iex> update_hospital(hospital, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_hospital(%Hospital{} = hospital, attrs) do
    hospital
    |> Hospital.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a hospital.

  ## Examples

      iex> delete_hospital(hospital)
      {:ok, %Hospital{}}

      iex> delete_hospital(hospital)
      {:error, %Ecto.Changeset{}}

  """
  def delete_hospital(%Hospital{} = hospital) do
    Repo.delete(hospital)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking hospital changes.

  ## Examples

      iex> change_hospital(hospital)
      %Ecto.Changeset{data: %Hospital{}}

  """
  def change_hospital(%Hospital{} = hospital, attrs \\ %{}) do
    Hospital.changeset(hospital, attrs)
  end

  def generate_api_key do
    :crypto.strong_rand_bytes(32) |> Base.encode64()
  end

  def check_api_key(%Hospital{} = hospital, api_key) do
    case Bcrypt.verify_pass(api_key, hospital.api_key) do
      true -> {:ok, hospital}
      false -> {:error, :unauthorized}
    end
  end

  def update_hospital_api_key(%Hospital{} = hospital, attrs) do
    now = DateTime.utc_now() |> DateTime.truncate(:second)

    result =
      from(h in Hospital, where: h.id == ^hospital.id)
      |> Repo.update_all(
        set: [
          api_key: Bcrypt.hash_pwd_salt(attrs.api_key),
          api_key_not_confirmed: attrs.api_key_not_confirmed,
          updated_at: now
        ]
      )

    case result do
      {1, _} -> {:ok, Repo.get!(Hospital, hospital.id) |> Repo.preload(:practitioners)}
      _ -> {:error, "Failed to update API key"}
    end
  end
end
