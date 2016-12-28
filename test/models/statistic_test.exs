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

    test "Should get total for previous month" do
        with_mock CouchjitsuTrack.Repo, [all: fn(_) -> [%{name: "test", month: 1, year: 2016, sum: 5}, %{name: "test", month: 1, year: 2016, sum: 10}] end ] do
            %{:previous_month => pm} = StatisticsQuery.get_statistics(1, 2, 2016)
            assert pm == [%{name: "test", sum:  15}]
        end
    end

    test "Should get total for december of previous year when month is 1" do
        with_mock CouchjitsuTrack.Repo, [all: fn(_) -> [%{name: "test", month: 1, year: 2016, day: 5, sum: 5}, %{name: "test", month: 12, year: 2015, day: 5, sum: 10}] end ] do
            %{:previous_month => pm} = StatisticsQuery.get_statistics(1, 1, 2016)
            assert pm == [%{name: "test", sum:  10}]
        end
    end

    test "Should get total for previous year" do
        with_mock CouchjitsuTrack.Repo, [all: fn(_) -> [%{name: "test", month: 1, year: 2016, day: 5, sum: 5}, %{name: "test", month: 1, year: 2015, day: 5, sum: 10}] end ] do
            %{:previous_year => py} = StatisticsQuery.get_statistics(1, 1,  2016)
            assert py == [%{name: "test", sum: 10}]
        end
    end
end