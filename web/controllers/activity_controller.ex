defmodule CouchjitsuTrack.ActivityController do
    use CouchjitsuTrack.Web, :controller

    def index(conn,  %{"id" => id}) do
        activities = CouchjitsuTrack.ActivityHistory.get_history_for_id(id)
        title = CouchjitsuTrack.ActivityHistory.get_name(id)
        
        render conn, "index.html", activities: activities, title: title
    end
end