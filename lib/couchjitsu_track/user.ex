defmodule CouchjitsuTrack.User do
    use Ecto.Schema

    import Ecto.Query


    schema "users" do
        field :oauth_token
        field :name
    end

    def changeset(user, params \\ %{}) do
        user
        |> Ecto.Changeset.cast(params, [:name, :oauth_token])
        |> Ecto.Changeset.validate_required([:name, :oauth_token])
    end

    def find_by_oauth(token) do
        query = from u in User,
                where: u.oauth_token == ^token

        CouchjitsuTrack.Repo.one(query)
    end

    def add(user) do
        user
        |> changeset
        |> CouchjitsuTrack.Repo.insert
        |> IO.inspect
    end
end