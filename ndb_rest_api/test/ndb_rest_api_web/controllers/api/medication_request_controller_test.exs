defmodule NdbRestApiWeb.Api.MedicationRequestControllerTest do
  use NdbRestApiWeb.ConnCase

  import NdbRestApi.MedicationRequestsFixtures

  alias NdbRestApi.MedicationRequests.MedicationRequest

  @create_attrs %{
    date_time: ~U[2024-12-15 14:58:00Z],
    expiration_date: ~D[2024-12-15],
    medication: "some medication",
    posology: "some posology"
  }
  @update_attrs %{
    date_time: ~U[2024-12-16 14:58:00Z],
    expiration_date: ~D[2024-12-16],
    medication: "some updated medication",
    posology: "some updated posology"
  }
  @invalid_attrs %{date_time: nil, expiration_date: nil, medication: nil, posology: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all medication_requests", %{conn: conn} do
      conn = get(conn, ~p"/api/api/medication_requests")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create medication_request" do
    test "renders medication_request when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/api/medication_requests", medication_request: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/api/medication_requests/#{id}")

      assert %{
               "id" => ^id,
               "date_time" => "2024-12-15T14:58:00Z",
               "expiration_date" => "2024-12-15",
               "medication" => "some medication",
               "posology" => "some posology"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/api/medication_requests", medication_request: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update medication_request" do
    setup [:create_medication_request]

    test "renders medication_request when data is valid", %{conn: conn, medication_request: %MedicationRequest{id: id} = medication_request} do
      conn = put(conn, ~p"/api/api/medication_requests/#{medication_request}", medication_request: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/api/medication_requests/#{id}")

      assert %{
               "id" => ^id,
               "date_time" => "2024-12-16T14:58:00Z",
               "expiration_date" => "2024-12-16",
               "medication" => "some updated medication",
               "posology" => "some updated posology"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, medication_request: medication_request} do
      conn = put(conn, ~p"/api/api/medication_requests/#{medication_request}", medication_request: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete medication_request" do
    setup [:create_medication_request]

    test "deletes chosen medication_request", %{conn: conn, medication_request: medication_request} do
      conn = delete(conn, ~p"/api/api/medication_requests/#{medication_request}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/api/medication_requests/#{medication_request}")
      end
    end
  end

  defp create_medication_request(_) do
    medication_request = medication_request_fixture()
    %{medication_request: medication_request}
  end
end
