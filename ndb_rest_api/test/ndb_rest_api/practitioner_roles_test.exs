defmodule NdbRestApi.PractitionerRolesTest do
  use NdbRestApi.DataCase

  alias NdbRestApi.PractitionerRoles

  describe "practitioner_roles" do
    alias NdbRestApi.PractitionerRoles.PractitionerRole

    import NdbRestApi.PractitionerRolesFixtures

    @invalid_attrs %{name: nil}

    test "list_practitioner_roles/0 returns all practitioner_roles" do
      practitioner_role = practitioner_role_fixture()
      assert PractitionerRoles.list_practitioner_roles() == [practitioner_role]
    end

    test "get_practitioner_role!/1 returns the practitioner_role with given id" do
      practitioner_role = practitioner_role_fixture()
      assert PractitionerRoles.get_practitioner_role!(practitioner_role.id) == practitioner_role
    end

    test "create_practitioner_role/1 with valid data creates a practitioner_role" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %PractitionerRole{} = practitioner_role} = PractitionerRoles.create_practitioner_role(valid_attrs)
      assert practitioner_role.name == "some name"
    end

    test "create_practitioner_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PractitionerRoles.create_practitioner_role(@invalid_attrs)
    end

    test "update_practitioner_role/2 with valid data updates the practitioner_role" do
      practitioner_role = practitioner_role_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %PractitionerRole{} = practitioner_role} = PractitionerRoles.update_practitioner_role(practitioner_role, update_attrs)
      assert practitioner_role.name == "some updated name"
    end

    test "update_practitioner_role/2 with invalid data returns error changeset" do
      practitioner_role = practitioner_role_fixture()
      assert {:error, %Ecto.Changeset{}} = PractitionerRoles.update_practitioner_role(practitioner_role, @invalid_attrs)
      assert practitioner_role == PractitionerRoles.get_practitioner_role!(practitioner_role.id)
    end

    test "delete_practitioner_role/1 deletes the practitioner_role" do
      practitioner_role = practitioner_role_fixture()
      assert {:ok, %PractitionerRole{}} = PractitionerRoles.delete_practitioner_role(practitioner_role)
      assert_raise Ecto.NoResultsError, fn -> PractitionerRoles.get_practitioner_role!(practitioner_role.id) end
    end

    test "change_practitioner_role/1 returns a practitioner_role changeset" do
      practitioner_role = practitioner_role_fixture()
      assert %Ecto.Changeset{} = PractitionerRoles.change_practitioner_role(practitioner_role)
    end
  end
end
