defmodule HospitalWeb.PatientController do
  use HospitalWeb, :controller

  alias Hospital.Patients
  alias Hospital.Patients.Patient
  alias Hospital.Staff
  plug Hospital.Plugs.RequireAuth when action in [:index, :edit, :update, :delete]

  def index(conn, _params) do
    patients = Patients.list_patients()

    render(conn, "index.html", patients: patients)
  end

  def new(conn, _params) do
    changeset = Patients.change_patient(%Patient{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"patient" => patient_params}) do
    user_id = Plug.Conn.get_session(conn, :current_user)

    patient_params =
      cond do
        user_id -> Map.put(patient_params, "user_id", user_id)
      end

    case Patients.create_patient(patient_params) do
      {:ok, patient} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: Routes.user_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    patient = Patients.get_patient!(id)
    appointments = Staff.get_patient_appointment(id)
    prescriptions = Hospital.Prescriptions.patient_prescriptions(id)
    render(conn, "show.html", patient: patient, appointments: appointments, prescriptions: prescriptions)
  end

  def edit(conn, %{"id" => id}) do
    patient = Patients.get_patient!(id)
    changeset = Patients.change_patient(patient)
    render(conn, "edit.html", patient: patient, changeset: changeset)
  end

  def update(conn, %{"id" => id, "patient" => patient_params}) do
    patient = Patients.get_patient!(id)

    case Patients.update_patient(patient, patient_params) do
      {:ok, patient} ->
        conn
        |> put_flash(:info, "Patient updated successfully.")
        |> redirect(to: Routes.patient_path(conn, :show, patient))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", patient: patient, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    patient = Patients.get_patient!(id)
    IO.inspect(patient)

    {:ok, _patient} = Patients.delete_patient(patient)
    # {:ok, _user} = Hospital.Accounts.delete_user(user_id)

    conn
    |> put_flash(:info, "Patient deleted successfully.")
    |> redirect(to: Routes.patient_path(conn, :index))
  end


  def bill(conn, %{"patient_id"=>patient_id}) do

    id = elem(Integer.parse(patient_id),0)
    patient = Hospital.Patients.get_patient!(id)
    prescriptions = Hospital.Prescriptions.patient_prescriptions((id))
    bills = Hospital.Billing.list_bills_by_patient_id(id)

    render(conn, "bill.html", patient: patient, prescriptions: prescriptions, bills: bills)
  end

end
