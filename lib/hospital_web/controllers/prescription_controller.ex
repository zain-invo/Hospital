defmodule HospitalWeb.PrescriptionController do
  use HospitalWeb, :controller

  alias Hospital.Prescriptions
  alias Hospital.Prescriptions.Prescription
  alias Hospital.Staff.Doctor
  alias Hospital.Staff

  def index(conn, _params) do
    prescriptions = Prescriptions.list_prescriptions()
    render(conn, "index.html", prescriptions: prescriptions)
  end

  def new(conn, patient) do
    patient_id = elem(Integer.parse(patient["patient_id"]),0)
    patient = Hospital.Patients.get_patient!(patient_id)
    changeset = Prescriptions.change_prescription(%Prescription{})
    current_user = conn |> get_session(:current_user)
    doctor = Hospital.Staff.get_doctor_by_uid!(current_user)
    render(conn, "form_new.html", changeset: changeset, patient: patient, doctor: doctor)
  end

  def create(conn, %{"prescription" => prescription_params}) do
    IO.inspect(prescription_params)
    case Prescriptions.create_prescription(prescription_params) do
      {:ok, prescription} ->
        conn
        |> put_flash(:info, "Prescription created successfully.")
        |> redirect(to: Routes.doctor_path(conn, :show, prescription.doctor_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        patient = Hospital.Patients.get_patient!(prescription_params["patient_id"])
        current_user = conn |> get_session(:current_user)
        doctor = Hospital.Staff.get_doctor_by_uid!(current_user)
        render(conn, "form_new.html", changeset: changeset, patient: patient, doctor: doctor)
    end
  end

  def show(conn, %{"id" => id}) do
    prescription = Prescriptions.get_prescription!(id)
    render(conn, "show.html", prescription: prescription)
  end

  def edit(conn, %{"id" => id}) do
    prescription = Prescriptions.get_prescription!(id)
    changeset = Prescriptions.change_prescription(prescription)
    render(conn, "edit.html", prescription: prescription, changeset: changeset)
  end

  def update(conn, %{"id" => id, "prescription" => prescription_params}) do
    prescription = Prescriptions.get_prescription!(id)

    case Prescriptions.update_prescription(prescription, prescription_params) do
      {:ok, prescription} ->
        conn
        |> put_flash(:info, "Prescription updated successfully.")
        |> redirect(to: Routes.prescription_path(conn, :show, prescription))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", prescription: prescription, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    prescription = Prescriptions.get_prescription!(id)
    {:ok, _prescription} = Prescriptions.delete_prescription(prescription)

    conn
    |> put_flash(:info, "Prescription deleted successfully.")
    |> redirect(to: Routes.prescription_path(conn, :index))
  end

  def insert_prescription(conn, %{"patient_id"=>patient_id}) do
    patient_id = elem(Integer.parse(patient_id),0)
    patient = Hospital.Patients.get_patient!(patient_id)
    changeset = Prescriptions.change_prescription(%Prescription{})
    current_user = conn |> get_session(:current_user)
    doctor = Hospital.Staff.get_doctor_by_uid!(current_user)

    render(conn, "form_new.html", changeset: changeset, patient: patient, doctor: doctor)
  end
end
