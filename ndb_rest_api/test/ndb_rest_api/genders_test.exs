defmodule NdbRestApi.GendersTest do
  use NdbRestApi.DataCase

  alias NdbRestApi.Genders

  describe "genders" do
    alias NdbRestApi.Genders.Gender

    import NdbRestApi.GendersFixtures

    @invalid_attrs %{name: nil}

    test "list_genders/0 returns all genders" do
      gender = gender_fixture()
      assert Genders.list_genders() == [gender]
    end

    test "get_gender!/1 returns the gender with given id" do
      gender = gender_fixture()
      assert Genders.get_gender!(gender.id) == gender
    end

    test "create_gender/1 with valid data creates a gender" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Gender{} = gender} = Genders.create_gender(valid_attrs)
      assert gender.name == "some name"
    end

    test "create_gender/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Genders.create_gender(@invalid_attrs)
    end

    test "update_gender/2 with valid data updates the gender" do
      gender = gender_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Gender{} = gender} = Genders.update_gender(gender, update_attrs)
      assert gender.name == "some updated name"
    end

    test "update_gender/2 with invalid data returns error changeset" do
      gender = gender_fixture()
      assert {:error, %Ecto.Changeset{}} = Genders.update_gender(gender, @invalid_attrs)
      assert gender == Genders.get_gender!(gender.id)
    end

    test "delete_gender/1 deletes the gender" do
      gender = gender_fixture()
      assert {:ok, %Gender{}} = Genders.delete_gender(gender)
      assert_raise Ecto.NoResultsError, fn -> Genders.get_gender!(gender.id) end
    end

    test "change_gender/1 returns a gender changeset" do
      gender = gender_fixture()
      assert %Ecto.Changeset{} = Genders.change_gender(gender)
    end
  end
end
