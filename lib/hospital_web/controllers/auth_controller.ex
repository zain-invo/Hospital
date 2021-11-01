defmodule HospitalWeb.AuthController do
  use HospitalWeb, :controller
  alias Hospital.Accounts.User
  alias Hospital.Repo
  plug Ueberauth
  require Logger

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user_params = %{token: auth.credentials.token, email: auth.info.email, provider: "github"}

    try do
      changeset = User.changeset(%User{}, user_params)

      signin(conn, changeset)
    rescue
      e ->
        Logger.error(Exception.format(:error, e, __STACKTRACE__))
        reraise e, __STACKTRACE__
    end
  end

  def signout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: Routes.page_path(conn, :index))
  end

  defp signin(conn, changeset) do
    case insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome Back to Dashboard!")
        |> put_session(:user_id, user.id)
        |> redirect(to: Routes.dashboard_path(conn, :index))

      {:error, reason} ->
        IO.inspect(reason)

        conn
        |> put_flash(:error, "Error signing in.")
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  defp insert_or_update_user(changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      nil ->
        Repo.insert(changeset)

      user ->
        {:ok, user}
    end
  end
end
