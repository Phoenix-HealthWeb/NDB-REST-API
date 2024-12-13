defmodule NdbRestApiWeb.Api.PractitionerRoleControllerTest do
  use NdbRestApiWeb.ConnCase

  import NdbRestApi.PractitionerRolesFixtures

  alias NdbRestApi.PractitionerRoles.PractitionerRole

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all practitioner_roles", %{conn: conn} do
      conn = get(conn, ~p"/api/api/practitioner_roles")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create practitioner_role" do
    test "renders practitioner_role when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/api/practitioner_roles", practitioner_role: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/api/practitioner_roles/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/api/practitioner_roles", practitioner_role: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update practitioner_role" do
    setup [:create_practitioner_role]

    test "renders practitioner_role when data is valid", %{conn: conn, practitioner_role: %PractitionerRole{id: id} = practitioner_role} do
      conn = put(conn, ~p"/api/api/practitioner_roles/#{practitioner_role}", practitioner_role: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/api/practitioner_roles/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, practitioner_role: practitioner_role} do
      conn = put(conn, ~p"/api/api/practitioner_roles/#{practitioner_role}", practitioner_role: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete practitioner_role" do
    setup [:create_practitioner_role]

    test "deletes chosen practitioner_role", %{conn: conn, practitioner_role: practitioner_role} do
      conn = delete(conn, ~p"/api/api/practitioner_roles/#{practitioner_role}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/api/practitioner_roles/#{practitioner_role}")
      end
    end
  end

  defp create_practitioner_role(_) do
    practitioner_role = practitioner_role_fixture()
    %{practitioner_role: practitioner_role}
  end
end
