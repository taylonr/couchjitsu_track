defmodule ActivityHistoryViewTest do
    use ExUnit.Case
    alias CouchjitsuTrack.ActivityHistoryView

    test "get_date should convert from a date time to a date string" do
        {:ok, date} = Ecto.DateTime.load({{2016, 1, 1}, {12, 00, 00, 00}})
        {:ok, new_date} = Ecto.Date.load({2016, 1, 1})

        assert ActivityHistoryView.get_date(date) == new_date
    end

    test "events should get a list of events for a date" do
        {:ok, date} = Ecto.DateTime.cast({{2016, 1, 1}, {12, 00, 00, 00}})

        events = ActivityHistoryView.get_events([%{date: date, name: "Event 1"}], Ecto.DateTime.cast({{2016, 1, 1}, {12, 00, 00, 00}}))

        assert events == [%{name: "Event 1"}]
    end

    test "get_events should group by date" do
        {:ok, date} = Ecto.DateTime.cast({{2016, 1, 1}, {12, 00, 00, 00}})
        event1 = %{date: date, name: "Event 1"}

        {_, date2} = Ecto.DateTime.cast({{2016, 1, 1}, {20, 00, 00, 00}})
        event2 = %{date: date2, name: "Event 2"}

        events = ActivityHistoryView.get_events([event1, event2], Ecto.DateTime.cast({{2016, 1, 1}, {12, 00, 00, 00}}))

        assert events == [%{name: "Event 1"}, %{name: "Event 2"}]
    end
end