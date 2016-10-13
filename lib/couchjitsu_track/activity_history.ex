defmodule CouchjitsuTrack.ActivityHistory do
    import Ecto.Query
    alias CouchjitsuTrack.Record
    alias CouchjitsuTrack.Activity

    def get_history_for_user(user_id) do
        query = from r in Record,
                join: a in Activity, on: r.activity_id == a.id,
                where: a.user_id == ^user_id,
                select: %{date: r.date,
                    name: a.name,
                    time: r.duration,
                    note: r.note,
                    activity_id: a.id
                },
                order_by: [desc: r.date]

        CouchjitsuTrack.Repo.all(query)
    end

    def get_history_for_id(activity_id) do
        query = from r in Record,
                where: r.activity_id == ^activity_id,
                select: %{month: fragment("date_part('month', ?)::integer", r.date),
                        year: fragment("date_part('year', ?)::integer", r.date),
                        hours: sum(r.duration)
                },
                group_by: fragment("date_part('month', ?), date_part('year', ?)", r.date, r.date),
                order_by: fragment("date_part('year', ?), date_part('month', ?)", r.date, r.date)
        CouchjitsuTrack.Repo.all(query)
    end

    def get_name(activity_id) do
        CouchjitsuTrack.Repo.get(Activity, activity_id).name
    end

    def get_dates_for_user(user_id) do
        query = from r in Record,
                join: a in Activity, on: r.activity_id == a.id,
                where: a.user_id == ^user_id,
                select: r.date,
                distinct: true,
                order_by: [desc: r.date]

        CouchjitsuTrack.Repo.all(query)
    end
end