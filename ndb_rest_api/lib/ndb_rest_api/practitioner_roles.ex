defmodule NdbRestApi.PractitionerRoles do
  @moduledoc """
  The PractitionerRoles context.
  """

  import Ecto.Query, warn: false
  alias NdbRestApi.Repo

  alias NdbRestApi.PractitionerRoles.PractitionerRole

  @doc """
  Returns the list of practitioner_roles.

  ## Examples

      iex> list_practitioner_roles()
      [%PractitionerRole{}, ...]

  """
  def list_practitioner_roles do
    Repo.all(PractitionerRole)
  end

  @doc """
  Gets a single practitioner_role.

  Raises `Ecto.NoResultsError` if the Practitioner role does not exist.

  ## Examples

      iex> get_practitioner_role!(123)
      %PractitionerRole{}

      iex> get_practitioner_role!(456)
      ** (Ecto.NoResultsError)

  """
  def get_practitioner_role!(id), do: Repo.get!(PractitionerRole, id)

  @doc """
  Creates a practitioner_role.

  ## Examples

      iex> create_practitioner_role(%{field: value})
      {:ok, %PractitionerRole{}}

      iex> create_practitioner_role(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_practitioner_role(attrs \\ %{}) do
    %PractitionerRole{}
    |> PractitionerRole.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a practitioner_role.

  ## Examples

      iex> update_practitioner_role(practitioner_role, %{field: new_value})
      {:ok, %PractitionerRole{}}

      iex> update_practitioner_role(practitioner_role, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_practitioner_role(%PractitionerRole{} = practitioner_role, attrs) do
    practitioner_role
    |> PractitionerRole.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a practitioner_role.

  ## Examples

      iex> delete_practitioner_role(practitioner_role)
      {:ok, %PractitionerRole{}}

      iex> delete_practitioner_role(practitioner_role)
      {:error, %Ecto.Changeset{}}

  """
  def delete_practitioner_role(%PractitionerRole{} = practitioner_role) do
    Repo.delete(practitioner_role)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking practitioner_role changes.

  ## Examples

      iex> change_practitioner_role(practitioner_role)
      %Ecto.Changeset{data: %PractitionerRole{}}

  """
  def change_practitioner_role(%PractitionerRole{} = practitioner_role, attrs \\ %{}) do
    PractitionerRole.changeset(practitioner_role, attrs)
  end
end
