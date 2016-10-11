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
                    note: r.note
                },
                order_by: [desc: r.date]

        CouchjitsuTrack.Repo.all(query)
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