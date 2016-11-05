defmodule CouchjitsuTrack.StatisticsController do
    use CouchjitsuTrack.Web, :controller

    def index(conn, _params) do
        {{y, m, _}, _} = :calendar.local_time()

        stats = CouchjitsuTrack.StatisticsQuery.get_statistics(conn.assigns.current_user.id, m, y)

        IO.inspect(stats)

        render conn, "index.html", stats: stats
    end
end