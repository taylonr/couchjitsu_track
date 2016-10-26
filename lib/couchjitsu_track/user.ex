defmodule CouchjitsuTrack.User do
    use Ecto.Schema

    import Ecto.Query
    import Ecto.Changeset

    schema "users" do
        field :oauth_token
        field :name
    end

    def changeset(user, params \\ %{}) do
        user
        |> cast(params, [:name, :oauth_token])
        |> validate_required([:name, :oauth_token])
    end

    def find_by_oauth(token) do
        query = from u in __MODULE__,
                where: u.oauth_token == ^token

        CouchjitsuTrack.Repo.one(query)
    end

    def add(user) do
       {:ok, created_user} = user
        |> changeset
        |> CouchjitsuTrack.Repo.insert

        created_user
    end
end