defmodule HospitalWeb.DoctorController do
  use HospitalWeb, :controller

  alias Hospital.Staff
  alias Hospital.Staff.Doctor

  def index(conn, _parmas) do
    doctors = Staff.list_doctors()
    render(conn, "index.html", doctors: doctors)
  end

  def new(conn, params) do
    changeset = Staff.change_doctor(%Doctor{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"doctor" => doctor_params}) do
    user_id = Plug.Conn.get_session(conn, :current_user)

    doctor_params =
      cond do
        user_id -> Map.put(doctor_params, "user_id", user_id)
      end

    IO.inspect(doctor_params)

    case Staff.create_doctor(doctor_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> put_flash(:info, "Please Sign in.")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, _params) do
    id = Plug.Conn.get_session(conn, :current_user)
    doctor = Staff.get_doctor_by_uid!(id)
    IO.inspect(doctor)
    render(conn, "show.html", doctor: doctor)
  end

  def edit(conn, %{"id" => id}) do
    doctor = Staff.get_doctor!(id)
    changeset = Staff.change_doctor(doctor)
    render(conn, "edit.html", doctor: doctor, changeset: changeset)
  end

  @spec update(Plug.Conn.t(), map) :: Plug.Conn.t()
  def update(conn, %{"id" => id, "doctor" => doctor_params}) do
    doctor = Staff.get_doctor!(id)

    case Staff.update_doctor(doctor, doctor_params) do
      {:ok, doctor} ->
        conn
        |> put_flash(:info, "doctor updated successfully.")
        |> redirect(to: Routes.doctor_path(conn, :show, doctor))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", doctor: doctor, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    doctor = Staff.get_doctor!(id)
    user_id = doctor["user_id"]
    {:ok, _doctor} = Staff.delete_doctor(doctor)
    {:ok, _user} = Hospital.Accounts.delete_user(user_id)

    conn
    |> put_flash(:info, "doctor deleted successfully.")
    |> redirect(to: Routes.doctor_path(conn, :index))
  end
end
