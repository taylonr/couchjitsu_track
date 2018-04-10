defmodule CouchjitsuTrack.StatisticsQuery do
    import Ecto.Query
    import CouchjitsuTrack.Repo

    alias CouchjitsuTrack.{Category, Activity, Record}

    def get_statistics(user_id) do
        stats = query_statistics(user_id);
        years = Enum.uniq_by(stats, fn s -> s.year end)

        Enum.map(years, fn year -> get_year(stats, year) end)
    end

    def get_statistics(user_id, month, year) do
        stats = query_statistics(user_id)

        %{
            current_month: get_month(stats, month, year),
            previous_month: get_month(stats, month - 1, year),
            current_year: get_year(stats, year),
            previous_year: get_year(stats, year - 1),
            all_time: get_all_time(stats)
        }

    end

    defp get_month(stats, 0, year) do
        get_month(stats, 12, year - 1)
    end

    defp get_month(stats, month, year) do
        Enum.filter(stats, fn s -> filter_on_month_and_year(s, month, year) end)
            |> Enum.group_by(&(&1.name), &(&1.sum))
            |> Enum.map(&get_sums/1)
    end

    defp get_year(stats, year) do
        Enum.filter(stats, fn s -> filter_on_year(s, year) end)
            |> Enum.group_by(&(&1.name), &(&1.sum))
            |> Enum.map(&get_sums/1)
    end

    defp get_all_time(stats) do
        Enum.group_by(stats, &(&1.name), &(&1.sum))
            |> Enum.map(&get_sums/1)
    end

    defp get_sums({key, sums}) do
        %{name: key, sum: sum(sums)}
    end

    defp sum(vals) do
        Enum.reduce(vals, fn x, acc -> x + acc end)
    end

    defp filter_on_year(stat, year) do
        stat.year == year
    end

    defp filter_on_month_and_year(stat, month, year) do
        stat.month == month && stat.year == year
    end

    defp query_statistics(user_id) do
        categories = from(c in Category,
            join: a in Activity, on: a.category_id == c.id,
            join: r in Record, on: r.activity_id == a.id,
            where: a.user_id == ^user_id,
            group_by: fragment("?, date_part('month', ?), date_part('year', ?)", c.name, r.date, r.date),
            select: %{name: c.name, month: fragment("date_part('month', ?)", r.date),
            year: fragment("date_part('year', ?)", r.date),
            sum: fragment("sum(?)",  r.duration)})

        |> all()

        activities = from(a in Activity,
            join: r in Record, on: r.activity_id == a.id,
            where: a.user_id == ^user_id and is_nil(a.category_id),
            group_by: fragment("?, date_part('month', ?), date_part('year', ?)", a.name, r.date, r.date),
            select: %{name: a.name, month: fragment("date_part('month', ?)", r.date),
                year: fragment("date_part('year', ?)", r.date),
                sum: fragment("sum(?)",  r.duration)})

        |> all()
        |> Enum.into(categories)
        |> Enum.uniq
    end
end