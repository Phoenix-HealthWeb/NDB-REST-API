defmodule NdbRestApiWeb.Api.GenderControllerTest do
  use NdbRestApiWeb.ConnCase

  import NdbRestApi.GendersFixtures

  alias NdbRestApi.Genders.Gender

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
    test "lists all genders", %{conn: conn} do
      conn = get(conn, ~p"/api/api/genders")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create gender" do
    test "renders gender when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/api/genders", gender: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/api/genders/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/api/genders", gender: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update gender" do
    setup [:create_gender]

    test "renders gender when data is valid", %{conn: conn, gender: %Gender{id: id} = gender} do
      conn = put(conn, ~p"/api/api/genders/#{gender}", gender: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/api/genders/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, gender: gender} do
      conn = put(conn, ~p"/api/api/genders/#{gender}", gender: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete gender" do
    setup [:create_gender]

    test "deletes chosen gender", %{conn: conn, gender: gender} do
      conn = delete(conn, ~p"/api/api/genders/#{gender}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/api/genders/#{gender}")
      end
    end
  end

  defp create_gender(_) do
    gender = gender_fixture()
    %{gender: gender}
  end
end
