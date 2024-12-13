defmodule NdbRestApiWeb.Api.HospitalController do
  use NdbRestApiWeb, :controller

  alias NdbRestApi.Hospitals
  alias NdbRestApi.Hospitals.Hospital

  action_fallback NdbRestApiWeb.FallbackController

  def index(conn, _params) do
    hospitals = Hospitals.list_hospitals()
    render(conn, :index, hospitals: hospitals)
  end

  def create(conn, %{"hospital" => hospital_params}) do
    with {:ok, %Hospital{} = hospital} <- Hospitals.create_hospital(hospital_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/api/hospitals/#{hospital}")
      |> render(:show, hospital: hospital)
    end
  end

  def show(conn, %{"id" => id}) do
    hospital = Hospitals.get_hospital!(id)
    render(conn, :show, hospital: hospital)
  end

  def update(conn, %{"id" => id, "hospital" => hospital_params}) do
    hospital = Hospitals.get_hospital!(id)

    with {:ok, %Hospital{} = hospital} <- Hospitals.update_hospital(hospital, hospital_params) do
      render(conn, :show, hospital: hospital)
    end
  end

  def delete(conn, %{"id" => id}) do
    hospital = Hospitals.get_hospital!(id)

    with {:ok, %Hospital{}} <- Hospitals.delete_hospital(hospital) do
      send_resp(conn, :no_content, "")
    end
  end
end
