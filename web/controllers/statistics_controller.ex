defmodule CouchjitsuTrack.StatisticsController do
    use CouchjitsuTrack.Web, :controller

    plug CouchjitsuTrack.Plugs.RequireAuthentication

    def index(conn, _params) do
        stats = CouchjitsuTrack.StatisticsQuery.get_statistics(conn.assigns.current_user.id)

        render conn, "index.html", stats: stats
    end
end