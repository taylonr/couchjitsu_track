defmodule CouchjitsuTrack.ActivityHistoryView do
  use CouchjitsuTrack.Web, :view

  def get_date(date_time) do
    Ecto.DateTime.to_date(date_time)
  end

  def get_events(events, date) do
      events
      |> Enum.filter(fn e -> get_date(e.date) == get_date(date) end)
      |> Enum.map(fn e -> %{name: e.name, time: e.time, note: e.note} end)
  end

  def events(%{events: events}), do: events
  def events(events) do
      events
    # [%{date: "October 9", events: [%{name: "Technique", time: "1 hr"}, %{name: "Sparring", time: "1.5 hrs"}]}, %{date: "October 10", events: [%{name: "Judo", time: "1 hr"}]}
    # ]
  end
end
