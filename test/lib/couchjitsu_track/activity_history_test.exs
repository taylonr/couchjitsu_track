defmodule ActivityHistoryTest do
    use ExUnit.Case

    alias CouchjitsuTrack.ActivityHistory

    test "Get statistics should set max to true on the item with the highest number" do
        activities = [%{month: 1, year: 2016, hours: 10}, %{month: 2, year: 2016, hours: 5}]
        [stats | _] = ActivityHistory.set_statistics(activities)
        assert stats.max == true
    end

    test "Get statistics should set min to true on the item with the lowest number" do
        activities = [%{month: 1, year: 2016, hours: 10}, %{month: 2, year: 2016, hours: 5}]
        [_ | [stats | _ ]] = ActivityHistory.set_statistics(activities)
        assert stats.min == true
    end
end