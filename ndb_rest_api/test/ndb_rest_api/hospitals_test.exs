defmodule NdbRestApi.HospitalsTest do
  use NdbRestApi.DataCase

  alias NdbRestApi.Hospitals

  describe "hospitals" do
    alias NdbRestApi.Hospitals.Hospital

    import NdbRestApi.HospitalsFixtures

    @invalid_attrs %{name: nil, address: nil, api_key: nil, region: nil, notes: nil}

    test "list_hospitals/0 returns all hospitals" do
      hospital = hospital_fixture()
      assert Hospitals.list_hospitals() == [hospital]
    end

    test "get_hospital!/1 returns the hospital with given id" do
      hospital = hospital_fixture()
      assert Hospitals.get_hospital!(hospital.id) == hospital
    end

    test "create_hospital/1 with valid data creates a hospital" do
      valid_attrs = %{name: "some name", address: "some address", api_key: "some api_key", region: "some region", notes: "some notes"}

      assert {:ok, %Hospital{} = hospital} = Hospitals.create_hospital(valid_attrs)
      assert hospital.name == "some name"
      assert hospital.address == "some address"
      assert hospital.api_key == "some api_key"
      assert hospital.region == "some region"
      assert hospital.notes == "some notes"
    end

    test "create_hospital/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hospitals.create_hospital(@invalid_attrs)
    end

    test "update_hospital/2 with valid data updates the hospital" do
      hospital = hospital_fixture()
      update_attrs = %{name: "some updated name", address: "some updated address", api_key: "some updated api_key", region: "some updated region", notes: "some updated notes"}

      assert {:ok, %Hospital{} = hospital} = Hospitals.update_hospital(hospital, update_attrs)
      assert hospital.name == "some updated name"
      assert hospital.address == "some updated address"
      assert hospital.api_key == "some updated api_key"
      assert hospital.region == "some updated region"
      assert hospital.notes == "some updated notes"
    end

    test "update_hospital/2 with invalid data returns error changeset" do
      hospital = hospital_fixture()
      assert {:error, %Ecto.Changeset{}} = Hospitals.update_hospital(hospital, @invalid_attrs)
      assert hospital == Hospitals.get_hospital!(hospital.id)
    end

    test "delete_hospital/1 deletes the hospital" do
      hospital = hospital_fixture()
      assert {:ok, %Hospital{}} = Hospitals.delete_hospital(hospital)
      assert_raise Ecto.NoResultsError, fn -> Hospitals.get_hospital!(hospital.id) end
    end

    test "change_hospital/1 returns a hospital changeset" do
      hospital = hospital_fixture()
      assert %Ecto.Changeset{} = Hospitals.change_hospital(hospital)
    end
  end
end
