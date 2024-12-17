defmodule NdbRestApi.Practitioners do
  @moduledoc """
  The Practitioners context.
  """

  import Ecto.Query, warn: false
  alias NdbRestApi.Repo

  alias NdbRestApi.Practitioners.Practitioner

  @doc """
  Returns the list of practitioners.

  ## Examples

      iex> list_practitioners()
      [%Practitioner{}, ...]

  """
  def list_practitioners do
    Repo.all(Practitioner)
  end

  @doc """
  Gets a single practitioner.

  Raises `Ecto.NoResultsError` if the Practitioner does not exist.

  ## Examples

      iex> get_practitioner!(123)
      %Practitioner{}

      iex> get_practitioner!(456)
      ** (Ecto.NoResultsError)

  """
  def get_practitioner!(id), do: Repo.get!(Practitioner, id)

  @doc """
  Creates a practitioner.

  ## Examples

      iex> create_practitioner(%{field: value})
      {:ok, %Practitioner{}}

      iex> create_practitioner(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_practitioner(attrs \\ %{}) do
    %Practitioner{}
    |> Practitioner.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a practitioner.

  ## Examples

      iex> update_practitioner(practitioner, %{field: new_value})
      {:ok, %Practitioner{}}

      iex> update_practitioner(practitioner, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_practitioner(%Practitioner{} = practitioner, attrs) do
    practitioner
    |> Practitioner.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a practitioner.

  ## Examples

      iex> delete_practitioner(practitioner)
      {:ok, %Practitioner{}}

      iex> delete_practitioner(practitioner)
      {:error, %Ecto.Changeset{}}

  """
  def delete_practitioner(%Practitioner{} = practitioner) do
    Repo.delete(practitioner)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking practitioner changes.

  ## Examples

      iex> change_practitioner(practitioner)
      %Ecto.Changeset{data: %Practitioner{}}

  """
  def change_practitioner(%Practitioner{} = practitioner, attrs \\ %{}) do
    Practitioner.changeset(practitioner, attrs)
  end
end
