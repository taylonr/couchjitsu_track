defmodule CouchjitsuTrack.Activity do
    use Ecto.Schema
    import Ecto.Changeset

    schema "activities" do
        field :name
        field :user_id, :integer
        field :default_duration, :float
    end

    @required_fields ~w(name user_id)
    @optional_fields ~w(default_duration)

    def changeset(activity, params \\ %{}) do
        activity
        |> cast(params, @required_fields, @optional_fields)
        |> validate_required([:name, :user_id])
    end

    def add(activity) do
        {:ok, created_activity} = CouchjitsuTrack.Repo.insert(activity)

        created_activity
    end
end