defmodule HospitalWeb.PrescriptionControllerTest do
  use HospitalWeb.ConnCase

  alias Hospital.Prescriptions

  @create_attrs %{dose: "some dose", med_name: "some med_name", times_in_day: "some times_in_day"}
  @update_attrs %{dose: "some updated dose", med_name: "some updated med_name", times_in_day: "some updated times_in_day"}
  @invalid_attrs %{dose: nil, med_name: nil, times_in_day: nil}

  def fixture(:prescription) do
    {:ok, prescription} = Prescriptions.create_prescription(@create_attrs)
    prescription
  end

  describe "index" do
    test "lists all prescriptions", %{conn: conn} do
      conn = get(conn, Routes.prescription_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Prescriptions"
    end
  end

  describe "new prescription" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.prescription_path(conn, :new))
      assert html_response(conn, 200) =~ "New Prescription"
    end
  end

  describe "create prescription" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.prescription_path(conn, :create), prescription: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.prescription_path(conn, :show, id)

      conn = get(conn, Routes.prescription_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Prescription"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.prescription_path(conn, :create), prescription: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Prescription"
    end
  end

  describe "edit prescription" do
    setup [:create_prescription]

    test "renders form for editing chosen prescription", %{conn: conn, prescription: prescription} do
      conn = get(conn, Routes.prescription_path(conn, :edit, prescription))
      assert html_response(conn, 200) =~ "Edit Prescription"
    end
  end

  describe "update prescription" do
    setup [:create_prescription]

    test "redirects when data is valid", %{conn: conn, prescription: prescription} do
      conn = put(conn, Routes.prescription_path(conn, :update, prescription), prescription: @update_attrs)
      assert redirected_to(conn) == Routes.prescription_path(conn, :show, prescription)

      conn = get(conn, Routes.prescription_path(conn, :show, prescription))
      assert html_response(conn, 200) =~ "some updated dose"
    end

    test "renders errors when data is invalid", %{conn: conn, prescription: prescription} do
      conn = put(conn, Routes.prescription_path(conn, :update, prescription), prescription: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Prescription"
    end
  end

  describe "delete prescription" do
    setup [:create_prescription]

    test "deletes chosen prescription", %{conn: conn, prescription: prescription} do
      conn = delete(conn, Routes.prescription_path(conn, :delete, prescription))
      assert redirected_to(conn) == Routes.prescription_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.prescription_path(conn, :show, prescription))
      end
    end
  end

  defp create_prescription(_) do
    prescription = fixture(:prescription)
    %{prescription: prescription}
  end
end
