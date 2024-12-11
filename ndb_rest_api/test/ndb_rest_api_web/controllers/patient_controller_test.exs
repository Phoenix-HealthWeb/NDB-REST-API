defmodule NdbRestApiWeb.PatientControllerTest do
  use NdbRestApiWeb.ConnCase

  import NdbRestApi.PatientsFixtures

  @create_attrs %{cf: "some cf", firstname: "some firstname", lastname: "some lastname", date_of_birth: ~D[2024-12-10]}
  @update_attrs %{cf: "some updated cf", firstname: "some updated firstname", lastname: "some updated lastname", date_of_birth: ~D[2024-12-11]}
  @invalid_attrs %{cf: nil, firstname: nil, lastname: nil, date_of_birth: nil}

  describe "index" do
    test "lists all patients", %{conn: conn} do
      conn = get(conn, ~p"/patients")
      assert html_response(conn, 200) =~ "Listing Patients"
    end
  end

  describe "new patient" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/patients/new")
      assert html_response(conn, 200) =~ "New Patient"
    end
  end

  describe "create patient" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/patients", patient: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/patients/#{id}"

      conn = get(conn, ~p"/patients/#{id}")
      assert html_response(conn, 200) =~ "Patient #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/patients", patient: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Patient"
    end
  end

  describe "edit patient" do
    setup [:create_patient]

    test "renders form for editing chosen patient", %{conn: conn, patient: patient} do
      conn = get(conn, ~p"/patients/#{patient}/edit")
      assert html_response(conn, 200) =~ "Edit Patient"
    end
  end

  describe "update patient" do
    setup [:create_patient]

    test "redirects when data is valid", %{conn: conn, patient: patient} do
      conn = put(conn, ~p"/patients/#{patient}", patient: @update_attrs)
      assert redirected_to(conn) == ~p"/patients/#{patient}"

      conn = get(conn, ~p"/patients/#{patient}")
      assert html_response(conn, 200) =~ "some updated cf"
    end

    test "renders errors when data is invalid", %{conn: conn, patient: patient} do
      conn = put(conn, ~p"/patients/#{patient}", patient: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Patient"
    end
  end

  describe "delete patient" do
    setup [:create_patient]

    test "deletes chosen patient", %{conn: conn, patient: patient} do
      conn = delete(conn, ~p"/patients/#{patient}")
      assert redirected_to(conn) == ~p"/patients"

      assert_error_sent 404, fn ->
        get(conn, ~p"/patients/#{patient}")
      end
    end
  end

  defp create_patient(_) do
    patient = patient_fixture()
    %{patient: patient}
  end
end
