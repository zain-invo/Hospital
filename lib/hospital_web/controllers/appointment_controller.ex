defmodule HospitalWeb.AppointmentController do
  use HospitalWeb, :controller

  alias Hospital.Staff
  alias Hospital.Staff.Appointment
  alias Hospital.Patients

  def index(conn, _params) do
    appointments = Staff.list_appointments()
    render(conn, "index.html", appointments: appointments)
  end

  def new(conn, _params) do
    doctors = Staff.list_doctors()
    patients = Patients.list_patients()
    changeset = Staff.change_appointment(%Appointment{})
    render(conn, "file.html", changeset: changeset, doctors: doctors, patients: patients)
  end

  def create(conn, %{"appointment" => appointment_params}) do
    if check_existing(appointment_params) == true do
      case Staff.create_appointment(appointment_params) do
        {:ok, appointment} ->
          conn
          |> put_flash(:info, "Appointment created successfully.")
          |> redirect(to: Routes.appointment_path(conn, :show, appointment))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    else
      conn
      |> put_flash(
        :error,
        "This Time Slot is not Available. Please choose another Time for Appointment."
      )
      |> redirect(to: Routes.appointment_path(conn, :new, appointment_params))
    end
  end

  def show(conn, %{"id" => id}) do
    appointment = Staff.get_appointment!(id)
    render(conn, "show.html", appointment: appointment)
  end

  def edit(conn, %{"id" => id}) do
    appointment = Staff.get_appointment!(id)
    changeset = Staff.change_appointment(appointment)
    render(conn, "edit.html", appointment: appointment, changeset: changeset)
  end

  def update(conn, %{"id" => id, "appointment" => appointment_params}) do
    appointment = Staff.get_appointment!(id)

    case Staff.update_appointment(appointment, appointment_params) do
      {:ok, appointment} ->
        conn
        |> put_flash(:info, "Appointment updated successfully.")
        |> redirect(to: Routes.appointment_path(conn, :show, appointment))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", appointment: appointment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    appointment = Staff.get_appointment!(id)
    {:ok, _appointment} = Staff.delete_appointment(appointment)

    conn
    |> put_flash(:info, "Appointment deleted successfully.")
    |> redirect(to: Routes.appointment_path(conn, :index))
  end

  defp check_existing(appointment_params) do
    IO.puts("**************")
    IO.inspect(appointment_params["patient_id"])

    if(
      Staff.is_doc_free(
        appointment_params["doctor_id"],
        appointment_params["date"],
        appointment_params["from"],
        appointment_params["to"]
      ) &&
        Patients.is_patient_free(
          appointment_params["patient_id"],
          appointment_params["date"],
          appointment_params["from"],
          appointment_params["to"]
        )
    ) do
      true
    else
      false
    end
  end
end
