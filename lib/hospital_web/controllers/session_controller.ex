defmodule HospitalWeb.SessionController do
  use HospitalWeb, :controller

  alias Hospital.Patients
  alias Hospital.Staff

  def index(conn, _params) do
    render(conn, "new.html")
  end

  def create(
        conn,
        %{"_csrf_token" => _csrf_token, "email" => email, "password" => password}
      ) do
    user = %{"email" => email, "password" => password}

    case Hospital.Session.login(user, Hospital.Repo) do
      {:ok, user} ->
        if user.type == "doctor" do
          doc_id = Staff.get_doctor_by_uid!(user.id)

          conn
          |> put_session(:current_user, user.id)
          |> put_flash(:info, "Logged in")
          |> redirect(to: Routes.doctor_path(conn, :show, doc_id))
        else
          pat_id = Patients.get_patient_by_uid!(user.id)

          conn
          |> put_session(:current_user, user.id)
          |> put_flash(:info, "Logged in")
          |> redirect(to: Routes.patient_path(conn, :show, pat_id))
        end

        IO.inspect(user)

      :error ->
        conn
        |> put_flash(:info, "Wrong email or password")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> delete_session(:current_user)
    |> put_flash(:info, "Logged out")
    |> redirect(to: Routes.page_path(conn, :index))
  end

  @spec show(Plug.Conn.t(), any) :: Plug.Conn.t()
  def show(conn, _) do
    conn
    |> redirect(to: Routes.page_path(conn, :index))
  end

  def current_user_id(conn) do
    conn
    |> get_session(:current_user)


  end
end
