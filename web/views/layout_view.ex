defmodule CouchjitsuTrack.LayoutView do
  use CouchjitsuTrack.Web, :view

  def get_user (conn) do
    user = Plug.Conn.get_session(conn, :current_user)
    if user do
      user.name
    else
      "Log In"
    end

  end
end
