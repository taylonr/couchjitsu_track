defmodule CouchjitsuTrack.StatisticsController do
    use CouchjitsuTrack.Web, :controller
    import CouchjitsuTrack.StatisticsQuery

    def index(conn, _params) do
        {{y, m, _}, _} = :calendar.local_time()

        stats = get_statistics(conn.assigns.current_user.id, m, y)

        monthly = Enum.reduce(stats.current_month, 0, fn(s, acc) -> acc + s.sum end )
        yearly = Enum.reduce(stats.current_year, 0, fn(s, acc) -> acc + s.sum end )

        ogtags = %{
                "fb:app_id": System.get_env("GYMTIME_FACEBOOK_TEST_ID"),
                "og:type": "website",
                "og:url": "http://track.couchjitsu.com",
                "og:site_name": "Couchjitsu Gym Tracker",
                "og:title": "Current Progress",
                "og:description": "I've trained #{monthly} hours this month which brings my total to #{yearly} for the year. Track your time with Couchjitsu"
        }

        render conn, "index.html", stats: stats, ogtags: ogtags
    end

    def statistics(conn, _params) do
        {{y, m, _}, _} = :calendar.local_time()
        stats = get_statistics(conn.assigns.current_user.id, m, y)

        json conn, %{stats: stats}
    end

    def yearly(conn, _params) do
        stats = get_statistics(conn.assigns.current_user.id)

        render conn, "yearly.html", stats: stats
    end
end