defmodule NdbRestApiWeb.Api.ObservationController do
  use NdbRestApiWeb, :controller

  alias NdbRestApi.Observations
  alias NdbRestApi.Observations.Observation
  alias NdbRestApi.Repo

  action_fallback NdbRestApiWeb.FallbackController

  def index(conn, _params) do
    observations =
      Observations.list_observations()
      |> Repo.preload(:patient)
      |> Repo.preload(:practitioner)

    render(conn, :index, observations: observations)
  end

  def create(conn, %{"observation" => observation_params}) do
    with {:ok, %Observation{} = observation} <-
           Observations.create_observation(observation_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/observations/#{observation}")
      |> render(:show, observation: observation)
    end
  end

  def show(conn, %{"id" => id}) do
    observation =
      Observations.get_observation!(id)
      |> Repo.preload(:patient)
      |> Repo.preload(:practitioner)

    render(conn, :show, observation: observation)
  end

  def update(conn, %{"id" => id, "observation" => observation_params}) do
    observation = Observations.get_observation!(id)

    with {:ok, %Observation{} = observation} <-
           Observations.update_observation(observation, observation_params) do
      render(conn, :show, observation: observation)
    end
  end

  def delete(conn, %{"id" => id}) do
    observation = Observations.get_observation!(id)

    with {:ok, %Observation{}} <- Observations.delete_observation(observation) do
      send_resp(conn, :no_content, "")
    end
  end
end
