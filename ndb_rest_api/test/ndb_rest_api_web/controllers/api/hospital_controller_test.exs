defmodule NdbRestApiWeb.Api.HospitalControllerTest do
  use NdbRestApiWeb.ConnCase

  import NdbRestApi.HospitalsFixtures

  alias NdbRestApi.Hospitals.Hospital

  @create_attrs %{
    name: "some name",
    address: "some address",
    api_key: "some api_key",
    region: "some region",
    notes: "some notes"
  }
  @update_attrs %{
    name: "some updated name",
    address: "some updated address",
    api_key: "some updated api_key",
    region: "some updated region",
    notes: "some updated notes"
  }
  @invalid_attrs %{name: nil, address: nil, api_key: nil, region: nil, notes: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all hospitals", %{conn: conn} do
      conn = get(conn, ~p"/api/api/hospitals")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create hospital" do
    test "renders hospital when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/api/hospitals", hospital: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/api/hospitals/#{id}")

      assert %{
               "id" => ^id,
               "address" => "some address",
               "api_key" => "some api_key",
               "name" => "some name",
               "notes" => "some notes",
               "region" => "some region"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/api/hospitals", hospital: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update hospital" do
    setup [:create_hospital]

    test "renders hospital when data is valid", %{conn: conn, hospital: %Hospital{id: id} = hospital} do
      conn = put(conn, ~p"/api/api/hospitals/#{hospital}", hospital: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/api/hospitals/#{id}")

      assert %{
               "id" => ^id,
               "address" => "some updated address",
               "api_key" => "some updated api_key",
               "name" => "some updated name",
               "notes" => "some updated notes",
               "region" => "some updated region"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, hospital: hospital} do
      conn = put(conn, ~p"/api/api/hospitals/#{hospital}", hospital: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete hospital" do
    setup [:create_hospital]

    test "deletes chosen hospital", %{conn: conn, hospital: hospital} do
      conn = delete(conn, ~p"/api/api/hospitals/#{hospital}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/api/hospitals/#{hospital}")
      end
    end
  end

  defp create_hospital(_) do
    hospital = hospital_fixture()
    %{hospital: hospital}
  end
end
