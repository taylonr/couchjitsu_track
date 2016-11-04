defmodule CouchjitsuTrack.UserController do
    use CouchjitsuTrack.Web, :controller

    import CouchjitsuTrack.Category.Query

    alias CouchjitsuTrack.Category

    plug CouchjitsuTrack.Plugs.RequireAuthentication

    def index(conn, _params) do
        user_id = conn.assigns[:current_user].id
        categories = get_categories(user_id)
        unclaimed_activities = get_activities_with_no_category(user_id)

        changeset = Category.changeset(%Category{})

        render conn, "index.html", categories: categories, unclaimed: unclaimed_activities, changeset: changeset, user: user_id
    end

    def create(conn, %{"category" => category}) do
        new_category = Category.changeset(%Category{}, category)
        |> create_category()

        set_category_on_activities(category["activities"], new_category.id)

        redirect(conn, to: "/user")
    end
end