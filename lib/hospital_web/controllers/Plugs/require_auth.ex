defmodule Hospital.Plugs.RequireAuth do
  import Plug.Conn
  import Phoenix.Controller
  alias HospitalWeb.Router.Helpers

  def init(_params) do

  end

  def call(conn, _params) do
    cond do
      conn.assigns[:user] -> conn
      true ->
      conn
      |> put_flash(:error, "You must be signed in.")
      |> redirect(to: Helpers.page_path(conn, :index))
      |> halt()
    end

  end

end
