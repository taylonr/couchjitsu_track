defmodule CouchjitsuTrack.ActivityFeedController do
  use CouchjitsuTrack.Web, :controller

  alias CouchjitsuTrack.Record

  plug CouchjitsuTrack.Plugs.RequireAuthentication

  def index(conn, _params) do
      user = Plug.Conn.get_session(conn, :current_user)

      history = CouchjitsuTrack.ActivityHistory.get_history_for_user(user.id)

      dates = CouchjitsuTrack.ActivityHistory.get_dates_for_user(user.id)

      render conn, "index.html", events: history, dates: dates
  end

  def new(conn, _params) do
    user = conn.assigns[:current_user]
    activities = CouchjitsuTrack.Activity.Query.get_for_user(user.id)
    changeset = Record.changeset(%Record{})

    render conn, "new.html", activities: activities, changeset: changeset
  end

  def create(conn, %{"record" => record}) do
    Record.changeset(%Record{}, record)
    |> Record.add

    redirect(conn, to: "/activityfeed/new")
  end
end