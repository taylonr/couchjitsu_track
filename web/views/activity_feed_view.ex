defmodule CouchjitsuTrack.ActivityFeedView do
  use CouchjitsuTrack.Web, :view

  def get_date(date) do
    {y, m, d} = Ecto.Date.to_erl(date)
    month = CouchjitsuTrack.Date.get_month(m)

    "#{month} #{d}, #{y}"

  end

  def get_events(events, date) do
      events
      |> Enum.filter(fn e -> e.date == date end)
  end

end
