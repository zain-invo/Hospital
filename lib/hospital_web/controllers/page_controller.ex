defmodule HospitalWeb.PageController do
  use HospitalWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
