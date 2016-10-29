defmodule ActivityViewTest do
    use ExUnit.Case

    test "When getting color and max is true, should return green inverted" do
        color = CouchjitsuTrack.ActivityView.get_color(%{max: true})
        assert color == "green"
    end

    test "When getting color and min is true, should return red inverted" do
        color = CouchjitsuTrack.ActivityView.get_color(%{min: true})
        assert color == "red"
    end

    test "When getting color and neither max nor min is true, should return empty" do
        color = CouchjitsuTrack.ActivityView.get_color(%{})
        assert color == ""
    end
end