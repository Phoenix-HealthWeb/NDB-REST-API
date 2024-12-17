defmodule NdbRestApiWeb.HospitalControllerTest do
  use NdbRestApiWeb.ConnCase

  import NdbRestApi.HospitalsFixtures

  @create_attrs %{name: "some name", address: "some address", api_key: "some api_key", region: "some region", notes: "some notes"}
  @update_attrs %{name: "some updated name", address: "some updated address", api_key: "some updated api_key", region: "some updated region", notes: "some updated notes"}
  @invalid_attrs %{name: nil, address: nil, api_key: nil, region: nil, notes: nil}

  describe "index" do
    test "lists all hospitals", %{conn: conn} do
      conn = get(conn, ~p"/hospitals")
      assert html_response(conn, 200) =~ "Listing Hospitals"
    end
  end

  describe "new hospital" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/hospitals/new")
      assert html_response(conn, 200) =~ "New Hospital"
    end
  end

  describe "create hospital" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/hospitals", hospital: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/hospitals/#{id}"

      conn = get(conn, ~p"/hospitals/#{id}")
      assert html_response(conn, 200) =~ "Hospital #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/hospitals", hospital: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Hospital"
    end
  end

  describe "edit hospital" do
    setup [:create_hospital]

    test "renders form for editing chosen hospital", %{conn: conn, hospital: hospital} do
      conn = get(conn, ~p"/hospitals/#{hospital}/edit")
      assert html_response(conn, 200) =~ "Edit Hospital"
    end
  end

  describe "update hospital" do
    setup [:create_hospital]

    test "redirects when data is valid", %{conn: conn, hospital: hospital} do
      conn = put(conn, ~p"/hospitals/#{hospital}", hospital: @update_attrs)
      assert redirected_to(conn) == ~p"/hospitals/#{hospital}"

      conn = get(conn, ~p"/hospitals/#{hospital}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, hospital: hospital} do
      conn = put(conn, ~p"/hospitals/#{hospital}", hospital: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Hospital"
    end
  end

  describe "delete hospital" do
    setup [:create_hospital]

    test "deletes chosen hospital", %{conn: conn, hospital: hospital} do
      conn = delete(conn, ~p"/hospitals/#{hospital}")
      assert redirected_to(conn) == ~p"/hospitals"

      assert_error_sent 404, fn ->
        get(conn, ~p"/hospitals/#{hospital}")
      end
    end
  end

  defp create_hospital(_) do
    hospital = hospital_fixture()
    %{hospital: hospital}
  end
end
