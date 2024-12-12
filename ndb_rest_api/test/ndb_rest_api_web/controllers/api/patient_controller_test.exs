defmodule NdbRestApiWeb.Api.PatientControllerTest do
  use NdbRestApiWeb.ConnCase

  import NdbRestApi.PatientsFixtures

  alias NdbRestApi.Patients.Patient

  @create_attrs %{
    firstname: "some firstname",
    lastname: "some lastname",
    date_of_birth: ~D[2024-12-11]
  }
  @update_attrs %{
    firstname: "some updated firstname",
    lastname: "some updated lastname",
    date_of_birth: ~D[2024-12-12]
  }
  @invalid_attrs %{firstname: nil, lastname: nil, date_of_birth: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all patients", %{conn: conn} do
      conn = get(conn, ~p"/api/api/patients")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create patient" do
    test "renders patient when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/api/patients", patient: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/api/patients/#{id}")

      assert %{
               "id" => ^id,
               "date_of_birth" => "2024-12-11",
               "firstname" => "some firstname",
               "lastname" => "some lastname"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/api/patients", patient: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update patient" do
    setup [:create_patient]

    test "renders patient when data is valid", %{conn: conn, patient: %Patient{id: id} = patient} do
      conn = put(conn, ~p"/api/api/patients/#{patient}", patient: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/api/patients/#{id}")

      assert %{
               "id" => ^id,
               "date_of_birth" => "2024-12-12",
               "firstname" => "some updated firstname",
               "lastname" => "some updated lastname"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, patient: patient} do
      conn = put(conn, ~p"/api/api/patients/#{patient}", patient: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete patient" do
    setup [:create_patient]

    test "deletes chosen patient", %{conn: conn, patient: patient} do
      conn = delete(conn, ~p"/api/api/patients/#{patient}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/api/patients/#{patient}")
      end
    end
  end

  defp create_patient(_) do
    patient = patient_fixture()
    %{patient: patient}
  end
end
