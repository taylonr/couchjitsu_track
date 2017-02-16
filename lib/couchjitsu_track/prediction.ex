defmodule CouchjitsuTrack.Prediction do

    def get_suggestions(activities, day_of_week, today \\ []) do
        bayes = SimpleBayes.init

        Enum.map(activities, fn a ->
            SimpleBayes.train(bayes, a["name"], a["day_of_week"])
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
            t == elem(activity, 0)
        end)
    end
end