defmodule CouchjitsuTrack.ActivityHistory do
    @moduledoc """
    A collection of queries for activities.
    """

    import Ecto.Query
    alias CouchjitsuTrack.Record
    alias CouchjitsuTrack.Activity

    @doc """
    Gets all activities for a specified user id.

    Will return a list of %{date, name, time, note, activity_id}
    """
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

    @doc """
    Gets all the history for a specific activity id.

    Will return a list of activities grouped by month & year, and a sum of all the activities for that month.
    """
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

    @doc """
    Takes a list of `Activity` structs, finds the max and min values and sets them on the list
    """
    def set_statistics(activities) do
        max_val = Enum.max_by(activities, &get_hours/1)
        min_val = Enum.min_by(activities, &get_hours/1)

        Enum.map(activities, fn(a) ->
            a
            |> Map.put_new(:max, a.hours == max_val.hours)
            |> Map.put_new(:min, a.hours == min_val.hours)
        end)
    end

    defp get_hours(activity) do
        activity.hours
    end

    @doc """
    Gets the name for the specified activity id
    """
    def get_name(activity_id) do
        CouchjitsuTrack.Repo.get(Activity, activity_id).name
    end

    @doc """
    Gets a distinct list of dates for a specified user id.
    """
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