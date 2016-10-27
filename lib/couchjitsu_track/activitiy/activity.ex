defmodule CouchjitsuTrack.Activity do
    use Ecto.Schema

    schema "activities" do
        field :name
        field :user_id, :integer
    end
end