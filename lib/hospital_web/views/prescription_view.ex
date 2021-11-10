defmodule HospitalWeb.PrescriptionView do
  use HospitalWeb, :view

  def csrf_token(conn) do
    Plug.CSRFProtection.get_csrf_token()
  end
end
