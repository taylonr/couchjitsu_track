defmodule ActivityQueryTest do
    use ExUnit.Case

    import Mock
    alias CouchjitsuTrack.Activity

    test "Should get all activities for a user" do
        with_mock CouchjitsuTrack.Repo, [all: fn(_) -> [%Activity{name: "Test"}] end] do
            activities = CouchjitsuTrack.Activity.Query.get_for_user(1)

            assert activities == [%Activity{name: "Test"}]
        end
    end
end