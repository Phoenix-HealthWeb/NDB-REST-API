defmodule NdbRestApiWeb.ObservationControllerTest do
  use NdbRestApiWeb.ConnCase

  import NdbRestApi.ObservationsFixtures

  @create_attrs %{result: "some result", ward: "some ward", date_time: ~U[2024-12-15 16:57:00Z]}
  @update_attrs %{result: "some updated result", ward: "some updated ward", date_time: ~U[2024-12-16 16:57:00Z]}
  @invalid_attrs %{result: nil, ward: nil, date_time: nil}

  describe "index" do
    test "lists all observations", %{conn: conn} do
      conn = get(conn, ~p"/observations")
      assert html_response(conn, 200) =~ "Listing Observations"
    end
  end

  describe "new observation" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/observations/new")
      assert html_response(conn, 200) =~ "New Observation"
    end
  end

  describe "create observation" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/observations", observation: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/observations/#{id}"

      conn = get(conn, ~p"/observations/#{id}")
      assert html_response(conn, 200) =~ "Observation #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/observations", observation: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Observation"
    end
  end

  describe "edit observation" do
    setup [:create_observation]

    test "renders form for editing chosen observation", %{conn: conn, observation: observation} do
      conn = get(conn, ~p"/observations/#{observation}/edit")
      assert html_response(conn, 200) =~ "Edit Observation"
    end
  end

  describe "update observation" do
    setup [:create_observation]

    test "redirects when data is valid", %{conn: conn, observation: observation} do
      conn = put(conn, ~p"/observations/#{observation}", observation: @update_attrs)
      assert redirected_to(conn) == ~p"/observations/#{observation}"

      conn = get(conn, ~p"/observations/#{observation}")
      assert html_response(conn, 200) =~ "some updated result"
    end

    test "renders errors when data is invalid", %{conn: conn, observation: observation} do
      conn = put(conn, ~p"/observations/#{observation}", observation: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Observation"
    end
  end

  describe "delete observation" do
    setup [:create_observation]

    test "deletes chosen observation", %{conn: conn, observation: observation} do
      conn = delete(conn, ~p"/observations/#{observation}")
      assert redirected_to(conn) == ~p"/observations"

      assert_error_sent 404, fn ->
        get(conn, ~p"/observations/#{observation}")
      end
    end
  end

  defp create_observation(_) do
    observation = observation_fixture()
    %{observation: observation}
  end
end
