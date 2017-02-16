defmodule DateTest do
    use ExUnit.Case

    import CouchjitsuTrack.Date

    describe "get_date" do
        test "should convert a date to a string" do
            {:ok, date} = Ecto.Date.load({2016, 1, 1})

            assert CouchjitsuTrack.Date.get_date_string(date) == "January 1, 2016"
        end

        test "Should get the month name for the month number" do
            assert CouchjitsuTrack.Date.get_month(1) == "January"
        end
    end

    describe "get_day_name" do
        test "should get :monday when the day number is 1" do
            assert get_day_name(1) == :monday
        end

        test "should get :tuesday when the day number is 2" do
            assert get_day_name(2) == :tuesday
        end

        test "should get :wednesday when the day number is 3" do
            assert get_day_name(3) == :wednesday
        end

        test "should get :thursday when the day number is 4" do
            assert get_day_name(4) == :thursday
        end

        test "should get :friday when the day number is 5" do
            assert get_day_name(5) == :friday
        end

        test "should get :saturday when the day number is 6" do
            assert get_day_name(6) == :saturday
        end

        test "should get :sunday when the day number is 7" do
            assert get_day_name(7) == :sunday
        end

        test "should get :invalid when the day number is anything else" do
            assert get_day_name(8) == :invalid
        end
    end
end