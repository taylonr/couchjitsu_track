defmodule CouchjitsuTrack.Prediction do

    def get_suggestions_for_date(activities, records, date) do
        todays_activities = Enum.map(records, fn r ->
            r.name
        end)

        acts = Enum.map(activities, fn a ->
            %{
                name: a.name,
                id: a.activity_id,
                duration: a.default_duration,
                day_of_week: CouchjitsuTrack.Date.get_day_name(a.date)}
        end)

        day_name = CouchjitsuTrack.Date.get_day_name(date)

        get_suggestions(acts, day_name, todays_activities)
    end

    def get_suggestions(activities, day_of_week, today \\ []) do
        bayes = SimpleBayes.init

        Enum.reject(activities, fn a ->
            a.day_of_week == :invalid
        end)
        |> Enum.map(fn a ->
            SimpleBayes.train(bayes, a, a.day_of_week)
        end)

        SimpleBayes.classify(bayes, day_of_week)
        |> eliminate_zero_scores
        |> eliminate_activities_performed_today(today)
        |> Enum.take(2)
    end

    defp eliminate_zero_scores(suggestions) do
        Enum.filter(suggestions, &(elem(&1, 1) > 0))
    end

    defp eliminate_activities_performed_today(suggestions, today) do
        Enum.reject(suggestions, fn a -> activity_in_today(a, today) end)
    end

    defp activity_in_today(activity, today) do
        Enum.any?(today, fn t ->
            t == elem(activity, 0).name
        end)
    end
end