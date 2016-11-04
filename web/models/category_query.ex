defmodule CouchjitsuTrack.Category.Query do
    import Ecto.Query
    import CouchjitsuTrack.Repo
    alias CouchjitsuTrack.Category
    alias CouchjitsuTrack.Activity

    def get_categories(user_id) do
        activity_query = from a in Activity,
            select: %{name: a.name, id: a.id}

        query = from c in Category,
            where: c.user_id == ^user_id,
            preload: [activities: ^activity_query]

        all(query)
    end

    def get_activities_with_no_category(user_id) do
        query = from a in Activity,
        where: a.user_id == ^user_id and
            is_nil(a.category_id),
        select: %{id: a.id, name: a.name}

        all(query)
    end

    def create_category(category) do
        {:ok, created} = insert(category)

        created
    end

    def set_category_on_activities(activities, category_id) do
        ids = activities
        |> String.split(",")
        |> Enum.map(&String.to_integer/1)

        from(a in Activity, where: a.id in ^ids)
        |> update_all(set: [category_id: category_id])
    end
end