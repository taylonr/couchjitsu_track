defmodule CouchjitsuTrack.ActivityView do
    use CouchjitsuTrack.Web, :view

    def get_month(month) do
        CouchjitsuTrack.Date.get_month(month)
    end

    def get_total(activities) do
        activities
        |> Enum.reduce(0, fn a, acc  -> a.hours + acc end)
    end
end