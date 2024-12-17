defmodule NdbRestApiWeb.PractitionerControllerTest do
  use NdbRestApiWeb.ConnCase

  import NdbRestApi.PractitionersFixtures

  @create_attrs %{email: "some email", forename: "some forename", surname: "some surname", date_of_birth: ~D[2024-12-16], qualification: "some qualification"}
  @update_attrs %{email: "some updated email", forename: "some updated forename", surname: "some updated surname", date_of_birth: ~D[2024-12-17], qualification: "some updated qualification"}
  @invalid_attrs %{email: nil, forename: nil, surname: nil, date_of_birth: nil, qualification: nil}

  describe "index" do
    test "lists all practitioners", %{conn: conn} do
      conn = get(conn, ~p"/practitioners")
      assert html_response(conn, 200) =~ "Listing Practitioners"
    end
  end

  describe "new practitioner" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/practitioners/new")
      assert html_response(conn, 200) =~ "New Practitioner"
    end
  end

  describe "create practitioner" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/practitioners", practitioner: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/practitioners/#{id}"

      conn = get(conn, ~p"/practitioners/#{id}")
      assert html_response(conn, 200) =~ "Practitioner #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/practitioners", practitioner: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Practitioner"
    end
  end

  describe "edit practitioner" do
    setup [:create_practitioner]

    test "renders form for editing chosen practitioner", %{conn: conn, practitioner: practitioner} do
      conn = get(conn, ~p"/practitioners/#{practitioner}/edit")
      assert html_response(conn, 200) =~ "Edit Practitioner"
    end
  end

  describe "update practitioner" do
    setup [:create_practitioner]

    test "redirects when data is valid", %{conn: conn, practitioner: practitioner} do
      conn = put(conn, ~p"/practitioners/#{practitioner}", practitioner: @update_attrs)
      assert redirected_to(conn) == ~p"/practitioners/#{practitioner}"

      conn = get(conn, ~p"/practitioners/#{practitioner}")
      assert html_response(conn, 200) =~ "some updated email"
    end

    test "renders errors when data is invalid", %{conn: conn, practitioner: practitioner} do
      conn = put(conn, ~p"/practitioners/#{practitioner}", practitioner: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Practitioner"
    end
  end

  describe "delete practitioner" do
    setup [:create_practitioner]

    test "deletes chosen practitioner", %{conn: conn, practitioner: practitioner} do
      conn = delete(conn, ~p"/practitioners/#{practitioner}")
      assert redirected_to(conn) == ~p"/practitioners"

      assert_error_sent 404, fn ->
        get(conn, ~p"/practitioners/#{practitioner}")
      end
    end
  end

  defp create_practitioner(_) do
    practitioner = practitioner_fixture()
    %{practitioner: practitioner}
  end
end
