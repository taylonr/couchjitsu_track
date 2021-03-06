defmodule CouchjitsuTrack.Activity.Query do
    import Ecto.Query

    alias CouchjitsuTrack.Activity

    @doc """
    Gets all activities for the specified user id
    """
    def get_for_user(user_id) do
        query = from a in Activity,
                where: a.user_id == ^user_id,
                order_by: fragment("LOWER(?)", a.name)
        CouchjitsuTrack.Repo.all(query)
    end
end