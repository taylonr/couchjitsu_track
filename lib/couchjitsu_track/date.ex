defmodule CouchjitsuTrack.Date do
    def get_date_string(date) do
        {y, m, d} = Ecto.Date.to_erl(date)
        month = get_month(m)

        "#{month} #{d}, #{y}"
    end

    def get_month(month) do
        case month do
            1 -> "January"
            2 -> "Feburary"
            3 -> "March"
            4 -> "April"
            5 -> "May"
            6 -> "June"
            7 -> "July"
            8 -> "August"
            9 -> "September"
            10 -> "October"
            11 -> "November"
            12 -> "December"
        end
    end

    def today do
        {{y, m, d}, _} = :calendar.local_time()

        "#{y}-#{String.pad_leading("#{m}", 2, "0")}-#{String.pad_leading("#{d}", 2, "0")}"
    end

    def day_name(1), do: "Monday"
    def day_name(2), do: "Tuesday"
    def day_name(3), do: "Wednesday"
    def day_name(4), do: "Thursday"
    def day_name(5), do: "Friday"
    def day_name(6), do: "Saturday"
    def day_name(7), do: "Sunday"
    def day_name(_), do: {:error, "Invalid day number"}
end