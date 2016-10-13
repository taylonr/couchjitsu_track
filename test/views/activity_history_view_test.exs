defmodule ActivityHistoryViewTest do
    use ExUnit.Case
    alias CouchjitsuTrack.ActivityHistoryView

    test "events should get a list of events for a date" do
        {:ok, date} = Ecto.Date.cast({2016, 1, 1})

        [%{name: name}] = ActivityHistoryView.get_events([%{date: date, name: "Event 1", time: 1, note: nil, activity_id: 2}], date)

        assert name ==  "Event 1"
    end

    test "get_events should group by date" do
        {:ok, date} = Ecto.Date.cast({2016, 1, 1})
        event1 = %{date: date, name: "Event 1", time: 1, note: nil, activity_id: 2}

        {_, date2} = Ecto.Date.cast({2016, 1, 1})
        event2 = %{date: date2, name: "Event 2", time: 2, note: nil, activity_id: 3}

        events = ActivityHistoryView.get_events([event1, event2], date)

        assert Enum.count(events) == 2
    end
end