defmodule NdbRestApiWeb.Api.PractitionerController do
  use NdbRestApiWeb, :controller

  alias NdbRestApi.Practitioners
  alias NdbRestApi.Practitioners.Practitioner
  alias NdbRestApi.Repo

  action_fallback NdbRestApiWeb.FallbackController

  def index(conn, _params) do
    practitioners = Practitioners.list_practitioners() |> Repo.preload(:hospitals)
    render(conn, :index, practitioners: practitioners)
  end

  def create(conn, %{"practitioner" => practitioner_params}) do
    with {:ok, %Practitioner{} = practitioner} <-
           Practitioners.create_practitioner(practitioner_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/practitioners/#{practitioner}")
      |> render(:show, practitioner: practitioner)
    end
  end

  def show(conn, %{"id" => id}) do
    practitioner = Practitioners.get_practitioner!(id) |> Repo.preload(:hospitals)
    render(conn, :show, practitioner: practitioner)
  end

  def update(conn, %{"id" => id, "practitioner" => practitioner_params}) do
    practitioner = Practitioners.get_practitioner!(id) |> Repo.preload(:hospitals)

    with {:ok, %Practitioner{} = practitioner} <-
           Practitioners.update_practitioner(practitioner, practitioner_params) do
      render(conn, :show, practitioner: practitioner)
    end
  end

  def delete(conn, %{"id" => id}) do
    practitioner = Practitioners.get_practitioner!(id) |> Repo.preload(:hospitals)

    with {:ok, %Practitioner{}} <- Practitioners.delete_practitioner(practitioner) do
      send_resp(conn, :no_content, "")
    end
  end

  @doc """
  Searches a specific practitioner by email.
  """
  def search(conn, %{"email" => email}) do
    practitioner = Practitioners.get_practitioner_by_email(email)
    render(conn, :show, practitioner: practitioner)
  end
end
