defmodule NdbRestApiWeb.ConditionControllerTest do
  use NdbRestApiWeb.ConnCase

  import NdbRestApi.ConditionsFixtures

  @create_attrs %{comment: "some comment", date_time: ~U[2024-12-15 16:33:00Z]}
  @update_attrs %{comment: "some updated comment", date_time: ~U[2024-12-16 16:33:00Z]}
  @invalid_attrs %{comment: nil, date_time: nil}

  describe "index" do
    test "lists all conditions", %{conn: conn} do
      conn = get(conn, ~p"/conditions")
      assert html_response(conn, 200) =~ "Listing Conditions"
    end
  end

  describe "new condition" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/conditions/new")
      assert html_response(conn, 200) =~ "New Condition"
    end
  end

  describe "create condition" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/conditions", condition: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/conditions/#{id}"

      conn = get(conn, ~p"/conditions/#{id}")
      assert html_response(conn, 200) =~ "Condition #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/conditions", condition: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Condition"
    end
  end

  describe "edit condition" do
    setup [:create_condition]

    test "renders form for editing chosen condition", %{conn: conn, condition: condition} do
      conn = get(conn, ~p"/conditions/#{condition}/edit")
      assert html_response(conn, 200) =~ "Edit Condition"
    end
  end

  describe "update condition" do
    setup [:create_condition]

    test "redirects when data is valid", %{conn: conn, condition: condition} do
      conn = put(conn, ~p"/conditions/#{condition}", condition: @update_attrs)
      assert redirected_to(conn) == ~p"/conditions/#{condition}"

      conn = get(conn, ~p"/conditions/#{condition}")
      assert html_response(conn, 200) =~ "some updated comment"
    end

    test "renders errors when data is invalid", %{conn: conn, condition: condition} do
      conn = put(conn, ~p"/conditions/#{condition}", condition: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Condition"
    end
  end

  describe "delete condition" do
    setup [:create_condition]

    test "deletes chosen condition", %{conn: conn, condition: condition} do
      conn = delete(conn, ~p"/conditions/#{condition}")
      assert redirected_to(conn) == ~p"/conditions"

      assert_error_sent 404, fn ->
        get(conn, ~p"/conditions/#{condition}")
      end
    end
  end

  defp create_condition(_) do
    condition = condition_fixture()
    %{condition: condition}
  end
end
