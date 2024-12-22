defmodule NdbRestApiWeb.Api.GenderController do
  use NdbRestApiWeb, :controller

  alias NdbRestApi.Genders
  alias NdbRestApi.Genders.Gender

  action_fallback NdbRestApiWeb.FallbackController

  def index(conn, _params) do
    genders = Genders.list_genders()
    render(conn, :index, genders: genders)
  end

  def create(conn, %{"gender" => gender_params}) do
    with {:ok, %Gender{} = gender} <- Genders.create_gender(gender_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/genders/#{gender}")
      |> render(:show, gender: gender)
    end
  end

  def show(conn, %{"id" => id}) do
    gender = Genders.get_gender!(id)
    render(conn, :show, gender: gender)
  end

  def update(conn, %{"id" => id, "gender" => gender_params}) do
    gender = Genders.get_gender!(id)

    with {:ok, %Gender{} = gender} <- Genders.update_gender(gender, gender_params) do
      render(conn, :show, gender: gender)
    end
  end

  def delete(conn, %{"id" => id}) do
    gender = Genders.get_gender!(id)

    with {:ok, %Gender{}} <- Genders.delete_gender(gender) do
      send_resp(conn, :no_content, "")
    end
  end
end
