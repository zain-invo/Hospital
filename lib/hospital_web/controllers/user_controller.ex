defmodule HospitalWeb.UserController do
  use HospitalWeb, :controller

  alias Hospital.Accounts
  alias Hospital.Accounts.User
  plug Hospital.Plugs.RequireAuth when action in [:index, :show, :edit, :update, :delete]

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Accounts.create(changeset, Hospital.Repo) do
      {:ok, changeset} ->
        IO.inspect(changeset)
        IO.inspect(changeset.type)

        if changeset.type == "doctor" do
          IO.inspect(changeset.type)

          conn
          |> put_session(:current_user, changeset.id)
          |> put_flash(:info, "Your Account was Created")
          |> redirect(to: Routes.doctor_path(conn, :new))
        else
          conn
          |> put_session(:current_user, changeset.id)
          |> put_flash(:info, "Your Account was Created")
          |> redirect(to: Routes.patient_path(conn, :new))
        end

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.user_path(conn, :index))
  end
end
