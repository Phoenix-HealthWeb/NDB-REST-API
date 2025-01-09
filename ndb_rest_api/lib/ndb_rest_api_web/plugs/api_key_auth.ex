defmodule NdbRestApiWeb.ApiKeyAuth do
  import Plug.Conn
  alias NdbRestApi.Hospitals
  import Phoenix.Controller

  def init(default), do: default

  def call(conn, _opts) do
    api_key = get_req_header(conn, "x-api-key") |> List.first()
    hospital_id = get_req_header(conn, "x-hospital-id") |> List.first()

    if api_key && hospital_id do
      case Hospitals.get_hospital(hospital_id) do
        nil ->
          conn
          |> put_resp_content_type("application/json")
          |> json(%{error: "Invalid API key or hospital ID"})
          |> halt()

        hospital ->
          if hospital.api_key do
            case Hospitals.check_api_key(hospital, api_key) do
              {:ok, _hospital} ->
                conn

              {:error, :unauthorized} ->
                conn
                |> put_resp_content_type("application/json")
                |> json(%{error: "Invalid API key or hospital ID"})
                |> halt()
            end
          else
            conn
            |> put_resp_content_type("application/json")
            |> json(%{error: "Invalid API key or hospital ID"})
            |> halt()
          end
      end
    else
      conn
      |> put_resp_content_type("application/json")
      |> json(%{error: "API key or hospital ID missing from headers"})
      |> halt()
    end
  end
end
