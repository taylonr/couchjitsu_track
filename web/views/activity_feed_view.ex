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

  def get_name(date) do
      CouchjitsuTrack.Date.get_day_name(date)
      |> String.capitalize
  end

  def get_suggestion(suggestion_and_score) do
    suggestion = elem(suggestion_and_score, 0)

    String.capitalize(suggestion.name)
  end

  def get_id(suggestion_and_score) do
    suggestion = elem(suggestion_and_score, 0)

    suggestion.id
  end

  def show_suggestions(suggestions) when length(suggestions) > 0, do: true
  def show_suggestions(_), do: false

end
