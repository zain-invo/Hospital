defmodule Hospital.Plugs.SetUser do
  import Plug.Conn
  alias Hospital.Repo
  alias Hospital.Accounts.Admin

  def init(_params) do
  end

  def call(conn, _params) do
    user_id = get_session(conn, :user_id)

    cond do
      user = user_id && Repo.get(Admin, user_id) ->
        assign(conn, :user, user)

      true ->
        assign(conn, :user, nil)
    end
  end
end
