defmodule NdbRestApiWeb.Api.ConditionController do
  use NdbRestApiWeb, :controller

  alias NdbRestApi.Conditions
  alias NdbRestApi.Conditions.Condition
  alias NdbRestApi.Repo

  action_fallback NdbRestApiWeb.FallbackController

  def index(conn, _params) do
    conditions =
      Conditions.list_conditions()
      |> Repo.preload(:patient)
      |> Repo.preload(:practitioner)

    render(conn, :index, conditions: conditions)
  end

  def create(conn, %{"condition" => condition_params}) do
    with {:ok, %Condition{} = condition} <- Conditions.create_condition(condition_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/conditions/#{condition}")
      |> render(:show, condition: condition)
    end
  end

  def show(conn, %{"id" => id}) do
    condition =
      Conditions.get_condition!(id)
      |> Repo.preload(:patient)
      |> Repo.preload(:practitioner)

    render(conn, :show, condition: condition)
  end

  def update(conn, %{"id" => id, "condition" => condition_params}) do
    condition = Conditions.get_condition!(id)

    with {:ok, %Condition{} = condition} <-
           Conditions.update_condition(condition, condition_params) do
      render(conn, :show, condition: condition)
    end
  end

  def delete(conn, %{"id" => id}) do
    condition = Conditions.get_condition!(id)

    with {:ok, %Condition{}} <- Conditions.delete_condition(condition) do
      send_resp(conn, :no_content, "")
    end
  end
end
