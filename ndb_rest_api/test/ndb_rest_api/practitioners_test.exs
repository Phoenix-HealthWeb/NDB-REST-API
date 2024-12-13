defmodule NdbRestApi.PractitionersTest do
  use NdbRestApi.DataCase

  alias NdbRestApi.Practitioners

  describe "practitioners" do
    alias NdbRestApi.Practitioners.Practitioner

    import NdbRestApi.PractitionersFixtures

    @invalid_attrs %{email: nil, forename: nil, surname: nil, date_of_birth: nil, qualification: nil}

    test "list_practitioners/0 returns all practitioners" do
      practitioner = practitioner_fixture()
      assert Practitioners.list_practitioners() == [practitioner]
    end

    test "get_practitioner!/1 returns the practitioner with given id" do
      practitioner = practitioner_fixture()
      assert Practitioners.get_practitioner!(practitioner.id) == practitioner
    end

    test "create_practitioner/1 with valid data creates a practitioner" do
      valid_attrs = %{email: "some email", forename: "some forename", surname: "some surname", date_of_birth: ~D[2024-12-12], qualification: "some qualification"}

      assert {:ok, %Practitioner{} = practitioner} = Practitioners.create_practitioner(valid_attrs)
      assert practitioner.email == "some email"
      assert practitioner.forename == "some forename"
      assert practitioner.surname == "some surname"
      assert practitioner.date_of_birth == ~D[2024-12-12]
      assert practitioner.qualification == "some qualification"
    end

    test "create_practitioner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Practitioners.create_practitioner(@invalid_attrs)
    end

    test "update_practitioner/2 with valid data updates the practitioner" do
      practitioner = practitioner_fixture()
      update_attrs = %{email: "some updated email", forename: "some updated forename", surname: "some updated surname", date_of_birth: ~D[2024-12-13], qualification: "some updated qualification"}

      assert {:ok, %Practitioner{} = practitioner} = Practitioners.update_practitioner(practitioner, update_attrs)
      assert practitioner.email == "some updated email"
      assert practitioner.forename == "some updated forename"
      assert practitioner.surname == "some updated surname"
      assert practitioner.date_of_birth == ~D[2024-12-13]
      assert practitioner.qualification == "some updated qualification"
    end

    test "update_practitioner/2 with invalid data returns error changeset" do
      practitioner = practitioner_fixture()
      assert {:error, %Ecto.Changeset{}} = Practitioners.update_practitioner(practitioner, @invalid_attrs)
      assert practitioner == Practitioners.get_practitioner!(practitioner.id)
    end

    test "delete_practitioner/1 deletes the practitioner" do
      practitioner = practitioner_fixture()
      assert {:ok, %Practitioner{}} = Practitioners.delete_practitioner(practitioner)
      assert_raise Ecto.NoResultsError, fn -> Practitioners.get_practitioner!(practitioner.id) end
    end

    test "change_practitioner/1 returns a practitioner changeset" do
      practitioner = practitioner_fixture()
      assert %Ecto.Changeset{} = Practitioners.change_practitioner(practitioner)
    end
  end
end
