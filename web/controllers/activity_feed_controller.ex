defmodule CouchjitsuTrack.ActivityFeedController do
  use CouchjitsuTrack.Web, :controller

  alias CouchjitsuTrack.Record
  alias CouchjitsuTrack.Activity

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
    case Integer.parse(record["activity_id"]) do
      {_, _} -> Record.changeset(%Record{}, record) |> Record.add
      :error -> create_activity_with_record(conn.assigns.current_user.id, record)
    end

    Record.changeset(%Record{}, record)
    |> Record.add

    redirect(conn, to: "/activityfeed/new")
  end

  defp create_activity_with_record(user_id, record) do
    activity = Activity.changeset(%Activity{}, %{user_id: user_id, name: record["activity_id"], default_duration: record["duration"]})
    |> Activity.add

    new_record = Map.put(record, "activity_id", Integer.to_string(activity.id))

    Record.changeset(%Record{}, new_record)
    |> Record.add
  end
end