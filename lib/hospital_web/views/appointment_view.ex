defmodule HospitalWeb.AppointmentView do
  use HospitalWeb, :view

  def csrf_token(conn) do
    Plug.CSRFProtection.get_csrf_token()
  end
end
