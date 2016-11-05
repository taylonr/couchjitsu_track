defmodule CouchjitsuTrack.PageController do
  use CouchjitsuTrack.Web, :controller

  def index(conn, _params) do
    case conn.cookies["user_id"] do
      nil -> render conn, "index.html"
      _ -> redirect conn, to: "/activityfeed/new"
    end
  end
end
