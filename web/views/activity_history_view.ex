defmodule CouchjitsuTrack.ActivityHistoryView do
  use CouchjitsuTrack.Web, :view

  def get_date(date) do
    {year, month, day} = Ecto.Date.to_erl(date)
    month =
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

    "#{month} #{day}, #{year}"

  end

  def get_events(events, date) do
      events
      |> Enum.filter(fn e -> e.date == date end)
      |> Enum.map(fn e -> %{name: e.name, time: e.time, note: e.note, activity_id: e.activity_id} end)
  end

end
