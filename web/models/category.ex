defmodule CouchjitsuTrack.Category do
  use CouchjitsuTrack.Web, :model

  schema "categories" do
    field :name, :string
    belongs_to :user, CouchjitsuTrack.User
    has_many :activities, CouchjitsuTrack.Activity
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
