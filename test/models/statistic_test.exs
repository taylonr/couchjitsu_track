defmodule StatisticTest do
    use ExUnit.Case

    import Mock

    alias CouchjitsuTrack.StatisticsQuery

    test "Should get total for current month" do
        with_mock CouchjitsuTrack.Repo, [all: fn (_) -> [%{name: "test", month: 1, year: 2016, sum: 5}, %{name: "test", month: 2, year: 2016, sum: 10}] end] do
            %{:current_month => cm} = StatisticsQuery.get_statistics(1, 1, 2016)
            assert cm == [%{name: "test", sum: 5}]
        end
    end

    test "Should get total for current year" do
        with_mock CouchjitsuTrack.Repo, [all: fn (_) -> [%{name: "test", month: 1, year: 2016, sum: 5}, %{name: "test", month: 2, year: 2016, sum: 10}] end] do
            %{:current_year => cy} = StatisticsQuery.get_statistics(1, 1, 2016)
            assert cy == [%{name: "test", sum: 15}]
        end
    end

    test "Should get total for all time" do
        with_mock CouchjitsuTrack.Repo, [all: fn (_) -> [%{name: "test", month: 1, year: 2016, sum: 5}, %{name: "test", month: 2, year: 2016, sum: 10}, %{name: "test", month: 2, year: 2015, sum: 15}] end] do
            %{:all_time => at} = StatisticsQuery.get_statistics(1, 1, 2016)
            assert at == [%{name: "test", sum: 30}]
        end
    end
end