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

    def get_day_name(%Ecto.Date{} = date) do
        date
        |> Ecto.Date.to_erl
        |> :calendar.day_of_the_week
        |> get_day_name
    end
    def get_day_name(1), do: :monday
    def get_day_name(2), do: :tuesday
    def get_day_name(3), do: :wednesday
    def get_day_name(4), do: :thursday
    def get_day_name(5), do: :friday
    def get_day_name(6), do: :saturday
    def get_day_name(7), do: :sunday
    def get_day_name(_), do: :invalid
end