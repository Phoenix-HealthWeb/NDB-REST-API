defmodule NdbRestApiWeb.PractitionerRoleControllerTest do
  use NdbRestApiWeb.ConnCase

  import NdbRestApi.PractitionerRolesFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  describe "index" do
    test "lists all practitioner_roles", %{conn: conn} do
      conn = get(conn, ~p"/practitioner_roles")
      assert html_response(conn, 200) =~ "Listing Practitioner roles"
    end
  end

  describe "new practitioner_role" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/practitioner_roles/new")
      assert html_response(conn, 200) =~ "New Practitioner role"
    end
  end

  describe "create practitioner_role" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/practitioner_roles", practitioner_role: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/practitioner_roles/#{id}"

      conn = get(conn, ~p"/practitioner_roles/#{id}")
      assert html_response(conn, 200) =~ "Practitioner role #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/practitioner_roles", practitioner_role: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Practitioner role"
    end
  end

  describe "edit practitioner_role" do
    setup [:create_practitioner_role]

    test "renders form for editing chosen practitioner_role", %{conn: conn, practitioner_role: practitioner_role} do
      conn = get(conn, ~p"/practitioner_roles/#{practitioner_role}/edit")
      assert html_response(conn, 200) =~ "Edit Practitioner role"
    end
  end

  describe "update practitioner_role" do
    setup [:create_practitioner_role]

    test "redirects when data is valid", %{conn: conn, practitioner_role: practitioner_role} do
      conn = put(conn, ~p"/practitioner_roles/#{practitioner_role}", practitioner_role: @update_attrs)
      assert redirected_to(conn) == ~p"/practitioner_roles/#{practitioner_role}"

      conn = get(conn, ~p"/practitioner_roles/#{practitioner_role}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, practitioner_role: practitioner_role} do
      conn = put(conn, ~p"/practitioner_roles/#{practitioner_role}", practitioner_role: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Practitioner role"
    end
  end

  describe "delete practitioner_role" do
    setup [:create_practitioner_role]

    test "deletes chosen practitioner_role", %{conn: conn, practitioner_role: practitioner_role} do
      conn = delete(conn, ~p"/practitioner_roles/#{practitioner_role}")
      assert redirected_to(conn) == ~p"/practitioner_roles"

      assert_error_sent 404, fn ->
        get(conn, ~p"/practitioner_roles/#{practitioner_role}")
      end
    end
  end

  defp create_practitioner_role(_) do
    practitioner_role = practitioner_role_fixture()
    %{practitioner_role: practitioner_role}
  end
end
