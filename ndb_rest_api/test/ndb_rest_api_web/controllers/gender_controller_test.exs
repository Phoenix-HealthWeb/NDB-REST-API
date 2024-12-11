defmodule NdbRestApiWeb.GenderControllerTest do
  use NdbRestApiWeb.ConnCase

  import NdbRestApi.GendersFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  describe "index" do
    test "lists all genders", %{conn: conn} do
      conn = get(conn, ~p"/genders")
      assert html_response(conn, 200) =~ "Listing Genders"
    end
  end

  describe "new gender" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/genders/new")
      assert html_response(conn, 200) =~ "New Gender"
    end
  end

  describe "create gender" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/genders", gender: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/genders/#{id}"

      conn = get(conn, ~p"/genders/#{id}")
      assert html_response(conn, 200) =~ "Gender #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/genders", gender: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Gender"
    end
  end

  describe "edit gender" do
    setup [:create_gender]

    test "renders form for editing chosen gender", %{conn: conn, gender: gender} do
      conn = get(conn, ~p"/genders/#{gender}/edit")
      assert html_response(conn, 200) =~ "Edit Gender"
    end
  end

  describe "update gender" do
    setup [:create_gender]

    test "redirects when data is valid", %{conn: conn, gender: gender} do
      conn = put(conn, ~p"/genders/#{gender}", gender: @update_attrs)
      assert redirected_to(conn) == ~p"/genders/#{gender}"

      conn = get(conn, ~p"/genders/#{gender}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, gender: gender} do
      conn = put(conn, ~p"/genders/#{gender}", gender: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Gender"
    end
  end

  describe "delete gender" do
    setup [:create_gender]

    test "deletes chosen gender", %{conn: conn, gender: gender} do
      conn = delete(conn, ~p"/genders/#{gender}")
      assert redirected_to(conn) == ~p"/genders"

      assert_error_sent 404, fn ->
        get(conn, ~p"/genders/#{gender}")
      end
    end
  end

  defp create_gender(_) do
    gender = gender_fixture()
    %{gender: gender}
  end
end
