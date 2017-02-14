defmodule CouchjitsuTrack.Activity.Query do
    import Ecto.Query

    import CouchjitsuTrack.RecentActivity

    alias CouchjitsuTrack.Activity
    alias CouchjitsuTrack.Record

    @doc """
    Gets all activities for the specified user id
    """
    def get_for_user(user_id) do
        query = from a in Activity,
                where: a.user_id == ^user_id,
                order_by: fragment("LOWER(?)", a.name)
        CouchjitsuTrack.Repo.all(query)
    end

    def get_recent_activities(user_id) do
        query = from a in Activity,
                join: r in Record, on: a.id == r.activity_id,
                where: a.user_id == ^user_id,
                select: %{"name" => a.name, "weekday_number" => fragment("extract(dow from ?)", r.date)}

        CouchjitsuTrack.Repo.all(query)
        |> Enum.map(&add_day_name/1)
    end

    defp add_day_name(activity) do
        Map.put_new(activity, "weekday", CouchjitsuTrack.Date.day_name(round(activity["weekday_number"])))
    end
end