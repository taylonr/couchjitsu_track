defmodule CouchjitsuTrack.StatisticsController do
    use CouchjitsuTrack.Web, :controller
    import CouchjitsuTrack.StatisticsQuery

    def index(conn, _params) do
        {{y, m, _}, _} = :calendar.local_time()

        stats = get_statistics(conn.assigns.current_user.id, m, y)

        render conn, "index.html", stats: stats
    end

    def statistics(conn, _params) do
        {{y, m, _}, _} = :calendar.local_time()
        stats = get_statistics(conn.assigns.current_user.id, m, y)

        json conn, %{stats: stats}
    end
end