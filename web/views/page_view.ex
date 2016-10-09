defmodule CouchjitsuTrack.PageView do
  use CouchjitsuTrack.Web, :view

  def events(%{events: events}), do: events
  def events(_conn) do
    [%{date: "October 9", events: [%{name: "Technique", time: "1 hr"}, %{name: "Sparring", time: "1.5 hrs"}]}, %{date: "October 10", events: [%{name: "Judo", time: "1 hr"}]}
    ]
  end
end
