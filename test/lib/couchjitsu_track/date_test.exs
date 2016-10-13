defmodule DateTest do
    use ExUnit.Case
    
    test "get_date should convert a date to a string" do
        {:ok, date} = Ecto.Date.load({2016, 1, 1})

        assert CouchjitsuTrack.Date.get_date_string(date) == "January 1, 2016"
    end

    test "Should get the month name for the month number" do
        assert CouchjitsuTrack.Date.get_month(1) == "January"
    end
end