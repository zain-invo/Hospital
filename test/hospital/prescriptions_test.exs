defmodule Hospital.PrescriptionsTest do
  use Hospital.DataCase

  alias Hospital.Prescriptions

  describe "prescriptions" do
    alias Hospital.Prescriptions.Prescription

    @valid_attrs %{dose: "some dose", med_name: "some med_name", times_in_day: "some times_in_day"}
    @update_attrs %{dose: "some updated dose", med_name: "some updated med_name", times_in_day: "some updated times_in_day"}
    @invalid_attrs %{dose: nil, med_name: nil, times_in_day: nil}

    def prescription_fixture(attrs \\ %{}) do
      {:ok, prescription} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Prescriptions.create_prescription()

      prescription
    end

    test "list_prescriptions/0 returns all prescriptions" do
      prescription = prescription_fixture()
      assert Prescriptions.list_prescriptions() == [prescription]
    end

    test "get_prescription!/1 returns the prescription with given id" do
      prescription = prescription_fixture()
      assert Prescriptions.get_prescription!(prescription.id) == prescription
    end

    test "create_prescription/1 with valid data creates a prescription" do
      assert {:ok, %Prescription{} = prescription} = Prescriptions.create_prescription(@valid_attrs)
      assert prescription.dose == "some dose"
      assert prescription.med_name == "some med_name"
      assert prescription.times_in_day == "some times_in_day"
    end

    test "create_prescription/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Prescriptions.create_prescription(@invalid_attrs)
    end

    test "update_prescription/2 with valid data updates the prescription" do
      prescription = prescription_fixture()
      assert {:ok, %Prescription{} = prescription} = Prescriptions.update_prescription(prescription, @update_attrs)
      assert prescription.dose == "some updated dose"
      assert prescription.med_name == "some updated med_name"
      assert prescription.times_in_day == "some updated times_in_day"
    end

    test "update_prescription/2 with invalid data returns error changeset" do
      prescription = prescription_fixture()
      assert {:error, %Ecto.Changeset{}} = Prescriptions.update_prescription(prescription, @invalid_attrs)
      assert prescription == Prescriptions.get_prescription!(prescription.id)
    end

    test "delete_prescription/1 deletes the prescription" do
      prescription = prescription_fixture()
      assert {:ok, %Prescription{}} = Prescriptions.delete_prescription(prescription)
      assert_raise Ecto.NoResultsError, fn -> Prescriptions.get_prescription!(prescription.id) end
    end

    test "change_prescription/1 returns a prescription changeset" do
      prescription = prescription_fixture()
      assert %Ecto.Changeset{} = Prescriptions.change_prescription(prescription)
    end
  end
end
