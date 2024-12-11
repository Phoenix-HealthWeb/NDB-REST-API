defmodule NdbRestApi.PatientsTest do
  use NdbRestApi.DataCase

  alias NdbRestApi.Patients

  describe "patients" do
    alias NdbRestApi.Patients.Patient

    import NdbRestApi.PatientsFixtures

    @invalid_attrs %{cf: nil, firstname: nil, lastname: nil, date_of_birth: nil}

    test "list_patients/0 returns all patients" do
      patient = patient_fixture()
      assert Patients.list_patients() == [patient]
    end

    test "get_patient!/1 returns the patient with given id" do
      patient = patient_fixture()
      assert Patients.get_patient!(patient.id) == patient
    end

    test "create_patient/1 with valid data creates a patient" do
      valid_attrs = %{cf: "some cf", firstname: "some firstname", lastname: "some lastname", date_of_birth: ~D[2024-12-10]}

      assert {:ok, %Patient{} = patient} = Patients.create_patient(valid_attrs)
      assert patient.cf == "some cf"
      assert patient.firstname == "some firstname"
      assert patient.lastname == "some lastname"
      assert patient.date_of_birth == ~D[2024-12-10]
    end

    test "create_patient/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Patients.create_patient(@invalid_attrs)
    end

    test "update_patient/2 with valid data updates the patient" do
      patient = patient_fixture()
      update_attrs = %{cf: "some updated cf", firstname: "some updated firstname", lastname: "some updated lastname", date_of_birth: ~D[2024-12-11]}

      assert {:ok, %Patient{} = patient} = Patients.update_patient(patient, update_attrs)
      assert patient.cf == "some updated cf"
      assert patient.firstname == "some updated firstname"
      assert patient.lastname == "some updated lastname"
      assert patient.date_of_birth == ~D[2024-12-11]
    end

    test "update_patient/2 with invalid data returns error changeset" do
      patient = patient_fixture()
      assert {:error, %Ecto.Changeset{}} = Patients.update_patient(patient, @invalid_attrs)
      assert patient == Patients.get_patient!(patient.id)
    end

    test "delete_patient/1 deletes the patient" do
      patient = patient_fixture()
      assert {:ok, %Patient{}} = Patients.delete_patient(patient)
      assert_raise Ecto.NoResultsError, fn -> Patients.get_patient!(patient.id) end
    end

    test "change_patient/1 returns a patient changeset" do
      patient = patient_fixture()
      assert %Ecto.Changeset{} = Patients.change_patient(patient)
    end
  end
end
