defmodule CouchjitsuTrack.ActivityView do
    use CouchjitsuTrack.Web, :view

    def get_month(month) do
        CouchjitsuTrack.Date.get_month(month)
    end

    def get_total(activities) do
        activities
        |> Enum.reduce(0, fn a, acc  -> a.hours + acc end)
    end

    def get_color(activity) do
        case activity do
            %{max: true} -> "green"
            %{min: true} -> "red"
            _ -> ""
        end
    end
end