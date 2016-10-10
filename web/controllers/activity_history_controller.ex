defmodule CouchjitsuTrack.ActivityHistoryController do
  use CouchjitsuTrack.Web, :controller

  def index(conn, _params) do
      history = CouchjitsuTrack.ActivityHistory.get_history_for_user(76)

      render conn, "index.html", events: history
  end
end