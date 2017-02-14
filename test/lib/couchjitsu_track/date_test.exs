defmodule DateTest do
    use ExUnit.Case

    alias CouchjitsuTrack.Date

    test "get_date should convert a date to a string" do
        {:ok, date} = Ecto.Date.load({2016, 1, 1})

        assert Date.get_date_string(date) == "January 1, 2016"
    end

    test "Should get the month name for the month number" do
        assert Date.get_month(1) == "January"
    end

    test "Day of week should convert 1 to Monday" do
        assert Date.day_name(1) == "Monday"
    end

    test "Day of week should convert 2 to Tuesday" do
        assert Date.day_name(2) == "Tuesday"
    end

    test "Day of week should convert 3 to Wednesday" do
        assert Date.day_name(3) == "Wednesday"
    end

    test "Day of week should convert 4 to Thursday" do
        assert Date.day_name(4) == "Thursday"
    end

    test "Day of week should convert 5 to Friday" do
        assert Date.day_name(5) == "Friday"
    end

    test "Day of week should convert 6 to Saturday" do
        assert Date.day_name(6) == "Saturday"
    end

    test "Day of week should convert 7 to Sunday" do
        assert Date.day_name(7) == "Sunday"
    end

    test "Day of week greater than 7 should return an error" do
        assert Date.day_name(8) == {:error, "Invalid day number"}
    end
end