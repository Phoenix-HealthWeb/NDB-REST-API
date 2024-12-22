defmodule NdbRestApi.MedicationRequests do
  @moduledoc """
  The MedicationRequests context.
  """

  import Ecto.Query, warn: false
  alias NdbRestApi.Repo

  alias NdbRestApi.MedicationRequests.MedicationRequest

  @doc """
  Returns the list of medication_requests.

  ## Examples

      iex> list_medication_requests()
      [%MedicationRequest{}, ...]

  """
  def list_medication_requests do
    Repo.all(MedicationRequest)
  end

  @doc """
  Returns the list of medication_requests by patient_id.
  """
  def list_medication_requests_by_patient_id(patient_id) do
    Repo.all(from(m in MedicationRequest, where: m.patient_id == ^patient_id))
  end

  @doc """
  Gets a single medication_request.

  Raises `Ecto.NoResultsError` if the Medication request does not exist.

  ## Examples

      iex> get_medication_request!(123)
      %MedicationRequest{}

      iex> get_medication_request!(456)
      ** (Ecto.NoResultsError)

  """
  def get_medication_request!(id), do: Repo.get!(MedicationRequest, id)

  @doc """
  Creates a medication_request.

  ## Examples

      iex> create_medication_request(%{field: value})
      {:ok, %MedicationRequest{}}

      iex> create_medication_request(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_medication_request(attrs \\ %{}) do
    %MedicationRequest{}
    |> MedicationRequest.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a medication_request.

  ## Examples

      iex> update_medication_request(medication_request, %{field: new_value})
      {:ok, %MedicationRequest{}}

      iex> update_medication_request(medication_request, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_medication_request(%MedicationRequest{} = medication_request, attrs) do
    medication_request
    |> MedicationRequest.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a medication_request.

  ## Examples

      iex> delete_medication_request(medication_request)
      {:ok, %MedicationRequest{}}

      iex> delete_medication_request(medication_request)
      {:error, %Ecto.Changeset{}}

  """
  def delete_medication_request(%MedicationRequest{} = medication_request) do
    Repo.delete(medication_request)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking medication_request changes.

  ## Examples

      iex> change_medication_request(medication_request)
      %Ecto.Changeset{data: %MedicationRequest{}}

  """
  def change_medication_request(%MedicationRequest{} = medication_request, attrs \\ %{}) do
    MedicationRequest.changeset(medication_request, attrs)
  end
end
