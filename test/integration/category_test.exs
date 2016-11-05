defmodule CategoryIntegrationTests do
    use ExUnit.Case
    import CouchjitsuTrack.Repo
    import CouchjitsuTrack.Category.Query

    alias CouchjitsuTrack.{User, Category, Activity}

    @tag :integration
    test "Getting results by user id should include activities" do
        Ecto.Adapters.SQL.Sandbox.checkout(CouchjitsuTrack.Repo)
        {:ok, user} = insert(%User{name: "Test User"})
        {:ok, category} = insert(%Category{name: "Test category", user: user})
        {:ok, _} = insert(%Activity{name: "test", default_duration: 1.0, category: category})

        categories = get_categories(user.id)
        |> Enum.at(0)

        activity = Enum.at(categories.activities, 0)

        assert activity.name == "test"
    end

    @tag :integration
    test "Getting activites should return activities that don't have a category" do
        Ecto.Adapters.SQL.Sandbox.checkout(CouchjitsuTrack.Repo)
        {:ok, user} = insert(%User{name: "Test User"})
        {:ok, category} = insert(%Category{name: "Test category", user: user})
        insert(%Activity{name: "Assigned Activity", user_id: user.id, default_duration: 1.0, category: category})

        {:ok, _} = insert(%Activity{name: "Unassigned Activity", default_duration: 1.0, user_id: user.id})

        activity = get_activities_with_no_category(user.id)
            |> Enum.at(0)

        assert activity.name == "Unassigned Activity"
    end

end