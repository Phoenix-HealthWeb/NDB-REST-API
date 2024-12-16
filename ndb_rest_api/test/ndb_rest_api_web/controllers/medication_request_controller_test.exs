defmodule NdbRestApiWeb.MedicationRequestControllerTest do
  use NdbRestApiWeb.ConnCase

  import NdbRestApi.MedicationRequestsFixtures

  @create_attrs %{date_time: ~U[2024-12-15 14:56:00Z], expiration_date: ~D[2024-12-15], medication: "some medication", posology: "some posology"}
  @update_attrs %{date_time: ~U[2024-12-16 14:56:00Z], expiration_date: ~D[2024-12-16], medication: "some updated medication", posology: "some updated posology"}
  @invalid_attrs %{date_time: nil, expiration_date: nil, medication: nil, posology: nil}

  describe "index" do
    test "lists all medication_requests", %{conn: conn} do
      conn = get(conn, ~p"/medication_requests")
      assert html_response(conn, 200) =~ "Listing Medication requests"
    end
  end

  describe "new medication_request" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/medication_requests/new")
      assert html_response(conn, 200) =~ "New Medication request"
    end
  end

  describe "create medication_request" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/medication_requests", medication_request: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/medication_requests/#{id}"

      conn = get(conn, ~p"/medication_requests/#{id}")
      assert html_response(conn, 200) =~ "Medication request #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/medication_requests", medication_request: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Medication request"
    end
  end

  describe "edit medication_request" do
    setup [:create_medication_request]

    test "renders form for editing chosen medication_request", %{conn: conn, medication_request: medication_request} do
      conn = get(conn, ~p"/medication_requests/#{medication_request}/edit")
      assert html_response(conn, 200) =~ "Edit Medication request"
    end
  end

  describe "update medication_request" do
    setup [:create_medication_request]

    test "redirects when data is valid", %{conn: conn, medication_request: medication_request} do
      conn = put(conn, ~p"/medication_requests/#{medication_request}", medication_request: @update_attrs)
      assert redirected_to(conn) == ~p"/medication_requests/#{medication_request}"

      conn = get(conn, ~p"/medication_requests/#{medication_request}")
      assert html_response(conn, 200) =~ "some updated medication"
    end

    test "renders errors when data is invalid", %{conn: conn, medication_request: medication_request} do
      conn = put(conn, ~p"/medication_requests/#{medication_request}", medication_request: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Medication request"
    end
  end

  describe "delete medication_request" do
    setup [:create_medication_request]

    test "deletes chosen medication_request", %{conn: conn, medication_request: medication_request} do
      conn = delete(conn, ~p"/medication_requests/#{medication_request}")
      assert redirected_to(conn) == ~p"/medication_requests"

      assert_error_sent 404, fn ->
        get(conn, ~p"/medication_requests/#{medication_request}")
      end
    end
  end

  defp create_medication_request(_) do
    medication_request = medication_request_fixture()
    %{medication_request: medication_request}
  end
end
