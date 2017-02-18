defmodule ActivityFeedViewTest do
    use ExUnit.Case
    alias CouchjitsuTrack.ActivityFeedView

    test "events should get a list of events for a date" do
        {:ok, date} = Ecto.Date.cast({2016, 1, 1})

        [%{name: name}] = ActivityFeedView.get_events([%{date: date, name: "Event 1", time: 1, note: nil, activity_id: 2}], date)

        assert name ==  "Event 1"
    end

    test "get_events should group by date" do
        {:ok, date} = Ecto.Date.cast({2016, 1, 1})
        event1 = %{date: date, name: "Event 1", time: 1, note: nil, activity_id: 2}

        {_, date2} = Ecto.Date.cast({2016, 1, 1})
        event2 = %{date: date2, name: "Event 2", time: 2, note: nil, activity_id: 3}

        events = ActivityFeedView.get_events([event1, event2], date)

        assert Enum.count(events) == 2
    end

    describe "Getting the day name" do
        test "Should return a capitalized day name" do
            date = Ecto.Date.from_erl({2017, 2, 13})
            name = ActivityFeedView.get_name(date)
            assert name == "Monday"
        end
    end

    describe "Getting the suggestion" do
        test "it should take the name from the first element" do
            suggestion = {%{name: "A"}, 0.5}
            assert ActivityFeedView.get_suggestion(suggestion) == "A"
        end

        test "it should capitalize the name" do
            suggestion = {%{name: "a"}, 0.5}
            assert ActivityFeedView.get_suggestion(suggestion) == "A"
        end
    end

    describe "Showing suggestions" do
        test "it should return true when suggestions are present" do
            assert ActivityFeedView.show_suggestions([{"A", 0.5}]) == true
        end

        test "it should return false when suggestions are not present" do
            assert ActivityFeedView.show_suggestions([]) == false
        end
    end

    describe "Getting the id" do
        test "it should return the id" do
            assert ActivityFeedView.get_id({%{id: 1}, 0.5}) == 1
        end
    end

    describe "Getting the duration" do
        test "it should return the duration" do
            assert ActivityFeedView.get_duration({%{duration: 2}, 0.5}) == 2
        end
    end
end