defmodule CouchjitsuTrack.ActivityHistoryController do
  use CouchjitsuTrack.Web, :controller

  def index(conn, _params) do
      history = CouchjitsuTrack.ActivityHistory.get_history_for_user(76)

      dates = CouchjitsuTrack.ActivityHistory.get_dates_for_user(76)

      render conn, "index.html", events: history, dates: dates
  end
end