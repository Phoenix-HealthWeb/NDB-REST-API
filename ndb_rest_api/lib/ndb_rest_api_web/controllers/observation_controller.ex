defmodule NdbRestApiWeb.ObservationController do
  use NdbRestApiWeb, :controller

  alias NdbRestApi.Observations
  alias NdbRestApi.Observations.Observation
  alias NdbRestApi.Repo
  alias NdbRestApi.Patients
  alias NdbRestApi.Practitioners

  def index(conn, _params) do
    observations =
      Observations.list_observations()
      |> Repo.preload(:patient)
      |> Repo.preload(:practitioner)

    render(conn, :index, observations: observations)
  end

  def new(conn, _params) do
    changeset = Observations.change_observation(%Observation{})
    patients = Patients.list_patients()
    practitioners = Practitioners.list_practitioners()
    render(conn, :new, changeset: changeset, patients: patients, practitioners: practitioners)
  end

  def create(conn, %{"observation" => observation_params}) do
    case Observations.create_observation(observation_params) do
      {:ok, observation} ->
        conn
        |> put_flash(:info, "Observation created successfully.")
        |> redirect(to: ~p"/observations/#{observation}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    observation =
      Observations.get_observation!(id)
      |> Repo.preload(:patient)
      |> Repo.preload(:practitioner)

    render(conn, :show, observation: observation)
  end

  def edit(conn, %{"id" => id}) do
    observation = Observations.get_observation!(id)
    patients = Patients.list_patients()
    practitioners = Practitioners.list_practitioners()
    changeset = Observations.change_observation(observation)

    render(conn, :edit,
      observation: observation,
      changeset: changeset,
      patients: patients,
      practitioners: practitioners
    )
  end

  def update(conn, %{"id" => id, "observation" => observation_params}) do
    observation = Observations.get_observation!(id)

    case Observations.update_observation(observation, observation_params) do
      {:ok, observation} ->
        conn
        |> put_flash(:info, "Observation updated successfully.")
        |> redirect(to: ~p"/observations/#{observation}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, observation: observation, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    observation = Observations.get_observation!(id)
    {:ok, _observation} = Observations.delete_observation(observation)

    conn
    |> put_flash(:info, "Observation deleted successfully.")
    |> redirect(to: ~p"/observations")
  end
end
