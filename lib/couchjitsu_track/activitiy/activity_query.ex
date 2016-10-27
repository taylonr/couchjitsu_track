defmodule CouchjitsuTrack.Activity.Query do
    import Ecto.Query

    alias CouchjitsuTrack.Activity

    def get_for_user(user_id) do
        query = from a in Activity,
                where: a.user_id == ^user_id

        CouchjitsuTrack.Repo.all(query)
    end
end