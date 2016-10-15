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
        
        "#{y}-#{m}-#{d}"
    end
end