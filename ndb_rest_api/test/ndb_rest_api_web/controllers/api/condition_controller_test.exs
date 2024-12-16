defmodule NdbRestApiWeb.Api.ConditionControllerTest do
  use NdbRestApiWeb.ConnCase

  import NdbRestApi.ConditionsFixtures

  alias NdbRestApi.Conditions.Condition

  @create_attrs %{
    comment: "some comment",
    date_time: ~U[2024-12-15 16:34:00Z]
  }
  @update_attrs %{
    comment: "some updated comment",
    date_time: ~U[2024-12-16 16:34:00Z]
  }
  @invalid_attrs %{comment: nil, date_time: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all conditions", %{conn: conn} do
      conn = get(conn, ~p"/api/api/conditions")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create condition" do
    test "renders condition when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/api/conditions", condition: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/api/conditions/#{id}")

      assert %{
               "id" => ^id,
               "comment" => "some comment",
               "date_time" => "2024-12-15T16:34:00Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/api/conditions", condition: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update condition" do
    setup [:create_condition]

    test "renders condition when data is valid", %{conn: conn, condition: %Condition{id: id} = condition} do
      conn = put(conn, ~p"/api/api/conditions/#{condition}", condition: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/api/conditions/#{id}")

      assert %{
               "id" => ^id,
               "comment" => "some updated comment",
               "date_time" => "2024-12-16T16:34:00Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, condition: condition} do
      conn = put(conn, ~p"/api/api/conditions/#{condition}", condition: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete condition" do
    setup [:create_condition]

    test "deletes chosen condition", %{conn: conn, condition: condition} do
      conn = delete(conn, ~p"/api/api/conditions/#{condition}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/api/conditions/#{condition}")
      end
    end
  end

  defp create_condition(_) do
    condition = condition_fixture()
    %{condition: condition}
  end
end
