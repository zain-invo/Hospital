defmodule Hospital.StaffTest do
  use Hospital.DataCase

  alias Hospital.Staff

  describe "doctors" do
    alias Hospital.Staff.Doctor

    @valid_attrs %{active: true, name: "some name", speciality: "some speciality"}
    @update_attrs %{active: false, name: "some updated name", speciality: "some updated speciality"}
    @invalid_attrs %{active: nil, name: nil, speciality: nil}

    def doctor_fixture(attrs \\ %{}) do
      {:ok, doctor} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Staff.create_doctor()

      doctor
    end

    test "list_doctors/0 returns all doctors" do
      doctor = doctor_fixture()
      assert Staff.list_doctors() == [doctor]
    end

    test "get_doctor!/1 returns the doctor with given id" do
      doctor = doctor_fixture()
      assert Staff.get_doctor!(doctor.id) == doctor
    end

    test "create_doctor/1 with valid data creates a doctor" do
      assert {:ok, %Doctor{} = doctor} = Staff.create_doctor(@valid_attrs)
      assert doctor.active == true
      assert doctor.name == "some name"
      assert doctor.speciality == "some speciality"
    end

    test "create_doctor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Staff.create_doctor(@invalid_attrs)
    end

    test "update_doctor/2 with valid data updates the doctor" do
      doctor = doctor_fixture()
      assert {:ok, %Doctor{} = doctor} = Staff.update_doctor(doctor, @update_attrs)
      assert doctor.active == false
      assert doctor.name == "some updated name"
      assert doctor.speciality == "some updated speciality"
    end

    test "update_doctor/2 with invalid data returns error changeset" do
      doctor = doctor_fixture()
      assert {:error, %Ecto.Changeset{}} = Staff.update_doctor(doctor, @invalid_attrs)
      assert doctor == Staff.get_doctor!(doctor.id)
    end

    test "delete_doctor/1 deletes the doctor" do
      doctor = doctor_fixture()
      assert {:ok, %Doctor{}} = Staff.delete_doctor(doctor)
      assert_raise Ecto.NoResultsError, fn -> Staff.get_doctor!(doctor.id) end
    end

    test "change_doctor/1 returns a doctor changeset" do
      doctor = doctor_fixture()
      assert %Ecto.Changeset{} = Staff.change_doctor(doctor)
    end
  end

  describe "timings" do
    alias Hospital.Staff.Timing

    @valid_attrs %{days_in_week: "some days_in_week", times: ~N[2010-04-17 14:00:00]}
    @update_attrs %{days_in_week: "some updated days_in_week", times: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{days_in_week: nil, times: nil}

    def timing_fixture(attrs \\ %{}) do
      {:ok, timing} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Staff.create_timing()

      timing
    end

    test "list_timings/0 returns all timings" do
      timing = timing_fixture()
      assert Staff.list_timings() == [timing]
    end

    test "get_timing!/1 returns the timing with given id" do
      timing = timing_fixture()
      assert Staff.get_timing!(timing.id) == timing
    end

    test "create_timing/1 with valid data creates a timing" do
      assert {:ok, %Timing{} = timing} = Staff.create_timing(@valid_attrs)
      assert timing.days_in_week == "some days_in_week"
      assert timing.times == ~N[2010-04-17 14:00:00]
    end

    test "create_timing/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Staff.create_timing(@invalid_attrs)
    end

    test "update_timing/2 with valid data updates the timing" do
      timing = timing_fixture()
      assert {:ok, %Timing{} = timing} = Staff.update_timing(timing, @update_attrs)
      assert timing.days_in_week == "some updated days_in_week"
      assert timing.times == ~N[2011-05-18 15:01:01]
    end

    test "update_timing/2 with invalid data returns error changeset" do
      timing = timing_fixture()
      assert {:error, %Ecto.Changeset{}} = Staff.update_timing(timing, @invalid_attrs)
      assert timing == Staff.get_timing!(timing.id)
    end

    test "delete_timing/1 deletes the timing" do
      timing = timing_fixture()
      assert {:ok, %Timing{}} = Staff.delete_timing(timing)
      assert_raise Ecto.NoResultsError, fn -> Staff.get_timing!(timing.id) end
    end

    test "change_timing/1 returns a timing changeset" do
      timing = timing_fixture()
      assert %Ecto.Changeset{} = Staff.change_timing(timing)
    end
  end
end
