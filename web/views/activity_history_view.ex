defmodule CouchjitsuTrack.ActivityHistoryView do
  use CouchjitsuTrack.Web, :view

  def get_date(date) do
    {year, month, day} = Ecto.Date.to_erl(date)
    case month do
      1 -> month = "January"
      2 -> month = "Feburary"
      3 -> month = "March"
      4 -> month = "April"
      5 -> month = "May"
      6 -> month = "June"
      7 -> month = "July"
      8 -> month = "August"
      9 -> month = "September"
      10 -> month = "October"
      11 -> month = "November"
      12 -> month = "December"
    end

    "#{month} #{day}, #{year}"

  end

  def get_events(events, date) do
      events
      |> Enum.filter(fn e -> e.date == date end)
      |> Enum.map(fn e -> %{name: e.name, time: e.time, note: e.note} end)
  end

end
