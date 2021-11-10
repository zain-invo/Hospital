defmodule HospitalWeb.BillView do
  use HospitalWeb, :view
  Plug.CSRFProtection.get_csrf_token()
end
