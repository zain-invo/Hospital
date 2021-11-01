defmodule Hospital.PatientsTest do
  use Hospital.DataCase

  alias Hospital.Patients

  describe "patients" do
    alias Hospital.Patients.Patient

    @valid_attrs %{age: 42, disease: "some disease", gender: "some gender", name: "some name"}
    @update_attrs %{age: 43, disease: "some updated disease", gender: "some updated gender", name: "some updated name"}
    @invalid_attrs %{age: nil, disease: nil, gender: nil, name: nil}

    def patient_fixture(attrs \\ %{}) do
      {:ok, patient} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Patients.create_patient()

      patient
    end

    test "list_patients/0 returns all patients" do
      patient = patient_fixture()
      assert Patients.list_patients() == [patient]
    end

    test "get_patient!/1 returns the patient with given id" do
      patient = patient_fixture()
      assert Patients.get_patient!(patient.id) == patient
    end

    test "create_patient/1 with valid data creates a patient" do
      assert {:ok, %Patient{} = patient} = Patients.create_patient(@valid_attrs)
      assert patient.age == 42
      assert patient.disease == "some disease"
      assert patient.gender == "some gender"
      assert patient.name == "some name"
    end

    test "create_patient/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Patients.create_patient(@invalid_attrs)
    end

    test "update_patient/2 with valid data updates the patient" do
      patient = patient_fixture()
      assert {:ok, %Patient{} = patient} = Patients.update_patient(patient, @update_attrs)
      assert patient.age == 43
      assert patient.disease == "some updated disease"
      assert patient.gender == "some updated gender"
      assert patient.name == "some updated name"
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
