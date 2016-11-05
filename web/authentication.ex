defmodule CouchjitsuTrack.Plugs.RequireAuthentication do
  import Plug.Conn
  import Phoenix.Controller

  def init(options) do
    options
  end

  def call(conn, _) do
    user_id = conn.cookies["user_id"]

    case user_id do
      nil ->
        conn |> redirect(to: "/") |> halt
      _ ->
        user = CouchjitsuTrack.User.find_by_id(user_id)
        conn |> assign(:current_user, user)
    end
  end

end