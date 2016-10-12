defmodule CouchjitsuTrack.ActivityController do
    use CouchjitsuTrack.Web, :controller

    def index(conn,  %{"id" => id}) do
        activities = CouchjitsuTrack.ActivityHistory.get_history_for_id(id)

        render conn, "index.html", activities: activities
    end
end