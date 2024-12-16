defmodule NdbRestApiWeb.Api.ObservationControllerTest do
  use NdbRestApiWeb.ConnCase

  import NdbRestApi.ObservationsFixtures

  alias NdbRestApi.Observations.Observation

  @create_attrs %{
    result: "some result",
    ward: "some ward",
    date_time: ~U[2024-12-15 16:58:00Z]
  }
  @update_attrs %{
    result: "some updated result",
    ward: "some updated ward",
    date_time: ~U[2024-12-16 16:58:00Z]
  }
  @invalid_attrs %{result: nil, ward: nil, date_time: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all observations", %{conn: conn} do
      conn = get(conn, ~p"/api/api/observations")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create observation" do
    test "renders observation when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/api/observations", observation: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/api/observations/#{id}")

      assert %{
               "id" => ^id,
               "date_time" => "2024-12-15T16:58:00Z",
               "result" => "some result",
               "ward" => "some ward"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/api/observations", observation: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update observation" do
    setup [:create_observation]

    test "renders observation when data is valid", %{conn: conn, observation: %Observation{id: id} = observation} do
      conn = put(conn, ~p"/api/api/observations/#{observation}", observation: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/api/observations/#{id}")

      assert %{
               "id" => ^id,
               "date_time" => "2024-12-16T16:58:00Z",
               "result" => "some updated result",
               "ward" => "some updated ward"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, observation: observation} do
      conn = put(conn, ~p"/api/api/observations/#{observation}", observation: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete observation" do
    setup [:create_observation]

    test "deletes chosen observation", %{conn: conn, observation: observation} do
      conn = delete(conn, ~p"/api/api/observations/#{observation}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/api/observations/#{observation}")
      end
    end
  end

  defp create_observation(_) do
    observation = observation_fixture()
    %{observation: observation}
  end
end
