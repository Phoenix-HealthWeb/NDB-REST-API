defmodule NdbRestApiWeb.Api.PractitionerControllerTest do
  use NdbRestApiWeb.ConnCase

  import NdbRestApi.PractitionersFixtures

  alias NdbRestApi.Practitioners.Practitioner

  @create_attrs %{
    email: "some email",
    forename: "some forename",
    surname: "some surname",
    date_of_birth: ~D[2024-12-12],
    qualification: "some qualification"
  }
  @update_attrs %{
    email: "some updated email",
    forename: "some updated forename",
    surname: "some updated surname",
    date_of_birth: ~D[2024-12-13],
    qualification: "some updated qualification"
  }
  @invalid_attrs %{email: nil, forename: nil, surname: nil, date_of_birth: nil, qualification: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all practitioners", %{conn: conn} do
      conn = get(conn, ~p"/api/api/practitioners")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create practitioner" do
    test "renders practitioner when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/api/practitioners", practitioner: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/api/practitioners/#{id}")

      assert %{
               "id" => ^id,
               "date_of_birth" => "2024-12-12",
               "email" => "some email",
               "forename" => "some forename",
               "qualification" => "some qualification",
               "surname" => "some surname"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/api/practitioners", practitioner: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update practitioner" do
    setup [:create_practitioner]

    test "renders practitioner when data is valid", %{conn: conn, practitioner: %Practitioner{id: id} = practitioner} do
      conn = put(conn, ~p"/api/api/practitioners/#{practitioner}", practitioner: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/api/practitioners/#{id}")

      assert %{
               "id" => ^id,
               "date_of_birth" => "2024-12-13",
               "email" => "some updated email",
               "forename" => "some updated forename",
               "qualification" => "some updated qualification",
               "surname" => "some updated surname"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, practitioner: practitioner} do
      conn = put(conn, ~p"/api/api/practitioners/#{practitioner}", practitioner: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete practitioner" do
    setup [:create_practitioner]

    test "deletes chosen practitioner", %{conn: conn, practitioner: practitioner} do
      conn = delete(conn, ~p"/api/api/practitioners/#{practitioner}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/api/practitioners/#{practitioner}")
      end
    end
  end

  defp create_practitioner(_) do
    practitioner = practitioner_fixture()
    %{practitioner: practitioner}
  end
end
