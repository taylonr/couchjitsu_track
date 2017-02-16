defmodule PredictionTest do
    use ExUnit.Case

# r.date,
# name: a.name,
# time: r.duration,
# note: r.note,
# activity_id: a.id,
# id: r.id
alias CouchjitsuTrack.Prediction

    test "Should return the name of activities" do
        activities = [%{"name" => "technique", "day_of_week" => "monday"}]

        suggestion = Prediction.get_suggestions(activities, "monday")
        |> Enum.at(0)
        |> elem(0)

        assert suggestion == "technique"
    end

    test "Should return all activities with score greater than 0" do
        activities = [%{"name" => "technique", "day_of_week" => "monday"},
                    %{"name" => "judo", "day_of_week" => "tuesday"}]

        suggestions = Prediction.get_suggestions(activities, "monday")
        |> Enum.map(&(elem(&1, 0)))

        assert suggestions == ["technique"]
    end

    test "Should not include activities that are already entered today" do
        activities = [%{"name" => "technique", "day_of_week" => "monday"},
                    %{"name" => "sparring", "day_of_week" => "monday"}]

        suggestions = Prediction.get_suggestions(activities, "monday", ["technique"])
        |> Enum.map(&(elem(&1, 0)))

        assert suggestions == ["sparring"]
    end

    test "Should include at most two recommendations" do
         activities = [%{"name" => "technique", "day_of_week" => "monday"},
                    %{"name" => "judo", "day_of_week" => "monday"},
                    %{"name" => "sparring", "day_of_week" => "monday"}]

        count = Prediction.get_suggestions(activities, "monday")
        |> Enum.count()

        assert count == 2
    end
end