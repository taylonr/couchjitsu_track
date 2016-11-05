defmodule CouchjitsuTrack.AuthController do
  use CouchjitsuTrack.Web, :controller
  plug Ueberauth

  alias Ueberauth.Strategy.Helpers

  def request(conn, _params) do
    render(conn, "request.html", callback_url: Helpers.callback_url(conn))
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
      user = CouchjitsuTrack.Oauth.get_user(auth)
      expiration = 60*60*24*7

      Plug.Conn.put_resp_cookie(conn, "user_id", "#{user.id}", max_age: expiration)
      |> Plug.Conn.put_resp_cookie("user_name", user.name, max_age: expiration)
      |> put_session(:current_user, CouchjitsuTrack.Oauth.get_user(auth))
      |> redirect(to: "/activityfeed/new")
  end
end