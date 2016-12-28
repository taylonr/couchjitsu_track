defmodule CouchjitsuTrack.StatisticsView do
    use CouchjitsuTrack.Web, :view

    def total(stats) do
        Enum.reduce(stats, 0, fn(s, acc) -> acc + s.sum end )
    end

    def trend(current, 0), do: ""
    def trend(current, previous) do
        compare(total(current), total(previous))
    end

    defp compare(current, previous) when current > previous, do: "ui arrow up icon"
    defp compare(current, previous) when current < previous, do: "ui arrow down icon"
    defp compare(current, previous), do: ""
end