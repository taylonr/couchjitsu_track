defmodule CouchjitsuTrack.StatisticsViewTest do
    use CouchjitsuTrack.ConnCase, async: true

    test "Total should create a sum of all items in list" do
        total = CouchjitsuTrack.StatisticsView.total([%{sum: 10}, %{sum: 20}])
        assert total == 30
    end

    test "Trend should return positive if current period is bigger than previous" do
        trend = CouchjitsuTrack.StatisticsView.trend([%{sum: 10}], [%{sum: 5}])
        assert trend == "ui arrow up icon"
    end

    test "Trend should return negative if current period is smaller than previous" do
        trend = CouchjitsuTrack.StatisticsView.trend([%{sum: 10}], [%{sum: 50}])
        assert trend == "ui arrow down icon"
    end

    test "Trend should return neutral if current period equals previous" do
        trend = CouchjitsuTrack.StatisticsView.trend([%{sum: 10}], [%{sum: 10}])
        assert trend == ""
    end
end